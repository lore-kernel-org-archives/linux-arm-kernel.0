From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 20 Mar 2017 20:42:55 +0800
Subject: [PATCH] arm64: drop unnecessary newlines in show_regs()
Message-ID: <1490013775-22475-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two unnecessary newlines, one is in show_regs, another
is in __show_regs(), drop them.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 043d373..ae2a835 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -205,12 +205,10 @@ void __show_regs(struct pt_regs *regs)
 
 		pr_cont("\n");
 	}
-	printk("\n");
 }
 
 void show_regs(struct pt_regs * regs)
 {
-	printk("\n");
 	__show_regs(regs);
 }
 
-- 
1.7.12.4
