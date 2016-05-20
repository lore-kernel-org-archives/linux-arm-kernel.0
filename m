From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 May 2016 09:10:00 +0200
Subject: [PATCH v2 09/23] ARM: dts: sh73a0: Fix W=1 dtc warnings
In-Reply-To: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463728214-13838-10-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /cache-controller has a reg or ranges property, but no unit name

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index c4f434cdec60f075..032fe2f14b16998f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -55,7 +55,7 @@
 		      <0xf0000100 0x100>;
 	};
 
-	L2: cache-controller {
+	L2: cache-controller at f0100000 {
 		compatible = "arm,pl310-cache";
 		reg = <0xf0100000 0x1000>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
