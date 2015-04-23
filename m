From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 23 Apr 2015 08:45:20 +0200
Subject: [PATCH v8 1/4] ARM: sun7i: dt: Add Security System to A20 SoC DTS
In-Reply-To: <1429771523-2936-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1429771523-2936-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1429771523-2936-2-git-send-email-clabbe.montjoie@gmail.com>
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
index fdd1817..51023bd 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -679,6 +679,14 @@
 			status = "disabled";
 		};
 
+		crypto: crypto-engine at 01c15000 {
+			compatible = "allwinner,sun7i-a20-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb_gates 5>, <&ss_clk>;
+			clock-names = "ahb", "mod";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
-- 
2.0.5
