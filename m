From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:41:39 +0200
Subject: [PATCH 5/9] ARM: dts: r8a7790: Reserve SRAM for the SMP jump stub
In-Reply-To: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
References: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499182903-31339-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reserve SRAM for the jump stub for CPU core bringup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4ee34995573cf505..ff986df23b62135f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -838,6 +838,14 @@
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
