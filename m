From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Fri, 19 Feb 2016 18:35:24 -0500
Subject: [PATCH v8 0/7] ARM: dts: Add Advantech board support
Message-ID: <1455924931-13784-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Advantech BA-16 module (iMX6 based) and GE board support.

This series has been tested against linux-next tag next-20160216.

Modifications:
v7->v8:
Incorporate comments made by Shawn Guo
- BA16:
Remove invalid i2s-master property in ssi1 node
- Bx50v3:
Remove redundant address-cells/size-cells properties in clocks node
Update stgl5000 node name to codec to better match DT convention
Remove unused igb entries
Fix unit address for wlcore
Move status to last property in usdhc4 node

History:
--------
[v1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381872.html
[v2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383276.html
[v3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384202.html
[v4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390373.html
[v5]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390788.html
[v6]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/396131.html
[v7]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/403429.html

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
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 632 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                | 225 ++++++++
 7 files changed, 1195 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi

-- 
2.7.1
