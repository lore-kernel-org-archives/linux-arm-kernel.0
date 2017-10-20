From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Oct 2017 10:00:21 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.15
Message-ID: <20171020080021.bsumte7ppspgrtln@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are the arm32 DT changes for the next merge window. Due to
conflicts, it is based on the fixes tag I sent previously.

Thanks!
Maxime

The following changes since commit a231d2783c332ef3e3ba238e82dbe599ff41ba14:

  ARM: dts: sun6i: Fix endpoint IDs in second display pipeline (2017-09-17 12:03:59 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.15

for you to fetch changes up to 1357bdb21f2af1e62b8858488a7bccd0fea63e69:

  ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra (2017-10-20 09:51:35 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.15

The most notable changes are:
  - Conversion to the last SoC (A10, A20) to the new clock framework
  - HDMI and dual pipeline support for the A10, A20 and A31 DRM driver
  - Support for the various power supplies on a number of boards
  - Fix of DTC warnings on a number of SoCs, but most of them still need
    some work
  - New boards: A20-OLinuXino-MICRO-eMMC, TBS A711, Banana Pi M2 Berry,
    Banana Pi M2 Ultra

----------------------------------------------------------------
Chen-Yu Tsai (9):
      ARM: dts: sun6i: Add cross pipeline connections between DRCs and TCONs
      ARM: dts: sun8i: Add basic dtsi file for Allwinner R40
      ARM: dts: sun8i: Add board dts file for Banana Pi M2 Ultra
      ARM: dts: sun6i: Add device node for HDMI controller
      ARM: dts: sun6i: Enable HDMI support on some A31/A31s devices
      ARM: dts: sun5i: reference-design-tablet: Enable AXP209 AC and battery
      ARM: dts: sun4i: Add device nodes for display pipelines
      ARM: dts: sun7i: Enable HDMI support on some A20 devices
      ARM: dts: sun4i: Enable HDMI support on some A10 devices

Corentin LABBE (5):
      ARM: dts: sunxi: h3/h5: Fix simple-bus unit address format error
      ARM: dts: sunxi: h3/h5: Fix i2c2 register address
      ARM: dts: sunxi: h3/h5: Fix node with unit name and no reg property
      ARM: dts: sun8i: h3: Fix node with unit name and no reg property
      ARM: dts: sun8i: a83t: Fix simple-bus unit address format error

Harald Geyer (1):
      ARM: dts: sun7i: Enable power supplies on A20-OLinuxIno-Micro

Icenowy Zheng (7):
      ARM: sun7i: a20: enable ac/battery power supplies for Lamobo R1 board
      ARM: dts: sun8i: Add board dts file for Banana Pi M2 Berry
      ARM: dts: sun8i: r40: add watchdog device node
      ARM: sun8i: r40: add USB host port nodes for R40
      ARM: sun8i: r40: add 5V regulator for Banana Pi M2 Ultra
      ARM: sun8i: v40: add 5V regulator for Banana Pi M2 Berry
      ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra

Jonathan Liu (1):
      ARM: dts: sun7i: Add device nodes for display pipelines

Marcus Cooper (2):
      ARM: dts: sun6i: a31: Add DAI nodes
      ARM: dts: sunxi: h3/h5: Add DAI nodes

Maxime Ripard (24):
      arm: dts: sun8i: a83t: Remove useless, empty nodes
      arm: dts: sun8i: a83t: Add MMC1 pins
      arm: dts: sun8i: a83t: Add the UART1 controller
      arm: dts: sun8i: Add the TBS A711 tablet devicetree
      ARM: dts: sunxi: Remove leading zeros from unit-addresses
      ARM: dts: axp209: Rename usb_power_supply node to avoid warnings
      ARM: dts: sun4i: Change framebuffer node names to avoid warnings
      ARM: dts: sun4i: Change clock node names to avoid warnings
      ARM: dts: sun4i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun4i: Rename thermal nodes to avoid warnings
      ARM: dts: sun4i: Remove all useless pinctrl nodes
      ARM: dts: sun9i: Remove skeleton to avoid warnings
      ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid warnings
      ARM: dts: sun9i: Rename pinctrl nodes to avoid warnings
      ARM: dts: sun9i: optimus: Remove card detect pull-up
      ARM: dts: sun9i: cubieboard4: Remove card detect pull-up
      ARM: dts: sun4i: Remove gpio-keys warnings
      ARM: dts: sun4i: Remove skeleton and memory to avoid warnings
      ARM: dts: sun4i: Change LRADC node names to avoid warnings
      ARM: dts: sun4i: Change pinctrl nodes to avoid warning
      ARM: dts: sun4i: Provide default muxing for relevant controllers
      ARM: dts: sun4i: Remove underscores from nodes names
      ARM: dts: sun9i: Change node names to remove underscores
      ARM: dts: sun9i: Change node names to remove underscores

Philipp Rossak (6):
      ARM: dts: sun8i: h3: nanopi-m1: Enable IR controller
      ARM: dts: sun8i: h3: nanopi-m1-plus: Enable IR controller
      ARM: dts: sun8i: h3: Adding UART3 RTS and CTS Pins
      ARM: dts: sun8i: h3: Enable AP6212 BT on uart3 on Nanopi M1 Plus
      ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on Nanopi M1 Plus
      ARM: dts: sun8i: h3: Fix Pincrtl bindings on Bananapi M2 Plus

Priit Laes (3):
      ARM: dts: sun7i: Convert to CCU
      ARM: dts: sun4i: Convert to CCU
      ARM: dts: sun4i: Add i2s0 block to dtsi

Stefan Mavrodiev (2):
      ARM: dts: sun7i: Add dts file for A20-OLinuXino-MICRO-eMMC
      ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for LAN8710

Tomas Novotny (1):
      dt-bindings: add vendor prefix for Touchless Biometric Systems AG

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    6 +-
 arch/arm/boot/dts/axp209.dtsi                      |    2 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   28 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   16 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |   20 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   45 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |   50 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   23 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   24 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   10 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |   36 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |   24 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   68 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |   21 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   26 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   25 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   10 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   24 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |    6 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |   47 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   32 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts           |    9 -
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |   43 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 1166 +++++++++-----------
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |    6 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |    4 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                   |    8 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |    8 +
 arch/arm/boot/dts/sun5i.dtsi                       |   82 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |   21 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  209 +++-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |   25 +
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   25 +
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |   25 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |   25 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   25 +
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   33 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |   25 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   25 +
 .../boot/dts/sun7i-a20-olinuxino-micro-emmc.dts    |   70 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   44 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 1144 ++++++++-----------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   62 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                   |    4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   18 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |  199 ++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   39 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |   20 -
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |   42 +
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |    6 +
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |    8 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |    8 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |    6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |    6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |    6 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |    2 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  209 ++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  473 ++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |   32 +-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  173 +++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |   30 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |   50 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  117 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  115 +-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi     |    4 -
 66 files changed, 3026 insertions(+), 2169 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r40.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/021d79b5/attachment.sig>
