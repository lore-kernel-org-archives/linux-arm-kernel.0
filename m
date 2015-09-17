From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Thu, 17 Sep 2015 17:28:46 +0800
Subject: [PATCH 1/2] arm: Add msi.h to arch Kbuild files
Message-ID: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds msi.h to arch Kbuild files to avoid the following
compile error when selecting PCI_MSI_IRQ_DOMAIN

include/linux/msi.h:172:21: fatal error: asm/msi.h: No such
file or directory

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/arm/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index be648eb..bd42530 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += param.h
 generic-y += parport.h
 generic-y += poll.h
-- 
1.9.1
