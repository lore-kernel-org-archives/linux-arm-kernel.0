From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 17 Mar 2015 12:48:32 +0200
Subject: [PATCH v2 0/3] Add initial DT support for Qualcomm SPMI PMIC devices
Message-ID: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following set of patches add initial DT support for PMIC devices
found on recent Quqalcomm chipsets. Details for SPMI bus and PMIC arbiter
could be found here [1]. First version of the patches could be found here [2].

Changes since first version.

* Added more specific compatible strings to PMIC's DT configuration nodes.
* Changed #size-cells of the PMIC's DT configuration nodes from 0 to 1.
  #size-cells property is used by drivers to obtain size of the resource regions.
* Added Reviewed-by from Bjorn and Andy. Hopefully it still stands after these
  changes.

Regards,
Ivan

[1] http://lwn.net/Articles/564637/
[2] https://lkml.org/lkml/2015/2/3/228

Ivan T. Ivanov (3):
  ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for APQ8084 and MSM8974
  ARM: dts: qcom: Add 8x74 chipset SPMI PMIC's nodes
  ARM: dts: qcom: Add APQ8084 chipset SPMI PMIC's nodes

 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts        |  2 ++
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts            |  1 +
 arch/arm/boot/dts/qcom-apq8084-mtp.dts                |  1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                   | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts |  2 ++
 arch/arm/boot/dts/qcom-msm8974.dtsi                   | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-pm8841.dtsi                    | 18 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                    | 18 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pma8084.dtsi                   | 18 ++++++++++++++++++
 9 files changed, 92 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-pm8841.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-pm8941.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-pma8084.dtsi

--
1.9.1
