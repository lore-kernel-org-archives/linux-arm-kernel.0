From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Mon, 20 Apr 2015 10:45:34 +0300
Subject: [PATCH v2 0/7] ARM: dts: qcom: Add more device coniguration nodes
Message-ID: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Qualcomm PMIC's devices are accessed over SPMI bus.
Every PMIC has several "sub-function" devices inside.

First three patches are adding device nodes to PM8841, PM8941 and PMA8084 PMIC's.
Next two are introducing PM8916 PMIC chip with its device nodes. The sixth one
add restart device node for MSM8916 chip. And the last one add initial GPIO
definitions for APQ8016 SBC board.

checkpatch will complain about "appears un-documented" for several drivers,
but I am expecting they to mergeed soon, hopefully during this merge window.

Changes since v0 [2]:

* Add proper IRQ_TYPE_* specifiers in the interrupt bidings.

Patches are created top of Kumar's kernel tree and tags/qcom-dt-for-4.1 [1].

[1] https://lkml.org/lkml/2015/3/27/599
[2] http://comments.gmane.org/gmane.linux.ports.arm.msm/12610

Ivan T. Ivanov (7):
  ARM: dts: qcom: Add PM8841 functions device nodes
  ARM: dts: qcom: Add PM8941 functions device nodes
  ARM: dts: qcom: Add PMA8084 functions device nodes
  arm64: dts: qcom: Add SPMI PMIC Arbiter node for MSM8916
  arm64: dts: qcom: Add 8x16 chipset SPMI PMIC's nodes
  arm64: dts: qcom: Add MSM8916 restart device node
  arm64: dts: qcom: Add initial set of PMIC and SoC pins for APQ8016 SBC
    board

 arch/arm/boot/dts/qcom-pm8841.dtsi                 |  18 +++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 | 133 ++++++++++++++++++++-
 arch/arm/boot/dts/qcom-pma8084.dtsi                |  92 ++++++++++++++
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |  30 +++++
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  21 ++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   3 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi          |   1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  25 +++-
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |  99 +++++++++++++++
 9 files changed, 420 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8916.dtsi

--
1.9.1
