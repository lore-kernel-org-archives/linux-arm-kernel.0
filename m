Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE67C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:09:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07E820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RnMJtmVK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dwd5bMw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07E820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aVxGrgL/BFUWI+u1ZSCvjPWMtqFIZ+fel15zCODYZOY=; b=RnMJtmVKlVoRiF
	Ur1wGKVIdZ3pLWodjUPQIfgvfP7bGPnnoZu1Uryjg54QZ/rs3EsUUiA5SxysNh5v8vWmYbGhV3ziB
	6ah9YbqPTqbMLLBH+xYIV+iTd5Qx/DWXQxFRfrvwNmUeKKp1bDES3lSQ4Y+6PM2Lzbkbx66bciv27
	md3oYPxAUqtj65bZI+044vDHNhQopzPTseHwmo6it6/CACOS6yXh2PdnHF6PvdbbzMw4gfbr7ffZ8
	n4kyx3mxT0tvnZumJocjAFODT/CWU/9ob4uexlUQLMUm37h3JuLtdRDXLQgQuq5Fva+33fwRyK/zn
	G4kn7lFnIfntyDWDAc0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWd6P-0005XI-84; Tue, 11 Dec 2018 08:09:13 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd5g-0004gn-49
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:08:30 +0000
Received: by mail-lj1-x243.google.com with SMTP id s5-v6so12060792ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T0MWmG1riva3RgXLTy3LlIplAcOrr/gOolaDarpBxRE=;
 b=Dwd5bMw1tcymXBgTWrMgIwIuhpyFGhdIsJRgRb1X2/QuqTwVR4kYZ0ckUtvRCJfpZG
 nC9BA2McJosGNDVLX65Ga3Wg40gjs1xXPudM+TiwvYgNfab9wWm71wvV2geiIKtyDzJv
 1my2MJX/hrS8mfDAoGOJG6Ifzm7+y3RW9qxrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T0MWmG1riva3RgXLTy3LlIplAcOrr/gOolaDarpBxRE=;
 b=ocrDRi76ZvJ6GkQkBu+1l0jzi3Fgs+5pN+JYWqR6gIKIFTrttrhpfYS7+RhWA/HKC4
 ngkJW5EWYx4l3jvjAcMjifPRcr0Rs1e5suDhAD8iFxD8BMgjUJbWfrueJrlwEgo21o3C
 siYbZN6zixJTyOxYPrxg/rmP5JeWvNCyxACEp1gbE4gj5z70a5pBBn8ELHMiuR+pGTmg
 eTEblWWNQojHaJCR6BZM0Z7tarMzLGvC7fUsKQ+UvAaFxMq76uGs83Ww4ip9W+kyAwd2
 kvaqAJjOGTn5F2ZrhUxnIm0tkRaN6vnZdyT7ObnChZI10lhbgzB6h4wJqJWLHjpexfiD
 o4tQ==
X-Gm-Message-State: AA+aEWbi46TGy14HC5SHW+jpnDMrUyC3sbSxOebHuFimDAp4kCWAus0I
 ZqVRvbrYh1oT9TmeWNQfEkDZ1A==
X-Google-Smtp-Source: AFSGD/V3GqGwna7bareKUBh8Lw74TMMmP6MsoLhGzjaAeXGO6Q2KCv8b44DE0zgNzcsF5/ZleZsAGw==
X-Received: by 2002:a2e:58b:: with SMTP id
 133-v6mr9761754ljf.127.1544515696128; 
 Tue, 11 Dec 2018 00:08:16 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2524424lji.6.2018.12.11.00.08.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 00:08:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] RFT: ARM: actions: Simplify secondary boot
Date: Tue, 11 Dec 2018 09:07:59 +0100
Message-Id: <20181211080759.3150-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211080759.3150-1-linus.walleij@linaro.org>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000828_210656_42A295AE 
X-CRM114-Status: GOOD (  15.92  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Actions SMP boot contain some cargo cult code that
we need to get rid of: it uses a probably completely
unnecessary spinlock (the ARM core SMP code will lock
properly already) and tries to keep CPUs in the "pen"
(CPU enclosure) using the custom variable that should
only be used with ARM Versatile test chips.

Simply drop this and also remove the smp_send_reschedule()
that no other ARM machine is using to start a secondary
CPU and just send arch_send_wakeup_ipi_mask() to kick
secondary CPUs out of WFI.

Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch was made after talking to Russell about ARM
machines doing pointless "pen holding" and using
pointless boot locks. Would be great if you can test
if it simply works like this, make sure both CPUs
come up, I usually just start a few dummy processes
and cat /proc/interrupts to see that the different
CPUs are getting work done.
---
 arch/arm/mach-actions/platsmp.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 26ddc12ea4a7..c19477fed340 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -36,7 +36,6 @@
 
 static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
-static DEFINE_SPINLOCK(boot_lock);
 
 static int s500_wakeup_secondary(unsigned int cpu)
 {
@@ -79,7 +78,6 @@ static int s500_wakeup_secondary(unsigned int cpu)
 
 static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
 	int ret;
 
 	ret = s500_wakeup_secondary(cpu);
@@ -88,20 +86,10 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	udelay(10);
 
-	spin_lock(&boot_lock);
-
-	smp_send_reschedule(cpu);
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		if (pen_release == -1)
-			break;
-	}
-
 	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
 
-	spin_unlock(&boot_lock);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 	return 0;
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
