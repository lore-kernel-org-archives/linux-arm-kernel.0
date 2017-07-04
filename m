From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:41:42 +0200
Subject: [PATCH 8/9] ARM: dts: r8a7793: Reserve SRAM for the SMP jump stub
In-Reply-To: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
References: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499182903-31339-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reserve SRAM for the jump stub for CPU core bringup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index bc6a44272f555215..497716b6fbe24164 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -856,6 +856,14 @@
 	icram1:	sram at e63c0000 {
 		compatible = "mmio-sram";
 		reg = <0 0xe63c0000 0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0xe63c0000 0x1000>;
+
+		smp-sram at 0 {
+			compatible = "renesas,smp-sram";
+			reg = <0 0x10>;
+		};
 	};
 
 	ether: ethernet at ee700000 {
-- 
2.7.4
