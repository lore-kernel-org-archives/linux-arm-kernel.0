From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:41 +0200
Subject: [PATCH 1/8] arm64: kernel: don't export local symbols from head.S
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1460992188-23295-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This unexports some symbols from head.S that are only used locally.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b43417618847..ac27d8d937b2 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -638,7 +638,7 @@ ENDPROC(el2_setup)
  * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
  * in x20. See arch/arm64/include/asm/virt.h for more info.
  */
-ENTRY(set_cpu_boot_mode_flag)
+set_cpu_boot_mode_flag:
 	adr_l	x1, __boot_cpu_mode
 	cmp	w20, #BOOT_CPU_MODE_EL2
 	b.ne	1f
@@ -691,7 +691,7 @@ ENTRY(secondary_entry)
 	b	secondary_startup
 ENDPROC(secondary_entry)
 
-ENTRY(secondary_startup)
+secondary_startup:
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
@@ -706,7 +706,7 @@ ENTRY(secondary_startup)
 ENDPROC(secondary_startup)
 0:	.long	(_text - TEXT_OFFSET) - __secondary_switched
 
-ENTRY(__secondary_switched)
+__secondary_switched:
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
 	isb
-- 
2.5.0
