From: pawel.moll@arm.com (Pawel Moll)
Date: Wed,  7 Dec 2011 18:51:10 +0000
Subject: [PATCH v2] ARM: Add Cortex-A7 proc info
In-Reply-To: <20111206232822.GB16212@mudshark.cambridge.arm.com>
References: <20111206232822.GB16212@mudshark.cambridge.arm.com>
Message-ID: <1323283870-1705-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds processor info for ARM Ltd. Cortex-A7.

A7 is (nearly) architecturally identical to A15 so
it shares the same SMP initialization code and hwcaps.

Tested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mm/proc-v7.S |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c559ac..ea679ec 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -284,6 +284,7 @@ __v7_ca5mp_setup:
 __v7_ca9mp_setup:
 	mov	r10, #(1 << 0)			@ TLB ops broadcasting
 	b	1f
+__v7_ca7mp_setup:
 __v7_ca15mp_setup:
 	mov	r10, #0
 1:
@@ -463,6 +464,16 @@ __v7_ca5mp_proc_info:
 	.size	__v7_ca5mp_proc_info, . - __v7_ca5mp_proc_info
 
 	/*
+	 * ARM Ltd. Cortex A7 processor.
+	 */
+	.type	__v7_ca7mp_proc_info, #object
+__v7_ca7mp_proc_info:
+	.long	0x410fc070
+	.long	0xff0ffff0
+	__v7_proc __v7_ca7mp_setup, hwcaps = HWCAP_IDIV
+	.size	__v7_ca7mp_proc_info, . - __v7_ca7mp_proc_info
+
+	/*
 	 * ARM Ltd. Cortex A9 processor.
 	 */
 	.type   __v7_ca9mp_proc_info, #object
-- 
1.7.5.4
