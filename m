From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 15 May 2014 12:17:05 +0200
Subject: [PATCH] ARM: davinci: remove checks for CONFIG_USB_MUSB_PERIPHERAL
Message-ID: <1400149025.20469.22.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol USB_MUSB_PERIPHERAL was removed in v3.1. The last two
checks for its macro now always evaluate to false. So remove these
checks.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Eyeball tested only.

This is just a straightforward cleanup. It does remove a comment. Is
that comment still useful? Anyhow, I do wonder whether a proper fix is
possible here. Perhaps Greg or Felipe knows: it is their commit
622859634a66 ("usb: musb: drop a gigantic amount of ifdeferry") that
removed USB_MUSB_PERIPHERAL. On the other hand I noticed that config
USB_MUSB_DAVINCI depends on BROKEN. So maybe properly fixing just this
small problem doesn't buy us much.

 arch/arm/mach-davinci/board-dm355-evm.c     | 4 ----
 arch/arm/mach-davinci/board-dm355-leopard.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index ecdc7d44fa70..06d63d5651f3 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -350,11 +350,7 @@ static struct davinci_mmc_config dm355evm_mmc_config = {
  * you have proper Mini-B or Mini-A cables (or Mini-A adapters)
  * the ID pin won't need any help.
  */
-#ifdef CONFIG_USB_MUSB_PERIPHERAL
-#define USB_ID_VALUE	0	/* ID pulled high; *should* float */
-#else
 #define USB_ID_VALUE	1	/* ID pulled low */
-#endif
 
 static struct spi_eeprom at25640a = {
 	.byte_len	= SZ_64K / 8,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 43bacbf15314..680a7a2d9102 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -208,11 +208,7 @@ static struct davinci_mmc_config dm355leopard_mmc_config = {
  * you have proper Mini-B or Mini-A cables (or Mini-A adapters)
  * the ID pin won't need any help.
  */
-#ifdef CONFIG_USB_MUSB_PERIPHERAL
-#define USB_ID_VALUE	0	/* ID pulled high; *should* float */
-#else
 #define USB_ID_VALUE	1	/* ID pulled low */
-#endif
 
 static struct spi_eeprom at25640a = {
 	.byte_len	= SZ_64K / 8,
-- 
1.9.0
