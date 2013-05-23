From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 23 May 2013 18:01:21 +0200
Subject: [PATCH] ARM: at91/dt: fix macb pinctrl_macb_rmii_mii_alt definition
Message-ID: <1369324881-31428-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PA24 pin is wrongly assigned to peripheral B.
In the current config there is 2 ETX3 pins (PA11 and PA24) and
no ETXER pin (PA22).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 70b5ccb..84c4bef 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -264,7 +264,7 @@
 						atmel,pins =
 							<0 10 0x2 0x0	/* PA10 periph B */
 							 0 11 0x2 0x0	/* PA11 periph B */
-							 0 24 0x2 0x0	/* PA24 periph B */
+							 0 22 0x2 0x0	/* PA22 periph B */
 							 0 25 0x2 0x0	/* PA25 periph B */
 							 0 26 0x2 0x0	/* PA26 periph B */
 							 0 27 0x2 0x0	/* PA27 periph B */
-- 
1.7.9.5
