From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Sat, 31 May 2014 18:45:30 +0300
Subject: [PATCH v2 0/4] clk: qcom: Add APQ8084 Global Clock Controller support
Message-ID: <1401551134-28485-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the global clock controller found on the
APQ8084 based platforms.

Patches 1,2 can go through clk-next and 3,4 through arm-soc.

Changes from v1:
 - Moved APQ8084 clocks into a separate file and under separate Kconfig
   entry. Dropped the override function patch from v1.
 - Added the missing information about resets (suggested by Kumar Gala).
 - Made the UART DT node "disabled" in dtsi and "okay" in dts (suggested
   by Kumar Gala)

Georgi Djakov (4):
  clk: qcom: Add APQ8084 Global Clock Controller documentation
  clk: qcom: Add APQ8084 Global Clock Controller support
  ARM: dts: qcom: Add APQ8084 Global Clock Controller DT node
  ARM: dts: qcom: Add APQ8084 serial port DT node

 .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
 arch/arm/boot/dts/qcom-apq8084-mtp.dts             |    6 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   18 +
 drivers/clk/qcom/Kconfig                           |    8 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-apq8084.c                     | 2951 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-apq8084.h       |  337 +++
 include/dt-bindings/reset/qcom,gcc-apq8084.h       |  116 +
 8 files changed, 3438 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-apq8084.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-apq8084.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-apq8084.h

-- 
1.7.9.5
