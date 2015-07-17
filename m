From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Fri, 17 Jul 2015 16:39:38 +0200
Subject: [PATCH v11 1/5] ARM: sun4i: dt: Add Security System to A10 SoC DTS
In-Reply-To: <1437143983-4479-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1437143983-4479-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1437143983-4479-2-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Security System is a hardware cryptographic accelerator that support
AES/MD5/SHA1/DES/3DES/PRNG algorithms.
It could be found on many Allwinner SoC.

This patch enable the Security System on the Allwinner A10 SoC Device-tree.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 61c03d1..551e3d1 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -643,6 +643,14 @@
 			status = "disabled";
 		};
 
+		crypto: crypto-engine at 01c15000 {
+			compatible = "allwinner,sun4i-a10-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <86>;
+			clocks = <&ahb_gates 5>, <&ss_clk>;
+			clock-names = "ahb", "mod";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
-- 
2.3.6
