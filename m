From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 21 Jul 2015 16:36:59 +0530
Subject: [PATCH 0/4] clk: 88pm800: Add new clk provider driver for 88PM800 MFD
Message-ID: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM800 family of devices provides multiple buffered 32.768 KHz clock
output.
88PM800 : CLK32k_1, CLK32k_2 and CLK32k_3
88PM860 : CLK32k_1 and CLK32k_2

This patch-series adds new clock provider driver for enabling/disabling
buffered 32Khz clock output from 88PM800 family of device. Adds clock device to
MFD and updates the binding documentation.

The PATCH [1/4], created separately, as it would be easy between maintainers to
queue it.


Note that, I have access to only 88PM800 and 88PM860 datasheet,
so enabling support for only above two devices.

Testing:
  - Boot tested on 88PM860 based platform
  - Clock enable/disable
  - Non PM860, to make sure that it won't lead to any issues


Vaibhav Hiremath (4):
  mfd: 88pm800: Update the header file with 32K clk related macros
  mfd: devicetree: bindings: Add clock subdevice node information
  clk: 88pm800: Add clk provider driver for 88pm800 family of devices
  mfd: 88pm800: Add support for clk subdevice

 Documentation/devicetree/bindings/mfd/88pm800.txt |  28 ++
 drivers/clk/Kconfig                               |   8 +
 drivers/clk/Makefile                              |   1 +
 drivers/clk/clk-88pm800.c                         | 345 ++++++++++++++++++++++
 drivers/mfd/88pm800.c                             |  25 ++
 include/linux/mfd/88pm80x.h                       |  12 +
 6 files changed, 419 insertions(+)
 create mode 100644 drivers/clk/clk-88pm800.c

-- 
1.9.1
