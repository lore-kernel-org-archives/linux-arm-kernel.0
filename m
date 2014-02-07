From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  7 Feb 2014 13:01:25 -0800
Subject: [PATCH v3 7/7] ARM: dts: msm: Add krait-pmu to platforms with Krait
 CPUs
In-Reply-To: <1391806885-24210-1-git-send-email-sboyd@codeaurora.org>
References: <1391806885-24210-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1391806885-24210-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows us to probe the performance counters on Krait CPUs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 6 ++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 7c30de4fa302..66c59a6a722c 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -9,6 +9,12 @@
 	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
 	interrupt-parent = <&intc>;
 
+	cpu-pmu {
+		compatible = "qcom,krait-pmu";
+		interrupts = <1 10 0x304>;
+		qcom,no-pc-write;
+	};
+
 	intc: interrupt-controller at 2000000 {
 		compatible = "qcom,msm-qgic2";
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 9e5dadb101eb..1eff4130cde0 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -9,6 +9,11 @@
 	compatible = "qcom,msm8974";
 	interrupt-parent = <&intc>;
 
+	cpu-pmu {
+		compatible = "qcom,krait-pmu";
+		interrupts = <1 7 0xf04>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
