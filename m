From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 18 Nov 2014 11:13:21 +0200
Subject: [PATCH 6/9] ARM: dts: cm-t3x: add TV out support
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416302004-22199-7-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TV out support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 58205f0..1a8262c 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -56,6 +56,17 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	tv0: connector at 1 {
+		compatible = "svideo-connector";
+		label = "tv";
+
+		port {
+			tv_connector_in: endpoint {
+				remote-endpoint = <&venc_out>;
+			};
+		};
+	};
 };
 
 &omap3_pmx_core {
@@ -214,3 +225,16 @@
 		linux,wakeup;
 	};
 };
+
+&venc {
+	status = "ok";
+
+	vdda-supply = <&vdac>;
+
+	port {
+		venc_out: endpoint {
+			remote-endpoint = <&tv_connector_in>;
+			ti,channels = <2>;
+		};
+	};
+};
-- 
1.7.5.4
