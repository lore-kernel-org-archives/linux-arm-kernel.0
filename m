From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 25 Oct 2012 18:38:05 +0300
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add
 read_reset_sources pdata function pointer
In-Reply-To: <20121016013213.21844.20016.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
Message-ID: <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 15, 2012 at 07:32:33PM -0600, Paul Walmsley wrote:
> The OMAP watchdog timer driver directly calls a function exported by
> code in arch/arm/mach-omap2.  This is not good; it tightly couples
> this driver to the mach-omap2 integration code.  Instead, add a
> temporary platform_data function pointer to abstract this function
> call.  A subsequent patch will convert the watchdog driver to use this
> function pointer.

Why a function is needed? Reset cause won't change until the next reset,
so it should be enough to read it once during the init and store it into
the platform data.

A.
