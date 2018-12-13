Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D2C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:58:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04362086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1DfxKJp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gu9DL85K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04362086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s15ZNBkF8Uk9rPtgNoo6aoaruu5gP6vgxdNZR/HAGHE=; b=F1DfxKJpgVsWfd
	h4XY7eFBTxjRYutVX+w1x0sETOF162ufZjnMrD/iGiyD0kpNZUX7MU0la2pPGD6Gp73nuN9hH5KMz
	TF98OajOdNeNDocUCUJIWOGLlq73eegOKip0K17OpQia6SBM21Mji/vHPFLiBkQ00vvmlRsTj4gbL
	F9QBxywacx4DTYQNJH3s5Df7vS6e5USEG2HdgW7g4UInLjbAKCwq43ofsIG6CaoQQNbrkgkCuXSIZ
	1AhB4hHtu69nbvm25wK57Wdmj81ygaQw7tBYjVxmLdwRRD7hGFdouv3/WgXYXSrQgWpeB4GOOdREh
	7E8EkEiaLLlnaJd1dJ0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPcv-0001n1-3C; Thu, 13 Dec 2018 11:58:01 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPcr-0000cy-KW
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5gO+1allLNFP9426eL/dx7tSwLKRpsxZACNNbujQWCg=; b=gu9DL85Kzpbco+XUcYp/Dgl+n7
 yvNAtaMxyfFVpoWDDtkfqO1bBLSi2iShC56uiytFM9+6MjDDtNvXl/kzUnYYbegZXEHxLpHrI8UnJ
 i30OsTfbrsSuZb8wAR537c82rtA3HSgz08q3pf1AoFvWTcYiaZ36bBFtVOQcyQcMkwAQ=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:57960 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXPab-0002Ey-5V; Thu, 13 Dec 2018 11:55:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXPaa-00063v-L6; Thu, 13 Dec 2018 11:55:36 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/5] ARM: omap2: remove unnecessary boot_lock
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXPaa-00063v-L6@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 11:55:36 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_035757_671901_9F534D48 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-omap2/omap-smp.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 1c73694c871a..10e070368f64 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -69,8 +69,6 @@ static const struct omap_smp_config omap5_cfg __initconst = {
 	.startup_addr = omap5_secondary_startup,
 };
 
-static DEFINE_SPINLOCK(boot_lock);
-
 void __iomem *omap4_get_scu_base(void)
 {
 	return cfg.scu_base;
@@ -173,12 +171,6 @@ static void omap4_secondary_init(unsigned int cpu)
 		/* Enable ACR to allow for ICUALLU workaround */
 		omap5_secondary_harden_predictor();
 	}
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
 }
 
 static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -188,12 +180,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	static struct powerdomain *cpu1_pwrdm;
 
 	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
 	 * omap4_secondary_startup() routine will hold the secondary core till
 	 * the AuxCoreBoot1 register is updated with cpu state
@@ -266,12 +252,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	/*
-	 * Now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
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
