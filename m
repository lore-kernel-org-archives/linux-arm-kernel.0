From: lftan@altera.com (Ley Foon Tan)
Date: Tue, 25 Aug 2015 17:35:44 +0800
Subject: [PATCH v5 1/5] arm: add msi.h to Kbuild
In-Reply-To: <1440495348-2666-1-git-send-email-lftan@altera.com>
References: <1440495348-2666-1-git-send-email-lftan@altera.com>
Message-ID: <1440495348-2666-2-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include asm-generic/msi.h to support CONFIG_GENERIC_MSI_IRQ_DOMAIN.
This to fix compilation error:
"include/linux/msi.h:123:21: fatal error: asm/msi.h:
No such file or directory"

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/arm/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 30b3bc1..362b053 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -15,6 +15,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += param.h
 generic-y += parport.h
 generic-y += poll.h
-- 
1.8.2.1
