From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 20 May 2011 14:39:29 +0100
Subject: [PATCH v3 2/2] arm: Add Cortex A5 proc info
In-Reply-To: <1305898769-10462-1-git-send-email-pawel.moll@arm.com>
References: <1305892312.17656.72.camel@hornet.cambridge.arm.com>
	<1305898769-10462-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1305898769-10462-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds processor info for ARM Ltd. Cortex A5,
which has SCU initialisation procedure identical to A9.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mm/proc-v7.S |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index e5087aa..4a23638 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -275,6 +275,7 @@ cpu_resume_l1_flags:
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
1.6.3.3
