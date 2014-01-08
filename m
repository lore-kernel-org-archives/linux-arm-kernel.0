From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  8 Jan 2014 14:59:44 -0800
Subject: [PATCH 7/7] ARM: dts: msm: Add krait-pmu to platforms with Krait CPUs
In-Reply-To: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389221984-10973-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows us to probe the performance counters on Krait CPUs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This one is piled on top of the SMP patches I sent a few weeks ago. Applying
it directly on -next should cause minor conflicts.

 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 5 +++++
 arch/arm/boot/dts/qcom-msm8974.dtsi    | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index ea24fdfbdd06..138d4760ece6 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -39,6 +39,11 @@
 		};
 	};
 
+	cpu-pmu {
+		compatible = "qcom,krait-pmu";
+		interrupts = <1 10 0x304>;
+	};
+
 	intc: interrupt-controller at 2000000 {
 		compatible = "qcom,msm-qgic2";
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index f607cf4a11d9..24d63c82a15a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -52,6 +52,11 @@
 		};
 	};
 
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
