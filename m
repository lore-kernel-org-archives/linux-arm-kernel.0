From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Mar 2011 12:49:32 +0100
Subject: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
In-Reply-To: <20110324212729.14936.98130.stgit@otae.warmcat.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
	<20110324212729.14936.98130.stgit@otae.warmcat.com>
Message-ID: <201103251249.32578.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2011, Andy Green wrote:
> Introduce a generic helper function that can set a MAC address using
> data from the OMAP unique CPU ID register.
> 
> For comparison purposes this produces a MAC address of
> 
>   2e:40:70:f0:12:06
> 
> for the ethernet device on my Panda.
> 
> 
> Note that this patch requires the fix patch for CPU ID register
> indexes previously posted to linux-omap, otherwise the CPU ID is
> misread on Panda by the existing function to do it.  This patch
> is already on linux-omap.
> 
> "OMAP2+:Common CPU DIE ID reading code reads wrong registers for OMAP4430"
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=b235e007831dbf57710e59cd4a120e2f374eecb9
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

TI folks: While this is a working solution, I still think it would
be good to get an officially sanctioned method that allows the creation
of a IEEE 802 MAC address in a range assigned to TI instead of using
an address from the locally administered range.

Is that something that can be done?

	Arnd
