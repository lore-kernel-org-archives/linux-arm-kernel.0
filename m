Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93FCC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925572085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RyaeB8rp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FD4eq5Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925572085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PQivEPx8fL3IzQ25KeHOCzrunkMGRFTiw7buRQlSNNo=; b=RyaeB8rpErc1Cn
	oPFuzgSIsubG9c3yamCuR2DZiFp3eXiHk/EY2ZBtlXfh0yV2F1S/CtlsJNi7/Y9qsdpy8/R/FrR0D
	on0bRch6qam5ITV9L7esZ3vgnKRLi6TmjQAwgZVQECKZkj3Wrj+GxTbbutFfCsPybgDJwKXa2KCDZ
	g4BBYZK/YkW7jpdcb2Vomb5TqcOfetNVbDgqx7P9Drb8X+ggez/uWSgjIt+JnCBME8Lct4QR4069l
	4QufVEn2+3HyhNGBmD5A65IFY5fatpBXepG2eatHcPCnhEVRgAF4wC6yGN4CVp7TD/lImhyGR/R/N
	WyBSkBMfpXKdkV+BlaEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCaz-0007Hh-DQ; Thu, 31 Jan 2019 13:41:33 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZN-0004cd-0r
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id m22so2600715wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=igN5IoKzzGuypW/WHng8Q0d0kyUmZgcX+TCusVRQQ20=;
 b=FD4eq5Gl8rn+2Ho+toNgwkBbm/TucRqZYioCAgmKXiO7UUsz38dYCUH/imHOkm5wip
 8gpPrcHt25ZLVZTnNJPgvK7PBaCpmxyUPSfzRobmLjZZGakbDmEcPx5uzaJLIoJGsRBu
 8/kW5H4S2W2Y43PUrP62acbUygyUfUxJ/7LXxuLP4AK8XzTMYef5j7dyND6OsLEtKNja
 EWV8TqCciGS0RYC6Au/XjFSNhpuihWOQNuW1jSL7dvdwyfAuyCEBbRI/psnVLKE2pWe8
 KpaQb2ss3uYMTRWfZWfDOhXXCUtpm8snGo210JOjfwekGnHKArNaoa1m/hQGRFN19sNb
 Rg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=igN5IoKzzGuypW/WHng8Q0d0kyUmZgcX+TCusVRQQ20=;
 b=lKPGqVa+Wy2v+j4+y/lgBT2sx6Qzr/5FyTAmOax/rziDYuzxj/o0NRn4+ZcCCkylaL
 6b44W72kOk6wpgNWAXlPB3UR9ccg/gDXw2xDko001rDMcv4uEeWMhr8PmT9qlyl00BF6
 quC7VRxNKDVgERgOuaddYanklfiscHSAiZwXjC5JUOzD4kERJ714EbIJCkVtpkOlR+mI
 XlmXVIUmZFUTOj3ZnM1eHC01LGdBMqi32HDrzDlOSfaR2DOJIw4roKVE0gOF4810qrLq
 JCiYVPkr/7iXEI38EvW77G8Sy+VF1h/k7+7rD0IV8FtuVTvU7uL/FHjdWsnmjy4RSJRX
 NE1Q==
X-Gm-Message-State: AJcUukcHpI/ElCapfyeTiChi34aJ+75guedNp14wHfVh9kHZ+xMRW+pR
 jlVPRGFwdz3T9M3oQCdKYJyhqA==
X-Google-Smtp-Source: ALg8bN7ip8V2DdRq2xPNVQi9ExZh3zHGlhWg/sL9jclMofTdkXoWeexjS67LXkNy4gbX0cZ7p2t0lw==
X-Received: by 2002:a1c:22c5:: with SMTP id i188mr29626344wmi.39.1548941990344; 
 Thu, 31 Jan 2019 05:39:50 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 07/35] ARM: davinci: aintc: use irq domain
Date: Thu, 31 Jan 2019 14:39:00 +0100
Message-Id: <20190131133928.17985-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053953_470972_39B850A2 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to create an irq domain if we want to select SPARSE_IRQ. The
cp-intc driver already supports it, but aintc doesn't. Use the helpers
provided by the generic irq chip abstraction.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 38 ++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index e539bc65d4ef..c874ea269411 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/cputype.h>
@@ -43,6 +44,7 @@
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
 static void __iomem *davinci_intc_base;
+static struct irq_domain *davinci_irq_domain;
 
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
@@ -55,17 +57,15 @@ static inline unsigned long davinci_irq_readl(int offset)
 }
 
 static __init void
-davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+davinci_irq_setup_gc(void __iomem *base,
+		     unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
-	if (!gc) {
-		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
-		       __func__, irq_start);
-		return;
-	}
+	gc = irq_get_domain_generic_chip(davinci_irq_domain, irq_start);
+	gc->reg_base = base;
+	gc->irq_base = irq_start;
 
 	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
@@ -82,13 +82,11 @@ static asmlinkage void __exception_irq_entry
 davinci_handle_irq(struct pt_regs *regs)
 {
 	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irqnr >>= 2;
 	irqnr -= 1;
 
-	generic_handle_irq(irqnr);
-	set_irq_regs(old_regs);
+	handle_domain_irq(davinci_irq_domain, irqnr, regs);
 }
 
 /* ARM Interrupt Controller Initialization */
@@ -96,6 +94,7 @@ void __init davinci_irq_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	int rv, irq_base;
 
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
 	if (WARN_ON(!davinci_intc_base))
@@ -131,8 +130,25 @@ void __init davinci_irq_init(void)
 		davinci_irq_writel(pri, i);
 	}
 
+	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
+	if (WARN_ON(irq_base < 0))
+		return;
+
+	davinci_irq_domain = irq_domain_add_legacy(NULL,
+					davinci_soc_info.intc_irq_num,
+					irq_base, 0, &irq_domain_simple_ops,
+					NULL);
+	if (WARN_ON(!davinci_irq_domain))
+		return;
+
+	rv = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+					    "AINTC", handle_edge_irq,
+					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
+	if (WARN_ON(rv))
+		return;
+
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_alloc_gc(davinci_intc_base + j, i, 32);
+		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 	set_handle_irq(davinci_handle_irq);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
