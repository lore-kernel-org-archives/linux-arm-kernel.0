From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri,  3 Oct 2014 23:35:46 +0800
Subject: [PATCH v4 0/3] i2c: hix5hd2: add i2c controller driver
Message-ID: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Suggested by Wolfram
Put runtime pm calls before i2c_add_adapter, in case i2c operation during probe.

Also remove COMPILE_TEST, since compile test fail with linux-next next-20141003
Will add back later when readl/writel_relaxed is defined.

v3:
Add COMPILE_TEST as dependence to enable compile test
Remove specific mach info in dts binding to solve the confusion.

v2: 
Modify according to Wolfram's comments 
including change vector name, coding style, return value etc.

Wei Yan (2):
  i2c: hix5hd2: add devicetree documentation
  i2c: hix5hd2: add i2c controller driver

Zhangfei Gao (1):
  ARM: dts: hix5hd2: add i2c node

 .../devicetree/bindings/i2c/i2c-hix5hd2.txt        |   25 +
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   60 +++
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-hix5hd2.c                   |  557 ++++++++++++++++++++
 5 files changed, 653 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hix5hd2.txt
 create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c

-- 
1.7.9.5
