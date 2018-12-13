Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C174C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138782086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VK7O/sP/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WzGp03rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138782086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f1nhGjaRUiKgIM+vZ/frNoRbuEZA7ujCLiyoxOsH3Jw=; b=VK7O/sP/6ULM1y
	ba63ClE1p9TauacU5TU7ei1IlZpBvY/q3F/4WWMHHioVJueWLn5ObFvh1wbj3o8ISz33kmCKHEh4m
	Qb2AsEf0btVOS8x47br4s2mogxoJkbS1acyDF/KnhF7emmCzhBhxeQz8Bc8v4bLzO2eaMyyq/ga0K
	pWWsR368/hgcIgFMdtEviUue4wDere3lLV3h1EnP9aUMUWjy0kvpvSlZfS5N/Zx9mxtbO38vgqNKJ
	AvTlMdBUWjjDFO4iXTNsQiSeXMT4iUeR3meOlT3SoplUN45k5vpOX0u2soDoSmHeWkay4StmUJzaF
	H8fFa/BnIBuwUwaNIPLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVUa-0005sp-6J; Thu, 13 Dec 2018 18:13:48 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVIO-00068A-GW
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ytTiQYVG3g6vcew3RCoHF4lBQZyfASgL8KIPRbyLzw=; b=WzGp03rpHEuKUXgGlpiYn6ug36
 JcHm9gdkc8FZAdjy70rK09pg11Pni8REUC6qhRDjSab5oZ0NKpNImJ1cNK0g0pE1Z0bjPcTitJUZw
 I3kl5BCXwyAohhqeGopMm5x8Z1ymAT9t/hOCs/8bRstZH3zuSOQCvOsMj56T4d020JQM=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49260 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVIA-0003sQ-UZ; Thu, 13 Dec 2018 18:00:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVI9-000897-25; Thu, 13 Dec 2018 18:00:57 +0000
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 4/9] ARM: sti: remove pen_release and boot_lock
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXVI9-000897-25@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:00:57 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_100112_816497_0E4F85FD 
X-CRM114-Status: GOOD (  19.46  )
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
Cc: Patrice Chotard <patrice.chotard@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pen_release implementation was created for Versatile platforms to
work around boot loaders that did not differentiate between the
various different secondary CPUs on this ARM development platform.
This should not be true of modern platforms where we send IPIs to
specific CPUs to wake them up.  Remove the pen_release stuff from
SoCs that make use of the per-CPU IPI mechanism.

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sti/Makefile  |  2 +-
 arch/arm/mach-sti/headsmp.S | 43 -------------------------------
 arch/arm/mach-sti/platsmp.c | 62 ++-------------------------------------------
 3 files changed, 3 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm/mach-sti/headsmp.S

diff --git a/arch/arm/mach-sti/Makefile b/arch/arm/mach-sti/Makefile
index acb330916333..f85ff059cfba 100644
--- a/arch/arm/mach-sti/Makefile
+++ b/arch/arm/mach-sti/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_ARCH_STI) 		+= board-dt.o
diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
deleted file mode 100644
index e0ad451700d5..000000000000
--- a/arch/arm/mach-sti/headsmp.S
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  arch/arm/mach-sti/headsmp.S
- *
- * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
- *		http://www.st.com
- *
- * Cloned from linux/arch/arm/mach-vexpress/headsmp.S
- *
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-/*
- * ST specific entry point for secondary CPUs.  This provides
- * a "holding pen" into which all secondary cores are held until we're
- * ready for them to initialise.
- */
-ENTRY(sti_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
-pen:	ldr	r7, [r6]
-	cmp	r7, r0
-	bne	pen
-
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
-ENDPROC(sti_secondary_startup)
-
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e17436..21668501c9bb 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -28,72 +28,15 @@
 
 #include "smp.h"
 
-static void write_pen_release(int val)
-{
-	pen_release = val;
-	smp_wmb();
-	sync_cache_w(&pen_release);
-}
-
-static DEFINE_SPINLOCK(boot_lock);
-
-static void sti_secondary_init(unsigned int cpu)
-{
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	write_pen_release(-1);
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-}
-
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
-
-	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * The secondary processor is waiting to be released from
-	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
-	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
-	 * "cpu" is Linux's internal ID.
-	 */
-	write_pen_release(cpu_logical_map(cpu));
-
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * it to jump to the secondary entrypoint.
 	 */
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
-	return pen_release != -1 ? -ENOSYS : 0;
+	return 0;
 }
 
 static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
@@ -103,7 +46,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
-	unsigned long entry_pa = __pa_symbol(sti_secondary_startup);
+	unsigned long entry_pa = __pa_symbol(secondary_startup);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
@@ -158,6 +101,5 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 
 const struct smp_operations sti_smp_ops __initconst = {
 	.smp_prepare_cpus	= sti_smp_prepare_cpus,
-	.smp_secondary_init	= sti_secondary_init,
 	.smp_boot_secondary	= sti_boot_secondary,
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
