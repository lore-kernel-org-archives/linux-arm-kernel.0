From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 20:01:48 +0000
Subject: Pull request: Orion fixes.
In-Reply-To: <20120725192613.GA18714@lunn.ch>
References: <20120725192613.GA18714@lunn.ch>
Message-ID: <201207252001.48360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Andrew Lunn wrote:
> Hi Arnd
> 
> Here is a branch with just the fixes.
> 
> I changed the commit comment from Hanns Reinecke from mach-dove: to
> ARM: Dove: which was one of the things you pointed out in your first
> email. 
> 
> As i expected, i had to split the "Replace mrvl with marvell"
> patch. It contained fixes for development work during this cycle in addition to the fixes for v3.5-rc7.
> 
> Boot tested on kirkwood, compile tested for dove.

Ok, excellent. I've pulled them into the "fixes" branch now.

One more thing: when sending pull requests, always keep them with Cc
to linux-arm-kernel and to both Olof and me, so that one of us can
handle them when the other one is not there.

	Arnd


> The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:
> 
>   Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)
> 
> are available in the git repository at:
> 
>   git at github.com:lunn/linux.git v3.5-rc7-fixes
> 
> for you to fetch changes up to 778435045a416da71f1757a80e37200a5ea5af70:
> 
>   ARM: Kirkwood: Replace mrvl with marvell (2012-07-25 17:06:23 +0200)
> 
> ----------------------------------------------------------------
> Andrew Lunn (2):
>       ARM: Kirkwood: Ensure runit clock always ticks.
>       ARM: Kirkwood: Replace mrvl with marvell
> 
> Hannes Reinecke (1):
>       ARM: Dove: Fixup ge00 initialisation
> 
> Simon Baatz (2):
>       ARM: Kirkwood: Fix PHY disable clk problems
>       ARM: Orion: fix driver probe error handling with respect to clk
> 
>  .../devicetree/bindings/mtd/orion-nand.txt         |    4 +-
>  arch/arm/boot/dts/kirkwood-dns320.dts              |    2 +-
>  arch/arm/boot/dts/kirkwood-dns325.dts              |    2 +-
>  arch/arm/boot/dts/kirkwood-dreamplug.dts           |    2 +-
>  arch/arm/boot/dts/kirkwood-ib62x0.dts              |    2 +-
>  arch/arm/boot/dts/kirkwood-iconnect.dts            |    2 +-
>  arch/arm/boot/dts/kirkwood.dtsi                    |    6 +-
>  arch/arm/mach-dove/common.c                        |    4 +-
>  arch/arm/mach-kirkwood/common.c                    |   70 +++++++++++++++-----
>  drivers/crypto/mv_cesa.c                           |    4 ++
>  drivers/mmc/host/mvsdio.c                          |    4 ++
>  drivers/mtd/nand/orion_nand.c                      |    6 +-
>  drivers/net/ethernet/marvell/mv643xx_eth.c         |    6 ++
>  drivers/rtc/rtc-mv.c                               |    2 +-
>  drivers/usb/host/ehci-orion.c                      |    4 ++
>  sound/soc/kirkwood/kirkwood-i2s.c                  |    8 ++-
>  16 files changed, 98 insertions(+), 30 deletions(-)
> 
