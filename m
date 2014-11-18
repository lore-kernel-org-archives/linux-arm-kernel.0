From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 18 Nov 2014 21:22:35 +0100
Subject: [PATCH v3 3/3] ARM: dts: meson: add IR receiver node
In-Reply-To: <1416342155-26820-1-git-send-email-b.galvani@gmail.com>
References: <1416342155-26820-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1416342155-26820-4-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the IR remote control receiver to the Amlogic
Meson DTS.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index e6539ea..6a37f15 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -106,5 +106,12 @@
 			clocks = <&clk81>;
 			status = "disabled";
 		};
+
+		ir_receiver: ir-receiver at c8100480 {
+			compatible= "amlogic,meson6-ir";
+			reg = <0xc8100480 0x20>;
+			interrupts = <0 15 1>;
+			status = "disabled";
+		};
 	};
 }; /* end of / */
-- 
1.9.1
