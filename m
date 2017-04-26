From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 09:36:01 +0200
Subject: [PATCH/RFC 0/2] clk / soc: renesas: Rework Kconfig and Makefile
 logic
In-Reply-To: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
References: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170426073601.GF25517@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 06:27:04PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This RFC patch series reworks the Kconfig and Makefile logic for the
> Renesas clock and SoC drivers. It was sparked by a discussion with Olof
> about the Renesas clock driver dependencies.
> 
> The goals are to:
>   - Allow precise control over and automatic selection of which
>     (sub)drivers are used for which SoC (which may change in the
>     future),
>   - Allow adding support for new SoCs easily,
>   - Allow compile-testing of all (sub)drivers,
>   - Keep driver selection logic in the subsystem-specific Kconfig
>     independent from the architecture-specific Kconfig (i.e. no "select"
>     from arch/arm64/Kconfig.platforms), to avoid dependencies.
> 
> The series can't be applied as-is, because compile-testing all drivers
> depends on independent fixes, some in other subsystems.
> 
> More details are provided in the individual patch descriptions.
> 
> For testing, this patch series, plus several fixes to allow more
> compile-testing, are available in the
> topic/clk-soc-renesas-Kconfig-rework branch of my renesas-drivers git
> repository at 
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> 
> This has been tested on R-Car Gen2 and Gen3, and compile-tested for
> various other configurations.
> 
> Thanks for your comments!

Hi Geert,

thanks for working on this. I am very pleased to see something that
is more robust with regards to adding new platforms without causing
build breakage - I have been burnt by this several times.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
