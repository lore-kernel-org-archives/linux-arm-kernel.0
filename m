From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  8 Sep 2015 16:34:37 +0200
Subject: [PATCH v2 0/9] ARM: dts: update Boundary Devices boards support
In-Reply-To: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series is a follow-up to the previous series that added LCD display
support.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364425.html

This one aims at adding touchscreen and WiFi support for Nitrogen6x as well as
adding two boards: Nitrogen6_Max and Nit6xlite.

It also takes care of updating the licenses to be GPLv2/X11.

The series has been tested against linux-next tag next-20150908.

Note that imx_v6_v7_defconfig has been used with the following additions:
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_RTC_DRV_M41T80=y

Modifications:
v1->v2:
- Add Boundary Devices Inc. to vendor prefixes
- Relicense devices trees to GPLv2/X11 as suggested by Fabio for:
  - Nitrogen6x
  - SabreLite
  - Nit6xLite
  - Nitrogen6_MAX
- Change manufacturer to Boundary Devices as suggested by Fabio for:
  - Nitrogen6x
  - Nit6xLite
  - Nitrogen6_MAX
- Fixed missing macros for gpio/irq values as suggested by Philipp.

Regards,
Gary

Gary Bisson (9):
  ARM: dts: imx6dql-nitrogen6x: add touchscreen support
  ARM: dts: imx6qdl-nitrogen6x: add wifi wl1271 support
  ARM: dts: imx6qdl-nitrogen6x: relicense under GPLv2/X11
  ARM: dts: imx6qdl-sabrelite: relicense under GPLv2/X11
  of: Add Boundary Devices Inc. vendor prefix
  ARM: dts: imx6q-nitrogen6x: change manufacturer to Boundary Devices
  ARM: dts: imx6dl-nitrogen6x: change manufacturer to Boundary Devices
  ARM: dts: imx: add Boundary Devices Nitrogen6_Max board
  ARM: dts: imx: add Boundary Devices Nitrogen6_Lite board

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-nit6xlite.dts             |  49 +++
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |  44 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |  40 +-
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts          |  53 +++
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |  44 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  40 +-
 ...6qdl-nitrogen6x.dtsi => imx6qdl-nit6xlite.dtsi} | 465 ++++++++++++---------
 ...-nitrogen6x.dtsi => imx6qdl-nitrogen6_max.dtsi} | 437 +++++++++++++++----
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          | 111 ++++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  40 +-
 12 files changed, 1013 insertions(+), 313 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-nit6xlite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_max.dts
 copy arch/arm/boot/dts/{imx6qdl-nitrogen6x.dtsi => imx6qdl-nit6xlite.dtsi} (51%)
 copy arch/arm/boot/dts/{imx6qdl-nitrogen6x.dtsi => imx6qdl-nitrogen6_max.dtsi} (53%)

-- 
2.5.1
