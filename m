From: bshah@kde.org (Bhushan Shah)
Date: Fri, 29 Jul 2016 11:39:05 +0530
Subject: [PATCH v3 0/5] Initial support for LG Nexus 5 phone (hammerhead)
Message-ID: <20160729060910.16943-1-bshah@kde.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for LG Nexus 5 phone, codenamed hammerhead.

Initial version have following supported,

    - Serial console over headphone jack
    - pm8841 and pm8941 regulator nodes
    - Hardware keys (volume_up and volume_down)

Values for the regulator nodes are taken from following files in downstream msm
kernel tree, branch android-msm-hammerhead-3.4-marshmallow-mr2

    - arch/arm/boot/dts/msm8974-regulator.dtsi
    - arch/arm/boot/dts/msm8974-hammerhead/msm8974-hammerhead.dtsi

Values are verified against kmsg from downstream kernel as well.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org

Changes since v2:

    - rename vph-pwr-reg node to vreg-vph-pwr
    - also move pinctrl stuff to msm8974.dtsi

Changes since v1:

    - Remove qcom,msm-id from dts file
    - Add "lge,hammerhead" to compatible
    - move vreg_boost node from honami.dts file to msm8974.dtsi
    - move vph-pwr-reg node to msm8974.dtsi

Bhushan Shah (5):
  ARM: dts: qcom: Add initial DTS for LG Nexus 5 Phone
  ARM: dts: msm8974: Move vreg_boost node from the honami to msm8974
  ARM: dts: qcom: msm8974: Add fixed regulator node for vph-pwr-reg
  ARM: dts: msm8974-hammerhead: Add regulator nodes for hammerhead
  ARM: dts: msm8974-hammerhead: Introduce gpio-keys nodes

 arch/arm/boot/dts/Makefile                         |   1 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 262 +++++++++++++++++++++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |  21 --
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  28 +++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |   6 +
 5 files changed, 297 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts

-- 
2.9.0
