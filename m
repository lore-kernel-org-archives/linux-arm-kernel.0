From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Dec 2017 11:22:40 +0800
Subject: [GIT PULL] Allwinner fixes for 4.15
Message-ID: <20171228032240.GA2951@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.15

for you to fetch changes up to eac6a3639decefcc8eb0941dd3cebe79993670ad:

  ARM: dts: sun8i: a711: Reinstate the PMIC compatible (2017-12-19 09:56:57 +0100)

----------------------------------------------------------------
Allwinner fixes for 4.15

First, one fix that adds proper regulator references for the EMAC
external PHYs on A64 boards. The EMAC bindings were developed for 4.13,
but reverted at the last minute. They were finalized and brought back
for 4.15. However in the time between, regulator support for the A64
boards was merged. When EMAC device tree changes were reintroduced,
this was not taken into account.

Second, a patch that adds OF based modalias uevent for RSB slave devices.
This has been missing since the introduction of RSB, and recently with
PMIC regulator support introduced for the A64, has been seen affecting
distributions, which have the all-important PMIC mfd drivers built as
modules, which then don't get loaded.

Other minor cleanups include final conversion of raw indices to CCU
binding macros for sun[4567]i HDMI, cleanup of dummy regulators on the
A64 SOPINE, a SD card detection polarity fix for the Orange Pi Zero
Plus2, and adding a missing compatible for the PMIC on the TBS A711
tablet.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sunxi: Convert to CCU index macros for HDMI controller

Icenowy Zheng (1):
      arm64: allwinner: a64: add Ethernet PHY regulator for several boards

Jagan Teki (1):
      arm64: allwinner: a64-sopine: Fix to use dcdc1 regulator instead of vcc3v3

Maxime Ripard (1):
      ARM: dts: sun8i: a711: Reinstate the PMIC compatible

Sergey Matyukevich (1):
      arm64: dts: orange-pi-zero-plus2: fix sdcard detect

Stefan Br?ns (1):
      sunxi-rsb: Include OF based modalias in device uevent

 arch/arm/boot/dts/sun4i-a10.dtsi                              |  4 ++--
 arch/arm/boot/dts/sun5i-a10s.dtsi                             |  4 ++--
 arch/arm/boot/dts/sun6i-a31.dtsi                              |  4 ++--
 arch/arm/boot/dts/sun7i-a20.dtsi                              |  4 ++--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                     |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts |  3 ++-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi          | 11 +----------
 .../boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts      |  2 +-
 drivers/bus/sunxi-rsb.c                                       |  1 +
 11 files changed, 16 insertions(+), 20 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171228/90d78bb6/attachment.sig>
