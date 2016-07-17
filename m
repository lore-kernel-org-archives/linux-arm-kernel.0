From: bshah@kde.org (Bhushan Shah)
Date: Sun, 17 Jul 2016 16:22:06 +0530
Subject: [PATCH 1/3] ARM: dts: qcom: Add initial DTS for LG Nexus 5 Phone
In-Reply-To: <20160717105208.9596-1-bshah@kde.org>
References: <20160717105208.9596-1-bshah@kde.org>
Message-ID: <20160717105208.9596-2-bshah@kde.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS file have support LG Nexus 5 (codenamed hammerhead).
Initial version have support for just serial console over headphone
jack.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Signed-off-by: Bhushan Shah <bshah@kde.org>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 25 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 414b427..13947ec 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -584,6 +584,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
+	qcom-msm8974-lge-nexus5-hammerhead.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
new file mode 100644
index 0000000..88d494f
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -0,0 +1,25 @@
+#include "qcom-msm8974.dtsi"
+#include "qcom-pm8841.dtsi"
+#include "qcom-pm8941.dtsi"
+
+/ {
+	model = "LGE MSM 8974 HAMMERHEAD";
+	compatible = "qcom,msm8974";
+	qcom,msm-id = <126 150 0x20002 0xB>;
+
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&soc {
+
+	serial at f991d000 {
+		status = "ok";
+	};
+
+};
-- 
2.9.0
