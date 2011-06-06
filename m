From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:46 +0100
Subject: [PATCH 02/11] arm: Add Cortex A5 proc info
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pawel Moll <pawel.moll@arm.com>

This patch adds processor info for ARM Ltd. Cortex A5,
which has SCU initialisation procedure identical to A9.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mm/proc-v7.S |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d5245d4..7f482c2 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -273,6 +273,7 @@ cpu_resume_l1_flags:
  *	It is assumed that:
  *	- cache type register is implemented
  */
+__v7_ca5mp_setup:
 __v7_ca9mp_setup:
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
@@ -459,6 +460,16 @@ cpu_elf_name:
 .endm
 
 	/*
+	 * ARM Ltd. Cortex A5 processor.
+	 */
+	.type   __v7_ca5mp_proc_info, #object
+__v7_ca5mp_proc_info:
+	.long	0x410fc050
+	.long	0xff0ffff0
+	__v7_proc __v7_ca5mp_setup
+	.size	__v7_ca5mp_proc_info, . - __v7_ca5mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A9 processor.
 	 */
 	.type   __v7_ca9mp_proc_info, #object
-- 
1.7.0.4
