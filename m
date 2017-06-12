From: horms@verge.net.au (Simon Horman)
Date: Mon, 12 Jun 2017 11:10:20 +0200
Subject: [PATCH 0/4] arm64: renesas: Add support for Salvator-XS
In-Reply-To: <1497008629-3974-1-git-send-email-geert+renesas@glider.be>
References: <1497008629-3974-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170612091019.GC15434@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 01:43:45PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> The Renesas Salvator-XS (Salvator-X 2nd version) development board can
> be equipped with either an R-Car H3 ES2.0 or M3-W ES1.x SiP, which are
> pin-compatible.
> 
> This patch series adds initial support for the Renesas Salvator-XS
> development board equipped with an R-Car H3 ES2.0 SiP.  The support
> level is similar to the existing support for Salvator-X with the same
> SiP.  See below for exceptions.
> 
> The Salvator-XS board is similar but not identical to the already
> supported Salvator-X board.  To avoid duplication, the common parts are
> extracted first into its own .dtsi file.
> Noteworthy differences are:
>   - The main clock crystal ticks at a slightly different rate.
>   - On R-Car H3 ES2.0, SATA no longer uses dedicated pins, but shares
>     them with the second PCIe channel.  To cater for this, a MAX4888B
>     multiplexer has been added to Salvator-XS.  As the default hardware
>     configuration enables PCIe, I disabled SATA.
>   - The Versaclock5 clock generator has been replaced by a similar
>     member of the Versaclock6 family.  As the latter is not supported by
>     Linux yet, I left it out.
>   - The USB3.0 micro-B connector is replaced by a USB2.0 micro-AB
>     connector (both are not yet supported, so no change is needed now).
> 
> Dependencies:
>   - renesas-devel-20170608-v4.12-rc4,
>   - "arm64: dts: salvator-x: Add missing index to PWM pinctrl subnode
>     name".
> 
> For your convenience, I've pushed this series, its dependencies, and a
> few related driver changes to the topic/r8a7795-salvator-xs branch of
> the git repository at
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> 
> This has been tested on Salvator-XS with R-Car H3 ES2.0, and Salvator-X
> with R-Car H3 ES1.0.
> 
> Thanks!

Thanks, I have queued this up for v4.13.
