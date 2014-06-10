From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Tue, 10 Jun 2014 14:43:16 +0200
Subject: [PATCH v3 3/4] ARM: sun7i: dt: Add Security System to A20 SoC DTS
In-Reply-To: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1402404197-4236-4-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Security System is a hardware cryptographic accelerator that support
AES/MD5/SHA1/DES/3DES/PRNG algorithms.
It could be found on many Allwinner SoC.

This patch enable the Security System on the Allwinner A20 SoC Device-tree.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6acdbdf..19b1ced 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -529,6 +529,14 @@
 			status = "disabled";
 		};
 
+		crypto: crypto-engine at 01c15000 {
+			compatible = "allwinner,sun7i-a20-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <0 86 4>;
+			clocks = <&ahb_gates 5>, <&ss_clk>;
+			clock-names = "ahb", "mod";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
-- 
1.8.5.5
