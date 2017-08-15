From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 15 Aug 2017 10:25:58 -0700
Subject: [PATCH 1/6] ARM: dts: cygnus: Fix incorrect UART2 register base
In-Reply-To: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
References: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502817964-8221-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ray Jui <ray.jui@broadcom.com>

Fix incorrect Cygnus UART2 register base.

Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi bus")
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index bf8c838..e4d07f4 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -324,7 +324,7 @@
 
 		uart2: serial at 18022000 {
 			compatible = "snps,dw-apb-uart";
-			reg = <0x18020000 0x100>;
+			reg = <0x18022000 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.5.0
