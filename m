From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  9 Mar 2017 10:51:20 -0800
Subject: [PATCH 3/3] ARM: brcmstb: Add entry for 7260
In-Reply-To: <20170309185120.1713-1-f.fainelli@gmail.com>
References: <20170309185120.1713-1-f.fainelli@gmail.com>
Message-ID: <20170309185120.1713-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BCM7260 has the same UART base address as 7268, order the entries by
ascending chip number and alias the 7268 definition to the 7260
definition.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 9113d7b33ae0..52aaed2b936f 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -22,7 +22,8 @@
 
 #define UARTA_3390		REG_PHYS_ADDR(0x40a900)
 #define UARTA_7250		REG_PHYS_ADDR(0x40b400)
-#define UARTA_7268		REG_PHYS_ADDR(0x40c000)
+#define UARTA_7260		REG_PHYS_ADDR(0x40c000)
+#define UARTA_7268		UARTA_7260
 #define UARTA_7271		UARTA_7268
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
 #define UARTA_7366		UARTA_7364
@@ -62,13 +63,14 @@
 		/* Chip specific detection starts here */
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
 21:		checkuart(\rp, \rv, 0x72500000, 7250)
-22:		checkuart(\rp, \rv, 0x72680000, 7268)
-23:		checkuart(\rp, \rv, 0x72710000, 7271)
-24:		checkuart(\rp, \rv, 0x73640000, 7364)
-25:		checkuart(\rp, \rv, 0x73660000, 7366)
-26:		checkuart(\rp, \rv, 0x07437100, 74371)
-27:		checkuart(\rp, \rv, 0x74390000, 7439)
-28:		checkuart(\rp, \rv, 0x74450000, 7445)
+22:		checkuart(\rp, \rv, 0x72600000, 7260)
+23:		checkuart(\rp, \rv, 0x72680000, 7268)
+24:		checkuart(\rp, \rv, 0x72710000, 7271)
+25:		checkuart(\rp, \rv, 0x73640000, 7364)
+26:		checkuart(\rp, \rv, 0x73660000, 7366)
+27:		checkuart(\rp, \rv, 0x07437100, 74371)
+28:		checkuart(\rp, \rv, 0x74390000, 7439)
+29:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.9.3
