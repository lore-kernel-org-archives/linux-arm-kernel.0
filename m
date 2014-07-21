From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 21 Jul 2014 14:07:59 -0700
Subject: [PATCH v8 04/11] ARM: do CPU-specific init for Broadcom Brahma15 cores
In-Reply-To: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1405976886-27807-5-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Carino <marc.ceeeee@gmail.com>

Perform any CPU-specific initialization required on the
Broadcom Brahma-15 core.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3db2c2f04a30..c324c0e1aae9 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -216,6 +216,7 @@ __v7_cr7mp_setup:
 __v7_ca7mp_setup:
 __v7_ca12mp_setup:
 __v7_ca15mp_setup:
+__v7_b15mp_setup:
 __v7_ca17mp_setup:
 	mov	r10, #0
 1:
@@ -528,6 +529,16 @@ __v7_ca15mp_proc_info:
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
 	 * ARM Ltd. Cortex A17 processor.
 	 */
 	.type	__v7_ca17mp_proc_info, #object
-- 
1.9.1
