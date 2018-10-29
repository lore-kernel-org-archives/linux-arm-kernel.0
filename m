From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 29 Oct 2018 17:40:23 +0530
Subject: [PATCH v3 0/3] Add Xilinx AMS Driver
Message-ID: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
This driver will be used by iio-hwmon to repport voltages and temperatures
across the system by using various channel interfaces.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Changes in v2:
	- Added documentation for sysfs (Patch-2)
	- Addressed code style review comments
	- Patch-2 (Now it is Patch-3)
		- Arranged the includes in alphabetical order
		- Removed the wrapper 'ams_pl_write_reg()' and used writel
		  instead
		- Removed the unnecessary delay of 1ms and used polling of EOC
		  instead
		- Removed spin_lock and used mutex only.
		- Used request_irq() instead of devm_request_irq() and handled
		  respective error conditions
		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
	- Patch-1
		- Addressed Documentation style comments

Changes in v3:
	- Updated bindings document with the suggested modification in v2 review
	- Removed documentation for sysfs
	- Removed extended names for channels in the Xilinx AMS driver
	- Modified dts to use ranges for child nodes
	- Reduced address and size cells to 32-bit instead of 64-bit

Manish Narani (3):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  183 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   27 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1343 ++++++++++++++++++++
 5 files changed, 1564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.1.1
