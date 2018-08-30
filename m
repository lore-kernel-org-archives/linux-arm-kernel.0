From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 30 Aug 2018 15:52:16 +0530
Subject: [PATCH 0/3] Add Xilinx AMS Driver
Message-ID: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and
temperatures across the system.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The
binding documentation is added for understanding of AMS, PS, PL Sysmon
Channels.

Manish Narani (3):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  159 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1081 ++++++++++++++++++++
 drivers/iio/adc/xilinx-ams.h                       |  281 +++++
 6 files changed, 1558 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c
 create mode 100644 drivers/iio/adc/xilinx-ams.h

-- 
2.1.1
