From: bshah@kde.org (Bhushan Shah)
Date: Sun, 17 Jul 2016 16:22:05 +0530
Subject: [PATCH 0/3] Initial support for LG Nexus 5 phone (hammerhead)
Message-ID: <20160717105208.9596-1-bshah@kde.org>
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

However, it seems regulator-max-microvolt settings are not respected, for example,

l19{
	regulator-min-microvolt = <3000000>;
	regulator-max-microvolt = <3300000>;
};

but in kmsg, it says,

[    1.753401] l19: supplied by vph-pwr                
[    1.757418] l19: Bringing 0uV into 3000000-3000000uV

Relavant line from kmsg of downstream kernel says,

[    0.255590] 8941_l19: 3000 <--> 3300 mV at 3300 mV normal idle

Is there anything wrong with dts?

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org

Bhushan Shah (3):
  ARM: dts: qcom: Add initial DTS for LG Nexus 5 Phone
  ARM: dts: msm8974-hammerhead: Add regulator nodes for hammerhead
  ARM: dts: msm8974-hammerhead: Introduce gpio-keys nodes

 arch/arm/boot/dts/Makefile                         |   1 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 296 +++++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts

-- 
2.9.0
