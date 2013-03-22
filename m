From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 22 Mar 2013 21:35:23 +0000
Subject: [PATCH] ARM: autcpu12: Fix config check in autcpu12_init_late()
Message-ID: <1363988123.3728.45.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'CONFIG_' prefix is not implicit in IS_ENABLED().

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: <stable@vger.kernel.org> # 3.8+
---
Found by inspection.  This is not even compile-tested.

Ben.

 arch/arm/mach-clps711x/board-autcpu12.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f385847..8138523 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -158,7 +158,8 @@ static void __init autcpu12_init(void)
 
 static void __init autcpu12_init_late(void)
 {
-	if (IS_ENABLED(MTD_NAND_GPIO) && IS_ENABLED(GPIO_GENERIC_PLATFORM)) {
+	if (IS_ENABLED(CONFIG_MTD_NAND_GPIO) &&
+	    IS_ENABLED(CONFIG_GPIO_GENERIC_PLATFORM)) {
 		/* We are need both drivers to handle NAND */
 		platform_device_register(&autcpu12_nand_pdev);
 	}

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/1bd4af3f/attachment.sig>
