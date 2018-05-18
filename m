From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:59 +0200
Subject: [PATCH 097/102] arm64: dts: renesas: r8a7795-es1: add CSI-2 node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <e51c09d53719c0d348f07af7deb14463ec1aeec7.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Renesas H3 ES1.0 have one extra CSI-2 node, CSI21 which is not present
for later ES versions of H3.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 143 +++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 0177f5e60e5a..e19dcd6cb767 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -107,6 +107,61 @@
 		resets = <&cpg 117>;
 		renesas,fcp = <&fcpf2>;
 	};
+
+	csi21: csi2 at fea90000 {
+		compatible = "renesas,r8a7795-csi2";
+		reg = <0 0xfea90000 0 0x10000>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 713>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		resets = <&cpg 713>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				reg = <1>;
+
+				csi21vin0: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vin0csi21>;
+				};
+				csi21vin1: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vin1csi21>;
+				};
+				csi21vin2: endpoint at 2 {
+					reg = <2>;
+					remote-endpoint = <&vin2csi21>;
+				};
+				csi21vin3: endpoint at 3 {
+					reg = <3>;
+					remote-endpoint = <&vin3csi21>;
+				};
+				csi21vin4: endpoint at 4 {
+					reg = <4>;
+					remote-endpoint = <&vin4csi21>;
+				};
+				csi21vin5: endpoint at 5 {
+					reg = <5>;
+					remote-endpoint = <&vin5csi21>;
+				};
+				csi21vin6: endpoint at 6 {
+					reg = <6>;
+					remote-endpoint = <&vin6csi21>;
+				};
+				csi21vin7: endpoint at 7 {
+					reg = <7>;
+					remote-endpoint = <&vin7csi21>;
+				};
+			};
+		};
+	};
 };
 
 &gpio1 {
@@ -174,3 +229,91 @@
 &du {
 	vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
 };
+
+&vin0 {
+	ports {
+		port at 1 {
+			vin0csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin0>;
+			};
+		};
+	};
+};
+
+&vin1 {
+	ports {
+		port at 1 {
+			vin1csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin1>;
+			};
+		};
+	};
+};
+
+&vin2 {
+	ports {
+		port at 1 {
+			vin2csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin2>;
+			};
+		};
+	};
+};
+
+&vin3 {
+	ports {
+		port at 1 {
+			vin3csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin3>;
+			};
+		};
+	};
+};
+
+&vin4 {
+	ports {
+		port at 1 {
+			vin4csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin4>;
+			};
+		};
+	};
+};
+
+&vin5 {
+	ports {
+		port at 1 {
+			vin5csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin5>;
+			};
+		};
+	};
+};
+
+&vin6 {
+	ports {
+		port at 1 {
+			vin6csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin6>;
+			};
+		};
+	};
+};
+
+&vin7 {
+	ports {
+		port at 1 {
+			vin7csi21: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint= <&csi21vin7>;
+			};
+		};
+	};
+};
-- 
2.11.0
