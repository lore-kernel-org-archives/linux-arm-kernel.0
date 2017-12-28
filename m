From: zhuoweizhang@yahoo.com (zhuoweizhang at yahoo.com)
Date: Thu, 28 Dec 2017 02:38:29 -0500
Subject: [PATCH] arm64: dts: angler: add pstore-ramoops support
Message-ID: <1514446709-19347-1-git-send-email-zhuoweizhang@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhuowei Zhang <zhuoweizhang@yahoo.com>

Support pstore-ramoops for retrieving kernel oops and panics after reboot.

The address and configs are taken from the downstream kernel's device tree.

Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
---
 arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
index dfa08f5..9ce3a6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
@@ -37,4 +37,19 @@
 			pinctrl-1 = <&blsp1_uart2_sleep>;
 		};
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops at 1fe00000 {
+			compatible = "ramoops";
+			reg = <0 0x1fe00000 0 0x00200000>;
+			console-size = <0x100000>;
+			record-size = <0x10000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x80000>;
+		};
+	};
 };
-- 
1.9.1
