From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 11 Mar 2012 22:36:32 -0400
Subject: [PATCH 0/2] Add support for DNS-320 and DNS-325 using devicetree
In-Reply-To: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120312023632.GW5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 02:33:24PM +0000, Jamie Lentin wrote:
> As agreed with Arnd Bergmann and Jason Cooper, include any board setup that
> cannot be done in devicetree in board-dt.c, then replace with devicetree
> entries.
> 
> The NAND driver is converted to devicetree as part of this patch series, 
> although I don't feel qualified to explain the parameters actually mean so 
> have left documentation fields blank.

Thanks!

> The patches should apply cleanly to staging/kirkwood/dt, although 
> kirkwood-dns320.dts attempts to override the orion-wdt definition with a
> lower TCLK, even though the orion-wdt work isn't merged yet. If this would
> be better to remove I shall.

It would be better if you base off of my stable branch.  You won't have
the clock issues (wdt isn't merged there yet).  Also, my staging branch
has been in flux and will soon be renamed/removed.

> Cheers,
> 
> Jamie Lentin (2):
>   ARM: kirkwood: Basic support for DNS-320 and DNS-325
>   ARM: kirkwood: Convert orion-nand to fdt
> 
>  .../devicetree/bindings/mtd/orion-nand.txt         |   41 +++
>  arch/arm/boot/dts/kirkwood-dns320.dts              |   96 +++++++
>  arch/arm/boot/dts/kirkwood-dns325.dts              |   82 ++++++
>  arch/arm/mach-kirkwood/Kconfig                     |   18 ++
>  arch/arm/mach-kirkwood/Makefile.boot               |    2 +
>  arch/arm/mach-kirkwood/board-dt.c                  |  264 ++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.c                    |    6 +
>  drivers/mtd/nand/orion_nand.c                      |   39 +++-
>  8 files changed, 546 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
>  create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
> 
> -- 
> 1.7.9.1
> 
