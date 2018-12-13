Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8358C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:56:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4662086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K2JiAvBA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gBaRuzKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4662086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JpynyDNp/yyJa3EbBX/Ms8tccxLSeH78kYku0cIsJcQ=; b=K2JiAvBAWqA1G5
	PkocPXKf0LZM+3TbI/exTmATwV50azQly6vGZTUJJ250Sb51fVN7qtMGDQDdIWJCkmu3Ct2EwUETd
	s8I3XkT7UOZwmoxR/ppKrR0REFdboEMnnCwhYnDrlQLUTp8++v3TBo3KAnW7VIPXZe63Z48y7JBJM
	EEit/bKFR2Bwvle0YDLGUAUFbNxIVanlpzIzf7QuQ7tyuB30Tl/qweOLejYOegylbKyPtC55rldQj
	mi87ZV/ylzjxSXtnxlMXAk5Ocq0Mnq3mmYJ5uApggKsrt59OuyLxZlPkgzDEVsoWe3Szfv9IAKDsh
	/cCdom5OXDV0CbKDf1Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPbR-0001F7-U1; Thu, 13 Dec 2018 11:56:29 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPbB-0000vg-4W
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Es9RBnn1L2qTSYe0DphuXplYjpi9l2zhl/9K/iit8o=; b=gBaRuzKCOizl0XJh7bJ3a68Ji0
 u6uTaDZ22r1iLDx/J0ubxca+KlbFK2pvripHNZ4LuUccVZ1RpF+PBoV6nAhF+J2dNDJLURXsufJ8f
 JtR+9Lvyg3VaTMDmOPnRXKPmk8rpiOWMcS2jJcMgg75uuRCuI0kwpGooWzedToHvQWq0=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:57970 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXPax-0002Fa-Od; Thu, 13 Dec 2018 11:55:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXPav-00064t-KY; Thu, 13 Dec 2018 11:55:57 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] ARM: actions: remove boot_lock and pen_release
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXPav-00064t-KY@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 11:55:57 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_035613_570678_D62CCDD2 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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
Cc: Andreas Färber <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The actions SMP implementation has several issues:

1. pen_release is only ever read and compared to -1, and is defined in
   arch/arm/kernel/smp.c to be -1.  This test will always succeed.

2. we are already guaranteed to be single threaded while bringing up a
   CPU, so the spinlock makes no sense, remove it.

3. owl_secondary_startup() is not referenced nor defined, the prototype
   is redundant, remove it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-actions/platsmp.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 3efaa10efc43..4fd479c948e6 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -39,10 +39,6 @@ static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static int ncores;
 
-static DEFINE_SPINLOCK(boot_lock);
-
-void owl_secondary_startup(void);
-
 static int s500_wakeup_secondary(unsigned int cpu)
 {
 	int ret;
@@ -84,7 +80,6 @@ static int s500_wakeup_secondary(unsigned int cpu)
 
 static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
 	int ret;
 
 	ret = s500_wakeup_secondary(cpu);
@@ -93,21 +88,11 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	udelay(10);
 
-	spin_lock(&boot_lock);
-
 	smp_send_reschedule(cpu);
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		if (pen_release == -1)
-			break;
-	}
-
 	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
 
-	spin_unlock(&boot_lock);
-
 	return 0;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
