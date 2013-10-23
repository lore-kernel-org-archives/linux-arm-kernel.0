From: y@lunn.ch (y at lunn.ch)
Date: Wed, 23 Oct 2013 16:12:52 +0200
Subject: [PATCH 3/3] ARM: Dove: Fix compiler warnings with C=1 builds
In-Reply-To: <1382537572-31472-1-git-send-email-y>
References: <y>
 <1382537572-31472-1-git-send-email-y>
Message-ID: <1382537572-31472-3-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add missing static keywords.
Remove the unused function dove_crypto_init().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/common.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index c122bcf..0d1a892 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -162,7 +162,7 @@ void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-void __init dove_rtc_init(void)
+static void __init dove_rtc_init(void)
 {
 	orion_rtc_init(DOVE_RTC_PHYS_BASE, IRQ_DOVE_RTC);
 }
@@ -257,18 +257,9 @@ void __init dove_timer_init(void)
 }
 
 /*****************************************************************************
- * Cryptographic Engines and Security Accelerator (CESA)
- ****************************************************************************/
-void __init dove_crypto_init(void)
-{
-	orion_crypto_init(DOVE_CRYPT_PHYS_BASE, DOVE_CESA_PHYS_BASE,
-			  DOVE_CESA_SIZE, IRQ_DOVE_CRYPTO);
-}
-
-/*****************************************************************************
  * XOR 0
  ****************************************************************************/
-void __init dove_xor0_init(void)
+static void __init dove_xor0_init(void)
 {
 	orion_xor0_init(DOVE_XOR0_PHYS_BASE, DOVE_XOR0_HIGH_PHYS_BASE,
 			IRQ_DOVE_XOR_00, IRQ_DOVE_XOR_01);
@@ -277,7 +268,7 @@ void __init dove_xor0_init(void)
 /*****************************************************************************
  * XOR 1
  ****************************************************************************/
-void __init dove_xor1_init(void)
+static void __init dove_xor1_init(void)
 {
 	orion_xor1_init(DOVE_XOR1_PHYS_BASE, DOVE_XOR1_HIGH_PHYS_BASE,
 			IRQ_DOVE_XOR_10, IRQ_DOVE_XOR_11);
-- 
1.8.4.rc3
