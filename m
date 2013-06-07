From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Jun 2013 12:04:19 +0200
Subject: [PATCH v4 1/2] ARM: PJ4B: Fix the CPU ID and the mask associated to
 the PJ4B
In-Reply-To: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
References: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1370599460-9947-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the ID and mask for the PJ4B which was too
restrictive and didn't match the CPU of the Armada 370 SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/proc-v7.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c73a73..fe3a9d3 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -409,8 +409,8 @@ __v7_ca9mp_proc_info:
 	 */
 	.type   __v7_pj4b_proc_info, #object
 __v7_pj4b_proc_info:
-	.long	0x562f5840
-	.long	0xfffffff0
+	.long   0x560f5800
+	.long	0xff0fff00
 	__v7_proc __v7_pj4b_setup
 	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
 
-- 
1.8.1.2
