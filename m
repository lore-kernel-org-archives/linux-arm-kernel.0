From: lftan@altera.com (Ley Foon Tan)
Date: Thu, 8 Oct 2015 17:43:09 +0800
Subject: [PATCH v8 1/6] arm: add msi.h to Kbuild
In-Reply-To: <1444297394-3122-1-git-send-email-lftan@altera.com>
References: <1444297394-3122-1-git-send-email-lftan@altera.com>
Message-ID: <1444297394-3122-2-git-send-email-lftan@altera.com>
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
1.8.2.1
