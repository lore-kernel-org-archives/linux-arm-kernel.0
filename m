Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A18C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:04:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D48820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nfEgtDeT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBuWDEYV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VDnNCLi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D48820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYDXOMAJ3e61Ow7vRLnYG9A0xDZsAD7Ka/jbFCVIhZE=; b=nfEgtDeTN+x50r
	M870TqvPdBcuzYxXzJxZ4S1vWwFe/AoQj8XZ/X1yaIKWr8PA0ALb5jkJw5I8uSztQANZaDtagCgI/
	Ak8BLZMwzBakCUHEN95oxQ5GCn7HdFYa/09J+Oz46yOfDcB550DRDjpQOIvJSqisFZUeVoZaYcZwx
	f7r7TU++A+uWeSx4uGsOdwWEO/4w6ng5rAuV4qDJhO+znjO45LOx85LlHy6mhGzxTTyBwS3P16Fa7
	mI53/bGH6gURd62iIYget6AMH47e71qCAtcZhh6OlJMGjk2ykdzBCY7eySSamCOvNdjQJPRQcj9df
	B7jem0UWePOrc8GKk9Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVLB-0000GI-Kf; Thu, 13 Dec 2018 18:04:05 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVL1-0000Dp-U5
 for linux-arm-kernel@bombadil.infradead.org; Thu, 13 Dec 2018 18:03:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h/5VpWD6jtHCErQoCjlHnGrhBEkBLuBL2tjysdL5d9A=; b=MBuWDEYVtgZTYdXCj2Nvoo2c2/
 XC8jsLwmMxO3BsZKg+L3iitxwEiXDyGCDLRT+tnI9tJnTlwyaoClCLi4QRQNooY8F2IpaGO7f6JCG
 cQSXqFHAzqWKHezDKDQhjy2Ao0s4f4EVmdm9lutOjeh5njrGwPV2esUJZ4415oIeRjSSuRUHU5TmX
 LYs0bRqoWhQijqV70ucsN+wp7O2Ym7o148d5peKaCwwjJWXttUK+OrN2DLczVlldj+kELQ6EEWdvt
 J6JI0e8GHJP1/1gbi4Ql7Tebh+3MsJGj5IJlQR9aLN4HcFg27V+ivfzt8Xa+ASEaXQz3r6XXy5RPc
 DqHVrhZQ==;
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVKz-0006Gf-2Y
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:03:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h/5VpWD6jtHCErQoCjlHnGrhBEkBLuBL2tjysdL5d9A=; b=VDnNCLi3CE3fWeYqoPSwacr6Ow
 08pSUrlsnP28S28pzpmXpuzHt04RaFN1Ac7l+UAHOLH41oBWiY/owZ+ZiRJQzbsIGXXAiB4X0uOpW
 VKZ28/sIFYvwrVJO7c7Byq5+9+7OT9RsoIqRqdpZkAnu5E9qzzM3acnkwLaV2gVWUH+k=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:59212 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVIV-0003tO-Lr; Thu, 13 Dec 2018 18:01:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVIT-0008D2-IZ; Thu, 13 Dec 2018 18:01:17 +0000
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 8/9] ARM: versatile: rename and comment SMP implementation
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXVIT-0008D2-IZ@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:01:17 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_130353_235135_01CD23DA 
X-CRM114-Status: GOOD (  22.42  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rename pen_release and boot_lock in the Versatile specific SMP
implementation, describe why these exist and state clearly that they
should not be used in production implementations.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/plat-versatile/headsmp.S              |  2 +-
 arch/arm/plat-versatile/hotplug.c              |  4 ++-
 arch/arm/plat-versatile/include/plat/platsmp.h |  1 +
 arch/arm/plat-versatile/platsmp.c              | 47 ++++++++++++++++++--------
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index 40f27e52de75..e99396dfa6f3 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -37,5 +37,5 @@ pen:	ldr	r7, [r6]
 
 	.align
 1:	.long	.
-	.long	pen_release
+	.long	versatile_cpu_release
 ENDPROC(versatile_secondary_startup)
diff --git a/arch/arm/plat-versatile/hotplug.c b/arch/arm/plat-versatile/hotplug.c
index e2d3e9035d0f..c974958417fe 100644
--- a/arch/arm/plat-versatile/hotplug.c
+++ b/arch/arm/plat-versatile/hotplug.c
@@ -18,6 +18,8 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
+#include <plat/platsmp.h>
+
 static inline void versatile_immitation_enter_lowpower(unsigned int actrl_mask)
 {
 	unsigned int v;
@@ -67,7 +69,7 @@ static inline void versatile_immitation_do_lowpower(unsigned int cpu, int *spuri
 	for (;;) {
 		wfi();
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (versatile_cpu_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
index 9fff1f241c9e..1b087fbbc700 100644
--- a/arch/arm/plat-versatile/include/plat/platsmp.h
+++ b/arch/arm/plat-versatile/include/plat/platsmp.h
@@ -8,6 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+extern volatile int versatile_cpu_release;
 
 extern void versatile_secondary_startup(void);
 extern void versatile_secondary_init(unsigned int cpu);
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 6b60f582b738..6e2836243187 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -7,6 +7,11 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * This code is specific to the hardware found on ARM Realview and
+ * Versatile Express platforms where the CPUs are unable to be individually
+ * woken, and where there is no way to hot-unplug CPUs.  Real platforms
+ * should not copy this code.
  */
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -21,18 +26,32 @@
 #include <plat/platsmp.h>
 
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
+ * versatile_cpu_release controls the release of CPUs from the holding
+ * pen in headsmp.S, which exists because we are not always able to
+ * control the release of individual CPUs from the board firmware.
+ * Production platforms do not need this.
+ */
+volatile int versatile_cpu_release = -1;
+
+/*
+ * Write versatile_cpu_release in a way that is guaranteed to be visible to
+ * all observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
-static void write_pen_release(int val)
+static void versatile_write_cpu_release(int val)
 {
-	pen_release = val;
+	versatile_cpu_release = val;
 	smp_wmb();
-	sync_cache_w(&pen_release);
+	sync_cache_w(&versatile_cpu_release);
 }
 
-static DEFINE_RAW_SPINLOCK(boot_lock);
+/*
+ * versatile_lock exists to avoid running the loops_per_jiffy delay loop
+ * calibrations on the secondary CPU while the requesting CPU is using
+ * the limited-bandwidth bus - which affects the calibration value.
+ * Production platforms do not need this.
+ */
+static DEFINE_RAW_SPINLOCK(versatile_lock);
 
 void versatile_secondary_init(unsigned int cpu)
 {
@@ -40,13 +59,13 @@ void versatile_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	write_pen_release(-1);
+	versatile_write_cpu_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	raw_spin_lock(&boot_lock);
-	raw_spin_unlock(&boot_lock);
+	raw_spin_lock(&versatile_lock);
+	raw_spin_unlock(&versatile_lock);
 }
 
 int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -57,7 +76,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	raw_spin_lock(&boot_lock);
+	raw_spin_lock(&versatile_lock);
 
 	/*
 	 * This is really belt and braces; we hold unintended secondary
@@ -65,7 +84,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * since we haven't sent them a soft interrupt, they shouldn't
 	 * be there.
 	 */
-	write_pen_release(cpu_logical_map(cpu));
+	versatile_write_cpu_release(cpu_logical_map(cpu));
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
@@ -77,7 +96,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (versatile_cpu_release == -1)
 			break;
 
 		udelay(10);
@@ -87,7 +106,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	raw_spin_unlock(&boot_lock);
+	raw_spin_unlock(&versatile_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return versatile_cpu_release != -1 ? -ENOSYS : 0;
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
