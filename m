From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Fri, 11 May 2018 12:00:01 +0200
Subject: [PATCH 2/3] arm64: dts: renesas: r8a77995: Add VIN4
In-Reply-To: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1526032802-14376-3-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe VIN4 interface for R-Car D3 R8A77995 SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 82aed7e..bdf7017 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -783,6 +783,17 @@
 				};
 			};
 		};
+
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a77995";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.7.4
