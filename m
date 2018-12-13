Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C017C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E0720851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YYfg+Nie";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aA8LM/dT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E0720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwFYQypDBOso/cSqs6cSUn7BefRIW2lCbZbx1d1O7aQ=; b=YYfg+NievVwpXQ
	duWstux3W9PRcEj3m6TmzEHDrXO+pgYdNF/TLPhgnZS+lempe3BvN5R5U8JXhdMhimL64fJqpBYiw
	tpMANNZVi688r+FHVrM1HLtI2aLOEBz0tjKN7mzC/d36hLuWLrU6GreFx9nASbLEeB/ZzKDLEUag0
	9IiM5t3rCqTS26YjEkZr0knGp0C1fkq/6dEW9OlQe9vwGdK7qkFbK9+Jy/xuomnhkSdy74eKyHni5
	OBuBM3IILvhmtd8Gq2xQMEOf1JF7GMCCrEVZLwssq6sQYabmVbOl4EpemqODU2/NuWNA5I8+vwWGV
	KwZApu5h6BxaTuSI15WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVIh-0006Xg-Nb; Thu, 13 Dec 2018 18:01:31 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVIO-00063I-GH
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V8bov3LQxKS+0wgZ/p0gc863/fFXgsfqhoabofSGwog=; b=aA8LM/dTq3dtk+PwBBk94AzpNq
 tt5Y5420nZ/aICO6UyuaRKsck1QHJpTItEAYKgVE36DoWHJRmZmaa4O16SwdfmVWb3lefsfb6SxaK
 cbuxnC/QO7RyXbGJDjm+ZUOdxk4cAt4yu5xOWwwLjLOBThOAi2ETixlL7mNleAzj4fUU=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:58688 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVI5-0003sF-9Z; Thu, 13 Dec 2018 18:00:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVI3-00088u-N6; Thu, 13 Dec 2018 18:00:52 +0000
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 3/9] ARM: oxnas: remove CPU hotplug implementation
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:00:51 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_100112_597803_57CBB835 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CPU hotplug implementation on this platform is cargo-culted from
the plat-versatile implementation, and is buggy.  Once a CPU hits the
"low power" loop, it will wait for pen_release to be set to the CPU
number to wake up again - but nothing in this implementation does that.

So, once a CPU has entered cpu_die() it will never, ever leave.

Remove this useless cargo-culted implementation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-oxnas/Makefile  |   1 -
 arch/arm/mach-oxnas/hotplug.c | 109 ------------------------------------------
 arch/arm/mach-oxnas/platsmp.c |   4 --
 3 files changed, 114 deletions(-)
 delete mode 100644 arch/arm/mach-oxnas/hotplug.c

diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
index b625906a9970..61a34e1c0f22 100644
--- a/arch/arm/mach-oxnas/Makefile
+++ b/arch/arm/mach-oxnas/Makefile
@@ -1,2 +1 @@
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU) 	+= hotplug.o
diff --git a/arch/arm/mach-oxnas/hotplug.c b/arch/arm/mach-oxnas/hotplug.c
deleted file mode 100644
index 854f29b8cba6..000000000000
--- a/arch/arm/mach-oxnas/hotplug.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
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
-void ox820_cpu_die(unsigned int cpu)
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
diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
index 442cc8a2f7dc..735141c0e3a3 100644
--- a/arch/arm/mach-oxnas/platsmp.c
+++ b/arch/arm/mach-oxnas/platsmp.c
@@ -19,7 +19,6 @@
 #include <asm/smp_scu.h>
 
 extern void ox820_secondary_startup(void);
-extern void ox820_cpu_die(unsigned int cpu);
 
 static void __iomem *cpu_ctrl;
 static void __iomem *gic_cpu_ctrl;
@@ -94,9 +93,6 @@ static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
 static const struct smp_operations ox820_smp_ops __initconst = {
 	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
 	.smp_boot_secondary	= ox820_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_die		= ox820_cpu_die,
-#endif
 };
 
 CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
