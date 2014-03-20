From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 20 Mar 2014 22:25:11 +0400
Subject: [PATCH] ARM: nspire: Fix compiler warning
Message-ID: <1395339911-30009-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC      arch/arm/mach-nspire/nspire.o
arch/arm/mach-nspire/nspire.c:79:2: warning: initialization from incompatible pointer type [enabled by default]
arch/arm/mach-nspire/nspire.c:79:2: warning: (near initialization for '__mach_desc_NSPIRE.restart') [enabled by default]

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-nspire/nspire.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 4b2ed2e..3d24ebf 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -63,7 +63,7 @@ static void __init nspire_init(void)
 			nspire_auxdata, NULL);
 }
 
-static void nspire_restart(char mode, const char *cmd)
+static void nspire_restart(enum reboot_mode mode, const char *cmd)
 {
 	void __iomem *base = ioremap(NSPIRE_MISC_PHYS_BASE, SZ_4K);
 	if (!base)
-- 
1.8.3.2
