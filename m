From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 23 Dec 2015 17:00:09 -0500
Subject: [PATCH v6 0/7] ARM: dts: Add Advantech board support
Message-ID: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Advantech BA-16 module (iMX6 based) and GE board support.

This series has been tested against linux-next tag next-20151223.

Modifications:
v5->v6:
- BA16:
Add missing dlg,da9063-onkey compatibility
Revert partitions container for spi-nor flash
Address below comments from Shawn:
Update to GPL/X11 dual license
Add new line between properties and sub-nodes; between nodes
Consistently use lowercase for hex values
Move iomux node to bottom of dts file for easier readability
Get rid of imx6q-ba16 container to save on indentation
Reduce the number of entries in hog group
Sort pinctrl nodes alphabetically
Explicitly call out pad configuration value instead of 0x80000000
- Bx50v3: 
Update to GPL/X11 dual license 
Remove @unit-address for regulators as per Shawn's suggestion
- B450v3, B650v3 and B850v3: 
Update to GPL/X11 dual license

History:
--------
[v1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381872.html
[v2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383276.html
[v3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384202.html
[v4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390373.html
[v5]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390788.html

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
 arch/arm/boot/dts/imx6q-b450v3.dts                 | 114 ++++
 arch/arm/boot/dts/imx6q-b650v3.dts                 | 114 ++++
 arch/arm/boot/dts/imx6q-b850v3.dts                 | 157 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 641 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                | 237 ++++++++
 7 files changed, 1268 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi

-- 
2.6.3
