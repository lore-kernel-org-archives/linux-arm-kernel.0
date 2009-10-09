From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri,  9 Oct 2009 15:02:17 +0100
Subject: [PATCH 1/6] ARM: remove unused declaration of fpundefinstr
Message-ID: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of armksyms.c is to declare certain symbols and export them
to modules.  fpundefinstr is declared but not exported, and it has no
definition anywhere in the kernel.

(The only other use of this name is inside a comment in nwfpe/entry.S,
 as a "metavariable" in example code).

Build testing shows that the generated vmlinux is unchanged.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/kernel/armksyms.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 8214bfe..724fc10 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -47,8 +47,6 @@ extern void __aeabi_uidiv(void);
 extern void __aeabi_uidivmod(void);
 extern void __aeabi_ulcmp(void);
 
-extern void fpundefinstr(void);
-
 
 EXPORT_SYMBOL(__backtrace);
 
-- 
1.6.3.2
