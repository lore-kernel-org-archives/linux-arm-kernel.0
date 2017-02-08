From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  8 Feb 2017 15:37:11 -0500
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Fix UARTs on bcm953012k
In-Reply-To: <1486586232-6695-1-git-send-email-jon.mason@broadcom.com>
References: <1486586232-6695-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1486586232-6695-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UARTs are outputting garbage on the console.  This is due to a speed
issue.  We can simply use the clock speed (which is now defined in the
DTSI file) and everything works fine.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: cdc36b22 ("ARM: dts: enable clock support for BCM5301X")
---
 arch/arm/boot/dts/bcm953012k.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index bfd9230..da5aa8f 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -53,10 +53,9 @@
 };
 
 &uart0 {
-	clock-frequency = <62499840>;
+	status = "okay";
 };
 
 &uart1 {
-	clock-frequency = <62499840>;
 	status = "okay";
 };
-- 
2.7.4
