From: trini@konsulko.com (Tom Rini)
Date: Wed, 21 Jun 2017 07:42:27 -0400
Subject: [PATCH 2/2] ARM: dts: dm816x: Correct the state of the write protect
 pin
In-Reply-To: <1498045347-27324-1-git-send-email-trini@konsulko.com>
References: <1498045347-27324-1-git-send-email-trini@konsulko.com>
Message-ID: <1498045347-27324-2-git-send-email-trini@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mihail Grigorov <michael.grigorov@konsulko.com>

Commit 599c376c4932 ("ARM: dts: Fix gpio interrupts for dm816x")
corrected some problems with the MMC.  However, it gets the write
protect pin backwards.  It needs to be ACTIVE_HIGH not ACTIVE_LOW.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mihail Grigorov <michael.grigorov@konsulko.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 996eba0c2e7a..c72a2132aa82 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -196,7 +196,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 };
 
 /* At least dm8168-evm rev c won't support multipoint, later may */
-- 
1.9.1
