From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Wed, 23 Mar 2016 17:05:05 -0500
Subject: [PATCH 10/17] qcom: ipq4019: add watchdog node to ipq4019 SoC and
 DK01 device tree
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1458770712-10880-11-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow boards to enable watchdog support

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 4 ++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index fe78f3f..223da1a 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -55,5 +55,9 @@
 			pinctrl-names = "default";
 			status = "ok";
 		};
+
+		watchdog at b017000 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index e44f5b6..00a5e9e 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -171,5 +171,13 @@
 				<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 		};
+
+		watchdog at b017000 {
+			compatible = "qcom,kpss-standalone";
+			reg = <0xb017000 0x40>;
+			clocks = <&sleep_clk>;
+			timeout-sec = <10>;
+			status = "disabled";
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
