From: jeremymc@redhat.com (Jeremy McNicoll)
Date: Mon, 12 Mar 2018 01:36:57 -0700
Subject: [PATCH] arm64: dts: msm8992: add pstore-ramoops support
Message-ID: <1520843817-9667-1-git-send-email-jeremymc@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the addition of this ramoops node it enables post mortem
analysis if a debug cable is not attached and/or not available.

All addresses and values were extracted from CAF AOSP marshmallow
DR 1.6.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
index 4542133..d1b62ef 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
@@ -38,4 +38,19 @@
 			pinctrl-1 = <&blsp1_uart2_sleep>;
 		};
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops at 1ff00000 {
+			compatible = "ramoops";
+			reg = <0x0 0x1ff00000 0x0 0x40000>;
+			console-size = <0x10000>;
+			record-size = <0x10000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x20000>;
+		};
+	};
 };
-- 
2.6.1
