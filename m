From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 11:26:16 +0100
Subject: [GIT PULL] Allwinner DT additions for 3.15
Message-ID: <20140303102616.GA28988@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof, 

Please pull the following pull request.

Thanks!

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.15

for you to fetch changes up to 225b02163cd51b6d5ebef4d2e19a09345f2ee3a5:

  ARM: sun6i: dt: Fix mod0 compatible (2014-02-28 12:04:53 +0100)

----------------------------------------------------------------
Allwinner DT patches for 3.15, take 1:
  - Add SPI controllers for all the SoCs
  - Add various missing aliases
  - Add USB clocks nodes
  - Addition of the GMAC support
  - Introduction of the pcDuino board
  - A few DT cleanup patches: change of compatibles,

----------------------------------------------------------------
Chen-Yu Tsai (12):
      ARM: dts: sun7i: add pin muxing options for UART2
      ARM: dts: sun4i: rename clock node names to clk at N
      ARM: dts: sun5i: rename clock node names to clk at N
      ARM: dts: sun6i: rename clock node names to clk at N
      ARM: dts: sun7i: rename clock node names to clk at N
      ARM: dts: sun7i: Add GMAC clock node to sun7i DTSI
      ARM: dts: sun7i: Add GMAC controller node to sun7i DTSI
      ARM: dts: sun7i: Add pin muxing options for the GMAC
      ARM: dts: sun7i: cubietruck: Enable the GMAC
      ARM: dts: sun7i: cubieboard2: Enable GMAC instead of EMAC
      ARM: dts: sun7i: a20-olinuxino-micro: Enable GMAC instead of EMAC
      ARM: dts: sun7i: Add ethernet alias for GMAC

Hans de Goede (1):
      ARM: sun4i: dt: Remove grouping + simple-bus compatible for regulators

Marc Zyngier (1):
      ARM: sun7i: add arch timer node

Maxime Ripard (15):
      ARM: sun4i: a10: Add missing serial aliases
      ARM: sun5i: a10s: Add missing serial aliases
      ARM: sun6i: Add missing serial aliases
      ARM: sun7i: Add missing serial aliases
      ARM: sun5i: a13: Add missing serial aliases
      ARM: sun6i: dt: Add PLL6 and SPI module clocks
      ARM: sun6i: dt: Add SPI controllers to the A31 DTSI
      ARM: sunxi: dt: Convert to the new clock compatibles
      ARM: dt: sun7i: Add A20 SPI controller nodes
      ARM: dt: sun4i: Add A10 SPI controller nodes
      ARM: dt: sun5i: Add A10s SPI controller nodes
      ARM: dt: sun5i: Add A13 SPI controller nodes
      ARM: dt: sun7i: Add SPI muxing options
      ARM: dts: sun7i: Enable the SPI controllers of the A20-olinuxino-micro
      ARM: sun6i: dt: Fix mod0 compatible

Roman Byshko (3):
      ARM: sun4i: dt: Add bindings for USB clocks
      ARM: sun5i: dt: Add bindings for USB clocks
      ARM: sun7i: dt: Add bindings for USB clocks

Zoltan HERPAI (1):
      ARM: sun4i: dt: Add basic board support for LinkSprite pcDuino

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |  22 +--
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       |  18 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |  48 +++++
 arch/arm/boot/dts/sun4i-a10.dtsi                | 149 +++++++++++----
 arch/arm/boot/dts/sun5i-a10s.dtsi               | 124 ++++++++----
 arch/arm/boot/dts/sun5i-a13.dtsi                | 125 ++++++++----
 arch/arm/boot/dts/sun6i-a31.dtsi                | 125 ++++++++++--
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  27 ++-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |  12 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  30 ++-
 arch/arm/boot/dts/sun7i-a20.dtsi                | 240 ++++++++++++++++++++----
 12 files changed, 711 insertions(+), 210 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-pcduino.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/39b10b44/attachment.sig>
