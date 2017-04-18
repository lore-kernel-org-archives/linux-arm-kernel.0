From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 18 Apr 2017 08:01:26 -0700
Subject: [PATCH v2 0/7] i.MX7 PCIe related device tree changes
Message-ID: <20170418150133.31679-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, everyone:

This is second version of the series that includes changes made to
device-tree in order to support PCIe on i.MX7 platform.

Changes since [v1]:

	- All 'anatop-enable-bit' patches are squashed into one

	- Added patch to enable GPCv2 driver on i.MX7

	- Dropped accidentally introduced unsupported DT properties

	- A number of node renaming for readability/clarity purpose

[v1] http://lkml.kernel.org/r/20170413133242.5068-1-andrew.smirnov at gmail.com

Andrey Smirnov (7):
  ARM: dts: i.MX: Reintroduce 'anatop-enable-bit' where appropriate
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
 arch/arm/boot/dts/imx7d-sdb.dts | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi    | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi    | 30 ++++++++++++++++++++++++++++--
 arch/arm/mach-imx/Kconfig       |  1 +
 8 files changed, 111 insertions(+), 2 deletions(-)

-- 
2.9.3
