From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Thu, 20 Feb 2014 18:49:02 +0200
Subject: [PATCH RESEND] ARM: dts: qcom-msm8960-cdp: Add RNG device tree node
Message-ID: <1392914942-23191-1-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary DT node to probe the rng driver on
msm8960-cdp platform.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 7c30de4fa302..8fda9c90ba97 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -67,4 +67,11 @@
 		reg = <0x500000 0x1000>;
 		qcom,controller-type = "pmic-arbiter";
 	};
+
+	rng at 1a500000 {
+		compatible = "qcom,prng";
+		reg = <0x1a500000 0x200>;
+		clocks = <&gcc PRNG_CLK>;
+		clock-names = "core";
+	};
 };
-- 
1.8.4.4
