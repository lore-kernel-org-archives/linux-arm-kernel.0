From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 15 May 2017 07:52:58 -0700
Subject: [PATCH v3 0/7] i.MX7 PCIe related device tree changes
Message-ID: <20170515145305.4465-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, everyone:

This is third version of the series that includes changes made to
device-tree in order to support PCIe on i.MX7 platform.

These changes are also availible at:

https://github.com/ndreys/linux/tree/imx7d/pcie-support-v11

Changes since [v2]:

	- Patchset rebased and tested against v4.12-rc1

	- Removed needless 'pinctrl-names' property from pcie node in imx7d-sdb.dts

	- Moved 'select IMX_GPCV2' statement according to alphabetical order

	- Changed prefix for patch #1

Changes since [v1]:

	- All 'anatop-enable-bit' patches are squashed into one

	- Added patch to enable GPCv2 driver on i.MX7

	- Dropped accidentally introduced unsupported DT properties

	- A number of node renaming for readability/clarity purpose

[v1] http://lkml.kernel.org/r/20170413133242.5068-1-andrew.smirnov at gmail.com
[v2] http://lkml.kernel.org/r/20170418150133.31679-1-andrew.smirnov at gmail.com

Andrey Smirnov (7):
  ARM: dts: imx: Reintroduce 'anatop-enable-bit' where appropriate
  ARM: imx: Select GPCv2 for i.MX7
  ARM: dts: imx7s: Add node for GPC
  ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6 variant
  ARM: dts: imx7d-sdb: Add GPIO expander node
  ARM: dts: imx7d: Add node for PCIe controller
  ARM: dts: imx7d-sdb: Enable PCIe peripheral

 arch/arm/boot/dts/imx6qdl.dtsi  |  3 +++
 arch/arm/boot/dts/imx6sl.dtsi   |  3 +++
 arch/arm/boot/dts/imx6sx.dtsi   |  3 +++
 arch/arm/boot/dts/imx6ul.dtsi   |  1 +
 arch/arm/boot/dts/imx7d-sdb.dts | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi    | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi    | 30 ++++++++++++++++++++++++++++--
 arch/arm/mach-imx/Kconfig       |  1 +
 8 files changed, 110 insertions(+), 2 deletions(-)

-- 
2.9.3
