From: peter.chubb@nicta.com.au (Peter Chubb)
Date: Tue, 31 May 2011 09:55:13 +1000
Subject: [PATCH] Fix typo in  mm/proc-arm7tdmi.S
Message-ID: <w4aae3bv6m.wl%peter@chubb.wattle.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a typo that prevents building for the arm7tdmi: you get an
error like `unknown size' from the assembler because symbol
__arm7dmi_proc_info is not defined.

Signed-off-by: Peter Chubb <peter.chubb@nicta.com.au>



Index: linux-2.6/arch/arm/mm/proc-arm7tdmi.S
===================================================================
--- linux-2.6.orig/arch/arm/mm/proc-arm7tdmi.S	2011-05-24 11:48:03.828496126 +1000
+++ linux-2.6/arch/arm/mm/proc-arm7tdmi.S	2011-05-24 11:48:19.724240476 +1000
@@ -139,21 +139,21 @@ __arm7tdmi_proc_info:
 		.long	0
 		b	__arm7tdmi_setup
 		.long	cpu_arch_name
 		.long	cpu_elf_name
 		.long	HWCAP_SWP | HWCAP_26BIT
 		.long	cpu_arm7tdmi_name
 		.long	arm7tdmi_processor_functions
 		.long	0
 		.long	0
 		.long	v4_cache_fns
-		.size	__arm7tdmi_proc_info, . - __arm7dmi_proc_info
+		.size	__arm7tdmi_proc_info, . - __arm7tdmi_proc_info
 
 		.type	__triscenda7_proc_info, #object
 __triscenda7_proc_info:
 		.long	0x0001d2ff
 		.long	0x0001ffff
 		.long	0
 		.long	0
 		b	__arm7tdmi_setup
 		.long	cpu_arch_name
 		.long	cpu_elf_name

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
