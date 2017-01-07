From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri,  6 Jan 2017 18:11:22 -0800
Subject: [PATCH v3 04/24] ARM: dts: imx6qdl: add media device
In-Reply-To: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1483755102-24785-5-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 9b2ca32..8867e78 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -458,3 +458,7 @@
 &vpu {
 	compatible = "fsl,imx6q-vpu", "cnm,coda960";
 };
+
+&media0 {
+	ports = <&ipu1_csi0>, <&ipu1_csi1>, <&ipu2_csi0>, <&ipu2_csi1>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 010388c..cbb42ec 100644
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
