From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:36 +0100
Subject: [PATCH 10/40] arm64: dts: renesas: r8a774a1: Add VIN and CSI-2 nodes
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <0c85e78fb1d3742c36ff085999624cc912128776.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add VIN and CSI-2 nodes to RZ/G2M SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 367 ++++++++++++++++++++++++++++++
 1 file changed, 367 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index a4817a012e11..78ac8e3cda6e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1126,6 +1126,262 @@
 			status = "disabled";
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 811>;
+			renesas,id = <0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin0csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin0>;
+					};
+					vin0csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin0>;
+					};
+				};
+			};
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 810>;
+			renesas,id = <1>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin1csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin1>;
+					};
+					vin1csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin1>;
+					};
+				};
+			};
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 809>;
+			renesas,id = <2>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin2csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin2>;
+					};
+					vin2csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin2>;
+					};
+				};
+			};
+		};
+
+		vin3: video at e6ef3000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef3000 0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 808>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 808>;
+			renesas,id = <3>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin3csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin3>;
+					};
+					vin3csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin3>;
+					};
+				};
+			};
+		};
+
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin4csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin4>;
+					};
+					vin4csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin4>;
+					};
+				};
+			};
+		};
+
+		vin5: video at e6ef5000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 806>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 806>;
+			renesas,id = <5>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin5csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin5>;
+					};
+					vin5csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin5>;
+					};
+				};
+			};
+		};
+
+		vin6: video at e6ef6000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef6000 0 0x1000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 805>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 805>;
+			renesas,id = <6>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin6csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin6>;
+					};
+					vin6csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin6>;
+					};
+				};
+			};
+		};
+
+		vin7: video at e6ef7000 {
+			compatible = "renesas,vin-r8a774a1";
+			reg = <0 0xe6ef7000 0 0x1000>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 804>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 804>;
+			renesas,id = <7>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin7csi20: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&csi20vin7>;
+					};
+					vin7csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&csi40vin7>;
+					};
+				};
+			};
+		};
+
 		rcar_sound: sound at ec500000 {
 			/*
 			 * #sound-dai-cells is required
@@ -1613,6 +1869,117 @@
 			iommus = <&ipmmu_vc0 19>;
 		};
 
+		csi20: csi2 at fea80000 {
+			compatible = "renesas,r8a774a1-csi2";
+			reg = <0 0xfea80000 0 0x10000>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 714>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 714>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi20vin0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin0csi20>;
+					};
+					csi20vin1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin1csi20>;
+					};
+					csi20vin2: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&vin2csi20>;
+					};
+					csi20vin3: endpoint at 3 {
+						reg = <3>;
+						remote-endpoint = <&vin3csi20>;
+					};
+					csi20vin4: endpoint at 4 {
+						reg = <4>;
+						remote-endpoint = <&vin4csi20>;
+					};
+					csi20vin5: endpoint at 5 {
+						reg = <5>;
+						remote-endpoint = <&vin5csi20>;
+					};
+					csi20vin6: endpoint at 6 {
+						reg = <6>;
+						remote-endpoint = <&vin6csi20>;
+					};
+					csi20vin7: endpoint at 7 {
+						reg = <7>;
+						remote-endpoint = <&vin7csi20>;
+					};
+				};
+			};
+		};
+
+		csi40: csi2 at feaa0000 {
+			compatible = "renesas,r8a774a1-csi2";
+			reg = <0 0xfeaa0000 0 0x10000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 716>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi40vin0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin0csi40>;
+					};
+					csi40vin1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin1csi40>;
+					};
+					csi40vin2: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&vin2csi40>;
+					};
+					csi40vin3: endpoint at 3 {
+						reg = <3>;
+						remote-endpoint = <&vin3csi40>;
+					};
+					csi40vin4: endpoint at 4 {
+						reg = <4>;
+						remote-endpoint = <&vin4csi40>;
+					};
+					csi40vin5: endpoint at 5 {
+						reg = <5>;
+						remote-endpoint = <&vin5csi40>;
+					};
+					csi40vin6: endpoint at 6 {
+						reg = <6>;
+						remote-endpoint = <&vin6csi40>;
+					};
+					csi40vin7: endpoint at 7 {
+						reg = <7>;
+						remote-endpoint = <&vin7csi40>;
+					};
+				};
+
+			};
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.11.0
