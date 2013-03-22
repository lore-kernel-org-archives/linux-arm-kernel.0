From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 22 Mar 2013 21:47:51 +0000
Subject: [PATCH] ARM64: early_printk: Fix check for CONFIG_ARM64_64K_PAGES
Message-ID: <1363988871.3728.46.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'CONFIG_' prefix is not implicit in IS_ENABLED().

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Bolle <pebolle@tiscali.nl>
---
Found by inspection.  This is not even compile-tested.

Ben.

 arch/arm64/mm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 224b44a..70b8cd4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -261,7 +261,7 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 void __iomem * __init early_io_map(phys_addr_t phys, unsigned long virt)
 {
 	unsigned long size, mask;
-	bool page64k = IS_ENABLED(ARM64_64K_PAGES);
+	bool page64k = IS_ENABLED(CONFIG_ARM64_64K_PAGES);
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/ddce6baf/attachment.sig>
