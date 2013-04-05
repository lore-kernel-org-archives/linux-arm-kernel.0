From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  5 Apr 2013 22:23:58 +0200
Subject: [PATCH v2 3/9] arm: mvebu: Enable pj4b on LPAE compilations
In-Reply-To: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365193444-13441-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

pj4b cpus are LPAE capable so enable them on LPAE compilations

Signed-off-by: Lior Amsalem <alior@marvell.com>
Tested-by: Franklin <flin@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/proc-v7.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a3c015..159c747 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -402,6 +402,8 @@ __v7_ca9mp_proc_info:
 	__v7_proc __v7_ca9mp_setup
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
 
+#endif	/* CONFIG_ARM_LPAE */
+
 	/*
 	 * Marvell PJ4B processor.
 	 */
@@ -411,7 +413,6 @@ __v7_pj4b_proc_info:
 	.long	0xfffffff0
 	__v7_proc __v7_pj4b_setup
 	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
-#endif	/* CONFIG_ARM_LPAE */
 
 	/*
 	 * ARM Ltd. Cortex A7 processor.
-- 
1.7.9.5
