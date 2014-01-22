From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 21 Jan 2014 19:30:48 -0800
Subject: [PATCH v5 4/8] ARM: do CPU-specific init for Broadcom Brahma15 cores
In-Reply-To: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
References: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1390361452-3124-5-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perform any CPU-specific initialization required on the
Broadcom Brahma-15 core.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/proc-v7.S |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index bd17819..98ea423 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -193,6 +193,7 @@ __v7_cr7mp_setup:
 	b	1f
 __v7_ca7mp_setup:
 __v7_ca15mp_setup:
+__v7_b15mp_setup:
 	mov	r10, #0
 1:
 #ifdef CONFIG_SMP
@@ -494,6 +495,16 @@ __v7_ca15mp_proc_info:
 	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
 
 	/*
+	 * Broadcom Corporation Brahma-B15 processor.
+	 */
+	.type	__v7_b15mp_proc_info, #object
+__v7_b15mp_proc_info:
+	.long	0x420f00f0
+	.long	0xff0ffff0
+	__v7_proc __v7_b15mp_setup, hwcaps = HWCAP_IDIV
+	.size	__v7_b15mp_proc_info, . - __v7_b15mp_proc_info
+
+	/*
 	 * Qualcomm Inc. Krait processors.
 	 */
 	.type	__krait_proc_info, #object
-- 
1.7.1
