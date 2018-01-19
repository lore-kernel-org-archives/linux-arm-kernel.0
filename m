From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Fri, 19 Jan 2018 18:25:36 +0900
Subject: [PATCH v2 9/9] arm64: dts: uniphier: add compress audio out for
 UniPhier LD11/LD20
In-Reply-To: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180119092536.22501-10-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds compress audio node for S/PDIF on UniPhier LD11/20
global boards. And adds settings of AIO for it.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 30 +++++++++++++++++++++-
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 30 +++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index ca09251a3eab..51cb717e5e56 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -48,7 +48,8 @@
 			dais = <&i2s_port2
 				&i2s_port3
 				&i2s_port4
-				&spdif_port0>;
+				&spdif_port0
+				&comp_spdif_port0>;
 		};
 
 		spdif-out {
@@ -61,6 +62,17 @@
 				};
 			};
 		};
+
+		comp-spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port at 0 {
+				comp_spdif_tx: endpoint {
+					remote-endpoint = <&comp_spdif_hiecout1>;
+				};
+			};
+		};
 	};
 };
 
@@ -149,6 +161,22 @@
 			remote-endpoint = <&spdif_tx>;
 		};
 	};
+
+	src_port0: port at 6 {
+		i2s_epcmout2: endpoint {
+		};
+	};
+
+	src_port1: port at 7 {
+		i2s_epcmout3: endpoint {
+		};
+	};
+
+	comp_spdif_port0: port at 8 {
+		comp_spdif_hiecout1: endpoint {
+			remote-endpoint = <&comp_spdif_tx>;
+		};
+	};
 };
 
 &evea {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 0728832ce552..0bda5c1382bc 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -48,7 +48,8 @@
 			dais = <&i2s_port2
 				&i2s_port3
 				&i2s_port4
-				&spdif_port0>;
+				&spdif_port0
+				&comp_spdif_port0>;
 		};
 
 		spdif-out {
@@ -61,6 +62,17 @@
 				};
 			};
 		};
+
+		comp-spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port at 0 {
+				comp_spdif_tx: endpoint {
+					remote-endpoint = <&comp_spdif_hiecout1>;
+				};
+			};
+		};
 	};
 };
 
@@ -131,6 +143,22 @@
 			remote-endpoint = <&spdif_tx>;
 		};
 	};
+
+	src_port0: port at 6 {
+		i2s_epcmout2: endpoint {
+		};
+	};
+
+	src_port1: port at 7 {
+		i2s_epcmout3: endpoint {
+		};
+	};
+
+	comp_spdif_port0: port at 8 {
+		comp_spdif_hiecout1: endpoint {
+			remote-endpoint = <&comp_spdif_tx>;
+		};
+	};
 };
 
 &evea {
-- 
2.15.0
