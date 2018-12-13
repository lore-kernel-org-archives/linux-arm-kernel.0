Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C477DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:32:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B7020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R7bXqUyR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="InZyKRgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B7020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7WUo20T3HjNYAioY0YiOgOxM+CWKoI+a8i+7BadlqKw=; b=R7bXqUyRno8DrH
	Fz/BWDvxPCqHX2RE68pNKrFxaMC+dWdNN9SPdPUnwAdaf8X+LgjTP3tsBG+bs9v/8mFAfOSAgc6oJ
	4XVQwAh4DHFKo8UVPN7XBhV7jN0K2EZ31ftPvFeJQCfX1D6s80KE34D5K2Cuo6NW2asxpticmS3Fa
	3fhpMKUZuLFfIboLRDGlp+4M/c6aYRM2fUsCtWIz4euOFnGUQu7LdAWg0OAzv12eweOaPU1HmCrDF
	Wqec58oK5L0g1Lk52YK/GG1Ev+TNG7JtsRzXczxYkj7jCi2gvdLLCgWoVMFZWQ+e8v9OX9AUWYr+A
	snI60FXuatTqhDilNN9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQAQ-00007C-Kf; Thu, 13 Dec 2018 12:32:38 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQAL-0008W3-Jf
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2AjvEzjZPWKET3LOFF5oZbtiO5O2f/VnXt1scC6S0Yk=; b=InZyKRgRDcN5kvQEG7z9XyFTf3
 MeUqqISRt7bDLumo+xGg/BGIN4WzBSqFoV8nTaW4mE2Z3pc5Pxp9+fvaoztkiarBjAeopufC21+68
 5tf7Y5o3rUlvGTHxLtJxdHQ03GE9myUuSZu47EOSB713nwVNJ5y5JffwSLD4BcsEdZEc=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:58028 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXQA5-0002Pu-KB; Thu, 13 Dec 2018 12:32:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXQA4-0007Cl-Qw; Thu, 13 Dec 2018 12:32:17 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: vexpress/realview: consolidate immitation CPU hotplug
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXQA4-0007Cl-Qw@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 12:32:16 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_043233_991310_A30633B9 
X-CRM114-Status: GOOD (  18.19  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The only difference between the hotplug implementation for Realview
and Versatile Express are the bit in the auxiliary control register
to disable coherency.  Combine the two implentations accounting for
that difference.

Rename the functions to try to discourage cargo-cult copying of this
code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Please note that this hasn't been compile tested yet.

 arch/arm/mach-realview/Makefile                    |   1 -
 arch/arm/mach-realview/hotplug.c                   | 111 ---------------------
 arch/arm/mach-realview/hotplug.h                   |   1 -
 arch/arm/mach-realview/platsmp-dt.c                |   7 ++
 arch/arm/mach-vexpress/Makefile                    |   1 -
 arch/arm/mach-vexpress/core.h                      |   2 -
 arch/arm/mach-vexpress/platsmp.c                   |   7 ++
 arch/arm/plat-versatile/Makefile                   |   1 +
 .../{mach-vexpress => plat-versatile}/hotplug.c    |  45 ++++-----
 arch/arm/plat-versatile/include/plat/platsmp.h     |   1 +
 10 files changed, 36 insertions(+), 141 deletions(-)
 delete mode 100644 arch/arm/mach-realview/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.h
 rename arch/arm/{mach-vexpress => plat-versatile}/hotplug.c (58%)

diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index adf39ad71cc3..6ca6400fa51e 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -5,4 +5,3 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-versatile/inc
 
 obj-y					+= realview-dt.o
 obj-$(CONFIG_SMP)			+= platsmp-dt.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
deleted file mode 100644
index 968e2d1964f6..000000000000
--- a/arch/arm/mach-realview/hotplug.c
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/hotplug.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-
-#include <asm/cp15.h>
-#include <asm/smp_plat.h>
-
-static inline void cpu_enter_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-	"	mcr	p15, 0, %1, c7, c5, 0\n"
-	"	mcr	p15, 0, %1, c7, c10, 4\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C)
-	  : "cc");
-}
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	  : "=&r" (v)
-	  : "Ir" (CR_C)
-	  : "cc");
-}
-
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
-{
-	/*
-	 * there is no power-control hardware on this platform, so all
-	 * we can do is put the core into WFI; this is safe as the calling
-	 * code will have already disabled interrupts
-	 */
-	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
-
-		if (pen_release == cpu_logical_map(cpu)) {
-			/*
-			 * OK, proper wakeup, we're done
-			 */
-			break;
-		}
-
-		/*
-		 * Getting here, means that we have come out of WFI without
-		 * having been woken up - this shouldn't happen
-		 *
-		 * Just note it happening - when we're woken, we can report
-		 * its occurrence.
-		 */
-		(*spurious)++;
-	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void realview_cpu_die(unsigned int cpu)
-{
-	int spurious = 0;
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
-	cpu_leave_lowpower();
-
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
-}
diff --git a/arch/arm/mach-realview/hotplug.h b/arch/arm/mach-realview/hotplug.h
deleted file mode 100644
index eacd7a4dad2f..000000000000
--- a/arch/arm/mach-realview/hotplug.h
+++ /dev/null
@@ -1 +0,0 @@
-void realview_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
index c242423bf8db..3e672e12eadf 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -79,6 +79,13 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		     __pa_symbol(versatile_secondary_startup));
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void realview_cpu_die(unsigned int cpu)
+{
+	return versatile_immitation_cpu_die(cpu, 0x20);
+}
+#endif
+
 static const struct smp_operations realview_dt_smp_ops __initconst = {
 	.smp_prepare_cpus	= realview_smp_prepare_cpus,
 	.smp_secondary_init	= versatile_secondary_init,
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 51c35e2b737a..3651a1ed0f2b 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -15,6 +15,5 @@ obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
 CFLAGS_tc2_pm.o				+= -march=armv7-a
 CFLAGS_REMOVE_tc2_pm.o			= -pg
 obj-$(CONFIG_SMP)			+= platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
 
 obj-$(CONFIG_ARCH_MPS2)			+= v2m-mps2.o
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index a162ab46ee02..f4a7519084f1 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -1,5 +1,3 @@
 bool vexpress_smp_init_ops(void);
 
 extern const struct smp_operations vexpress_smp_dt_ops;
-
-extern void vexpress_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 742499bac6d0..63c9784f063f 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -82,6 +82,13 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
 	vexpress_flags_set(__pa_symbol(versatile_secondary_startup));
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void vexpress_cpu_die(unsigned int cpu)
+{
+	versatile_cpu_die(cpu, 0x40);
+}
+#endif
+
 const struct smp_operations vexpress_smp_dt_ops __initconst = {
 	.smp_prepare_cpus	= vexpress_smp_dt_prepare_cpus,
 	.smp_secondary_init	= versatile_secondary_init,
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index bff3ba889882..b2f0ddfdc4cc 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -2,3 +2,4 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/plat-versatile/hotplug.c
similarity index 58%
rename from arch/arm/mach-vexpress/hotplug.c
rename to arch/arm/plat-versatile/hotplug.c
index d8f1a05f5e87..e2d3e9035d0f 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/plat-versatile/hotplug.c
@@ -1,12 +1,15 @@
 /*
- *  linux/arch/arm/mach-realview/hotplug.c
- *
  *  Copyright (C) 2002 ARM Ltd.
  *  All Rights Reserved
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * This hotplug implementation is _specific_ to the situation found on
+ * ARM development platforms where there is _no_ possibility of actually
+ * taking a CPU offline, resetting it, or otherwise.  Real platforms must
+ * NOT copy this code.
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -15,9 +18,7 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
-#include "core.h"
-
-static inline void cpu_enter_lowpower(void)
+static inline void versatile_immitation_enter_lowpower(unsigned int actrl_mask)
 {
 	unsigned int v;
 
@@ -34,11 +35,11 @@ static inline void cpu_enter_lowpower(void)
 	"	bic	%0, %0, %2\n"
 	"	mcr	p15, 0, %0, c1, c0, 0\n"
 	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
+	  : "r" (0), "Ir" (CR_C), "Ir" (actrl_mask)
 	  : "cc");
 }
 
-static inline void cpu_leave_lowpower(void)
+static inline void versatile_immitation_leave_lowpower(unsigned int actrl_mask)
 {
 	unsigned int v;
 
@@ -50,16 +51,18 @@ static inline void cpu_leave_lowpower(void)
 	"	orr	%0, %0, %2\n"
 	"	mcr	p15, 0, %0, c1, c0, 1\n"
 	  : "=&r" (v)
-	  : "Ir" (CR_C), "Ir" (0x40)
+	  : "Ir" (CR_C), "Ir" (actrl_mask)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+static inline void versatile_immitation_do_lowpower(unsigned int cpu, int *spurious)
 {
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
-	 * code will have already disabled interrupts
+	 * code will have already disabled interrupts.
+	 *
+	 * This code should not be used outside Versatile platforms.
 	 */
 	for (;;) {
 		wfi();
@@ -83,25 +86,17 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 }
 
 /*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
+ * platform-specific code to shutdown a CPU.
+ * This code supports immitation-style CPU hotplug for Versatile/Realview/
+ * Versatile Express platforms that are unable to do real CPU hotplug.
  */
-void vexpress_cpu_die(unsigned int cpu)
+void versatile_immitation_cpu_die(unsigned int cpu, unsigned int actrl_mask)
 {
 	int spurious = 0;
 
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
-	cpu_leave_lowpower();
+	versatile_immitation_enter_lowpower(actrl_mask);
+	versatile_immitation_do_lowpower(cpu, &spurious);
+	versatile_immitation_leave_lowpower(actrl_mask);
 
 	if (spurious)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
index 50fb830192e0..9fff1f241c9e 100644
--- a/arch/arm/plat-versatile/include/plat/platsmp.h
+++ b/arch/arm/plat-versatile/include/plat/platsmp.h
@@ -12,3 +12,4 @@
 extern void versatile_secondary_startup(void);
 extern void versatile_secondary_init(unsigned int cpu);
 extern int  versatile_boot_secondary(unsigned int cpu, struct task_struct *idle);
+void versatile_immitation_cpu_die(unsigned int cpu, unsigned int actrl_mask);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
