From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Dec 2017 14:24:44 +0800
Subject: [GIT PULL 1/3] Allwinner DT changes for 4.16
Message-ID: <20171228062444.GA3883@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are the changes for 4.16 for Allwinner stuff. There are 3 separate
pull requests. There are no dependencies between them.

I might queue up some more patches that have been sitting around the
mailing lists and have seen enough review, let them simmer in -next
for a few days, before sending a second round of pull requests.
Just a heads up. I might not get around to doing it.

ChenYu

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.16

for you to fetch changes up to 2ce3dc66d75fc204cc42bc4ee9c6f612ef4a8949:

  ARM: dts: sun8i: h3: nanopi-m1-plus: fix missing ethernet 0 in aliases (2017-12-19 09:54:46 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.16

A random assortment of improvements.

GPIO device nodes are added for the AXP813/AXP818 PMICs, meaning we can
finally use the GPIO pins on the PMICs. The LDOs on the GPIO pins can
also be properly muxed and guarded.

EMAC Ethernet support is enabled for more H3 boards, and also for the
A83T, following the return of the bindings in 4.15, after a last minute
revert in 4.13. This will make the H3/A83T boards much more useful in
headless applications.

Two new boards are introduced. The Orange Pi R1 is a small board with
two Ethernet interfaces (one EMAC-based and one USB-based) and a WiFi
chip. This board is fully supported, with the exception of TV-out on
the expansion header, which will not be enabled by default. The WiFi
chip (RTL8189FTV) requires an out-of-tree driver. The Libre Computer
Board ALL-H3-CC H3 version is a newcomer to the Allwinner SBC space,
which was mostly represented by a bunch of fruit-Pis. It is mostly
supported, with the exception of HDMI and camera sensor interface,
which have not been implemented yet.

Two minor patches enable the audio codec on the A13 Olinuxino, and
HDMI output on the pcDuino3 Nano.

----------------------------------------------------------------
Chen-Yu Tsai (4):
      ARM: dts: sun8i: h3: Add dts file for Libre Computer Board ALL-H3-CC H3 ver.
      ARM: dts: sun8i: a83t: Enable Ethernet on two boards
      ARM: dts: sun8i: a83t: Add I2S controller device nodes
      ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings

Corentin LABBE (1):
      ARM: dts: sun8i: a83t: add dwmac-sun8i device node

Corentin Labbe (1):
      ARM: dts: sun8i-h3: Remove allwinner,leds-active-low for non internal PHY

Emmanuel Vadot (1):
      ARM: dts: sunxi: Add codec for A13 Olinuxino

Icenowy Zheng (1):
      ARM: dts: sun8i: add support for Orange Pi R1

Krzysztof Adamski (1):
      ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo board

Philipp Rossak (2):
      ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1
      ARM: dts: sun8i: h3: nanopi-m1-plus: fix missing ethernet 0 in aliases

Quentin Schulz (2):
      ARM: dtsi: axp81x: add GPIO DT node
      ARM: dtsi: axp81x: set pinmux for GPIO0/1 when used as LDOs

Tuomas Tynkkynen (1):
      ARM: dts: sun7i: Enable HDMI on pcDuino3 Nano

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/axp81x.dtsi                      |  20 +++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |   4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |  25 +++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  19 ++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  17 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 135 ++++++++++++++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts    |  73 ++++++++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |   1 -
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 196 +++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |   3 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |  11 ++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |  17 ++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |   1 -
 14 files changed, 520 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171228/bfb90de2/attachment-0001.sig>
