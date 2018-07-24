From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 15:08:16 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.19
Message-ID: <20180724130816.mrqr42l2ph2tme2k@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.19

for you to fetch changes up to c0476a31fb381e02637549bfe45632a4140dd201:

  ARM: dts: sun4i: Add GPU node (2018-07-24 14:52:44 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.19

There's a number of additions for the ARMv7 SoCs for this merge window, and
especially:

  - Addition of the system controller for a number of SoCs, as part of the
    VPU effort
  - Addition of the R40 HDMI support
  - Addition of the Mali GPU node for the A10

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun8i: a83t: Add CPU regulator supplies for A83T boards

Corentin Labbe (3):
      dt-bindings: net: dwmac-sun8i: Remove unused address-cells/size-cells
      ARM: dts: sun8i: a83t: Remove unused address-cells/size-cells of dwmac-sun8i
      ARM: dts: sun8i: r40: Remove unused address-cells/size-cells of dwmac-sun8i

Jernej Skrabec (7):
      ARM: dts: sun8i: r40: Add HDMI pipeline
      ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra
      ARM: dts: sun8i: r40: Remove fallback display engine compatible
      ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
      ARM: dts: sun8i: r40: Remove fallback compatible for TCON TV
      ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON connections
      ARM: dts: sun8i: r40: Disable TCONs by default.

Maxime Ripard (4):
      ARM: dts: sun5i: Add support for the C1 SRAM region with the SRAM controller
      ARM: dts: sun7i: Add support for the C1 SRAM region with the SRAM controller
      ARM: dts: sun8i: a23-a33: Add SRAM controller node and C1 SRAM region
      ARM: dts: sun5i: Fix the SRAM A3-A4 declaration

Paul Kocialkowski (4):
      ARM: dts: sun4i: Switch to new system control compatible string
      ARM: dts: sun5i: Use most-qualified system control compatibles
      ARM: dts: sun7i: Use most-qualified system control compatibles
      ARM: dts: sun8i: h3: Add SRAM controller node and C1 SRAM region

Steven Vanden Branden (1):
      ARM: dts: sun4i: Add GPU node

Viresh Kumar (1):
      ARM: dts: sunxi: Add missing cooling device properties for CPUs

 .../devicetree/bindings/net/dwmac-sun8i.txt        |   8 -
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  25 +-
 arch/arm/boot/dts/sun5i.dtsi                       |  32 ++-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  30 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  38 ++-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  22 ++
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   9 +
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |   8 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |   8 +
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |   8 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   2 -
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  22 ++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  29 ++
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 319 ++++++++++++++++++++-
 14 files changed, 534 insertions(+), 26 deletions(-)

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/91eead1b/attachment.sig>
