From: manish.narani@xilinx.com (Manish Narani)
Date: Fri, 14 Sep 2018 12:48:26 +0530
Subject: [PATCH v2 0/4] Add Xilinx AMS Driver
Message-ID: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
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

Manish Narani (4):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: Documentation: Add Xilinx AMS sysfs documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../ABI/testing/sysfs-bus-iio-adc-xilinx-ams       |  246 ++++
 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  180 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1337 ++++++++++++++++++++
 6 files changed, 1800 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.1.1
