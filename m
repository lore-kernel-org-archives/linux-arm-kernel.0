From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Nov 2015 12:02:46 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.5
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <20151124030246.GL21853@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 05:05:25PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.5.
> 
> 
> The following changes since commit 99f7445ea41c0187cd2e78bcb58cdd9e6c1756e5:
> 
>   ARM: shmobile: porter: enable internal PCI and USB PHY (2015-10-13 10:00:12 +0900)
> 
> are available in the git repository at:

The above is commit is the head of the last pull request I sent for
Renesas DT updates for v4.4, taged as renesas-dt2-for-v4.4. Someohow it
was not rebased on top of v4.4-rc1 although that was my intention.

I don't think it should make any difference but if you would like me to
rebase and repost please let me know.

>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.5
> 
> for you to fetch changes up to d537543b3948bc3bc9dede248fa455493e055457:
> 
>   ARM: shmobile: alt: add VIN0, ADV7180 DT support (2015-11-18 09:10:38 -0800)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.5
> 
> * henninger: Remove as it is now replaced by silk
> * koelsch: Move SPI partitions to subnode
> * porter: Add CAN0 and HS-USB support
> * r8a7793/gose: Add QSPI, PFC support
> * r8a7793: Add GPIO, DMAC, theral, IPMMU support
> * r8a7794/alt: Add DU support
> * r8a7794: Disable all IPMMU nodes by default
> * r8a779[0134]: Use Use SoC specific binding for rcar-dmac
> * r8a779[01], r8a73a4, r8a7740, sh73a0: replace gpio-key, wakeup with
>   wakeup-source property
> * r8a779[14]: Correct "gpio-ranges" properties
> * r8a779[14]: Remove bogus imp_clk node
> * silk: Add SDHI1 support
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (3):
>       ARM: shmobile: r8a7794 dtsi: Remove bogus imp_clk node
>       ARM: shmobile: r8a7791 dtsi: Remove bogus imp_clk node
>       ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
> 
> Laurent Pinchart (2):
>       ARM: shmobile: r8a7794: Add DU0 clock
>       ARM: shmobile: r8a7794: Add DU node to device tree
> 
> Magnus Damm (4):
>       ARM: shmobile: r8a7794: Disable all IPMMU nodes by default
>       ARM: shmobile: r8a7793: Add IPMMU nodes
>       ARM: shmobile: r8a7794: alt: Enable VGA port
>       ARM: shmobile: r8a7793: Add GPIO nodes to device tree
> 
> Sergei Shtylyov (6):
>       ARM: shmobile: porter: add HS-USB DT support
>       ARM: shmobile: silk: add SDHI1 DT support
>       ARM: shmobile: r8a7790: fix "gpio-ranges" props
>       ARM: shmobile: r8a7791: fix "gpio-ranges" props
>       ARM: shmobile: porter: add CAN0 DT support
>       ARM: shmobile: henninger: remove board DT
> 
> Simon Horman (11):
>       ARM: shmobile: r8a7793: Add thermal device to DT
>       ARM: shmobile: r8a7793: Add PFC to DT
>       ARM: shmobile: gose: Configure PFC in DT
>       ARM: shmobile: r8a7793: Add DMAC devices to DT
>       ARM: shmobile: r8a7793: Add QSPI device to DT
>       ARM: shmobile: gose: Add QSPI device to DT
>       ARM: shmobile: r8a7790: Use SoC specific binding for rcar-dmac nodes
>       ARM: shmobile: r8a7791: Use SoC specific binding for rcar-dmac nodes
>       ARM: shmobile: r8a7793: Use SoC specific binding for rcar-dmac nodes
>       ARM: shmobile: r8a7794: Use SoC specific binding for rcar-dmac nodes
>       ARM: shmobile: alt: Add pfc pins to DT
> 
> Sudeep Holla (1):
>       ARM: dts: shmobile/r8a7xxx: replace gpio-key, wakeup with wakeup-source property
> 
> Ulrich Hecht (2):
>       ARM: shmobile: alt: add I2C1 DT support
>       ARM: shmobile: alt: add VIN0, ADV7180 DT support
> 
>  arch/arm/boot/dts/Makefile                    |   1 -
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts         |   2 +-
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts |   2 +-
>  arch/arm/boot/dts/r8a7790-lager.dts           |   8 +-
>  arch/arm/boot/dts/r8a7790.dtsi                |  12 +-
>  arch/arm/boot/dts/r8a7791-henninger.dts       | 320 --------------------------
>  arch/arm/boot/dts/r8a7791-koelsch.dts         |  55 ++---
>  arch/arm/boot/dts/r8a7791-porter.dts          |  20 ++
>  arch/arm/boot/dts/r8a7791.dtsi                |  18 +-
>  arch/arm/boot/dts/r8a7793-gose.dts            |  74 ++++++
>  arch/arm/boot/dts/r8a7793.dtsi                | 294 +++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7794-alt.dts             | 125 ++++++++++
>  arch/arm/boot/dts/r8a7794-silk.dts            |  40 ++++
>  arch/arm/boot/dts/r8a7794.dtsi                |  49 ++--
>  arch/arm/boot/dts/sh73a0-kzm9g.dts            |   2 +-
>  include/dt-bindings/clock/r8a7794-clock.h     |   1 +
>  16 files changed, 637 insertions(+), 386 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/r8a7791-henninger.dts
> 
