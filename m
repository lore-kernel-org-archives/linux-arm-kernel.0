From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Nov 2018 16:41:48 -0800
Subject: [PATCH] ARM: brcmstb: Add entry for 7255
Message-ID: <20181107004151.20370-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Justin Chen <justinpopo6@gmail.com>

Add in BCM7255 entry and reorder entries to keep ascending order. Also
moved 7278 cause it was out of order.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 0f580caa81e5..bf8702ee8f86 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -26,8 +26,9 @@
 
 #define UARTA_3390		REG_PHYS_ADDR(0x40a900)
 #define UARTA_7250		REG_PHYS_ADDR(0x40b400)
-#define UARTA_7260		REG_PHYS_ADDR(0x40c000)
-#define UARTA_7268		UARTA_7260
+#define UARTA_7255		REG_PHYS_ADDR(0x40c000)
+#define UARTA_7260		UARTA_7255
+#define UARTA_7268		UARTA_7255
 #define UARTA_7271		UARTA_7268
 #define UARTA_7278		REG_PHYS_ADDR_V7(0x40c000)
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
@@ -82,15 +83,16 @@ ARM_BE8(	rev	\rv, \rv )
 		/* Chip specific detection starts here */
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
 21:		checkuart(\rp, \rv, 0x72500000, 7250)
-22:		checkuart(\rp, \rv, 0x72600000, 7260)
-23:		checkuart(\rp, \rv, 0x72680000, 7268)
-24:		checkuart(\rp, \rv, 0x72710000, 7271)
-25:		checkuart(\rp, \rv, 0x73640000, 7364)
-26:		checkuart(\rp, \rv, 0x73660000, 7366)
-27:		checkuart(\rp, \rv, 0x07437100, 74371)
-28:		checkuart(\rp, \rv, 0x74390000, 7439)
-29:		checkuart(\rp, \rv, 0x74450000, 7445)
-30:		checkuart(\rp, \rv, 0x72780000, 7278)
+22:		checkuart(\rp, \rv, 0x72550000, 7255)
+23:		checkuart(\rp, \rv, 0x72600000, 7260)
+24:		checkuart(\rp, \rv, 0x72680000, 7268)
+25:		checkuart(\rp, \rv, 0x72710000, 7271)
+26:		checkuart(\rp, \rv, 0x72780000, 7278)
+27:		checkuart(\rp, \rv, 0x73640000, 7364)
+28:		checkuart(\rp, \rv, 0x73660000, 7366)
+29:		checkuart(\rp, \rv, 0x07437100, 74371)
+30:		checkuart(\rp, \rv, 0x74390000, 7439)
+31:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.17.1
