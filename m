From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 29 Dec 2016 14:27:18 -0800
Subject: [PATCH 03/20] ARM: dts: imx6qdl: add media device
In-Reply-To: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
References: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1483050455-10683-4-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 56a314f..2fbe0b3 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -454,3 +454,7 @@
 &vpu {
 	compatible = "fsl,imx6q-vpu", "cnm,coda960";
 };
+
+&media0 {
+	ports = <&ipu1_csi0>, <&ipu1_csi1>, <&ipu2_csi0>, <&ipu2_csi1>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89218a4..12ae045 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1296,5 +1296,13 @@
 				};
 			};
 		};
+
+		media0: media at 0 {
+			compatible = "fsl,imx-media";
+			ports = <&ipu1_csi0>, <&ipu1_csi1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+		};
 	};
 };
-- 
2.7.4
