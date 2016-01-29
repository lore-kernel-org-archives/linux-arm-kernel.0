From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Fri, 29 Jan 2016 18:19:11 -0500
Subject: [PATCH v7 0/7] ARM: dts: Add Advantech board support
Message-ID: <1454109558-22800-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Advantech BA-16 module (iMX6 based) and GE board support.

This series has been tested against linux-next tag next-20160128.

Modifications:
v6->v7:
- BA16:
Use hypen instead of underscore in node names
Update backlight control pin as per final schematics
Remove unused clk24m node
Use wakeup-source instead of enable-sdio-wakeup
- Bx50v3:
Use hypen instead of underscore in node names
Use newline between node property and sub-node
Update i2c mux labels to make naming more explicit
Use wakeup-source instead of enable-sdio-wakeup
- B450v3, B650v3
Use hypen instead of underscore in node names
Remove panel_lvds1 as per final schematics 
- B850v3:
Use hypen instead of underscore in node names
Update i2c mux labels to make naming more explicit
Remove unused ads7830_2 label

History:
--------
[v1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381872.html
[v2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383276.html
[v3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384202.html
[v4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390373.html
[v5]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390788.html
[v6]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/396131.html

Akshay Bhat (5):
  of: Add vendor prefix for Advantech Corporation
  of: Add vendor prefix for General Electric Company
  ARM: dts: imx: Add support for Advantech/GE B450v3
  ARM: dts: imx: Add support for Advantech/GE B650v3
  ARM: dts: imx: Add support for Advantech/GE B850v3

Justin Waters (2):
  ARM: dts: imx: Add Advantech BA-16 Qseven module
  ARM: dts: imx: Add support for Advantech/GE Bx50v3

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  88 +++
 arch/arm/boot/dts/imx6q-b650v3.dts                 |  88 +++
 arch/arm/boot/dts/imx6q-b850v3.dts                 | 157 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 633 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                | 239 ++++++++
 7 files changed, 1210 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi

-- 
2.7.0
