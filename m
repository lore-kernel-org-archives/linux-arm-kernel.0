From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 05 Sep 2014 10:41:28 +0100
Subject: [PATCH FYI 1/4] ARM: remove extraneous newline in show_regs()
In-Reply-To: <20140905094056.GD30401@n2100.arm.linux.org.uk>
References: <20140905094056.GD30401@n2100.arm.linux.org.uk>
Message-ID: <E1XPq1I-0000RA-9i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove an unnecessary newline in show_regs().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686a91ca..52a21dafb27e 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -306,7 +306,6 @@ void __show_regs(struct pt_regs *regs)
 
 void show_regs(struct pt_regs * regs)
 {
-	printk("\n");
 	__show_regs(regs);
 	dump_stack();
 }
-- 
1.8.3.1
