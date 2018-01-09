From: drebrez@gmail.com (Daniele Debernardi)
Date: Tue,  9 Jan 2018 02:15:13 +0100
Subject: [PATCH] ARM: dts: qcom: Add initial DTS file for Samsung Galaxy S5
 phone
Message-ID: <1515460513-14443-1-git-send-email-drebrez@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS has support for the Samsung Galaxy S5 (codenamed klte).
Initial version have support just for serial console.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Signed-off-by: Daniele Debernardi <drebrez@gmail.com>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9..abb0ab1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -729,6 +729,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-fairphone-fp2.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
+	qcom-msm8974-samsung-klte.dtb \
 	qcom-msm8974-sony-xperia-castor.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
new file mode 100644
index 0000000..eaa1001
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro.dtsi"
+#include "qcom-pm8841.dtsi"
+#include "qcom-pm8941.dtsi"
+
+/ {
+	model = "Samsung Galaxy S5";
+	compatible = "samsung,klte", "qcom,msm8974";
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
+	serial at f991e000 {
+		status = "ok";
+	};
+
+};
-- 
2.7.4
