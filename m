Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2950C2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oH9fQFk3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DEfqdyST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2950C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WRAfhYmzzy/8tciITwzfcjXKQsD6HzZegh0+C09DpcM=; b=oH9fQFk3HMvxOH
	S3FOdEqkOiITht9c5T2WCAW4DD21eVoD0o+vnJFUO1FE1wAYlavXF6Z3z/Um1V6dKVaTADR4bG3h4
	9X2BRIZSd6kCwphh6Nko9vhLv5j6io4+pgVRPfG50q5v9rNNO4WkPZevMOpolGLqzXql0ijbehXj/
	FpHYuEFCYaxdO+1djK0FBiV5Bs6G/sQ1XgG56fPkuuHTTXaVf3KJDs+NcfzAqhGZ/HYaCodqiR/gT
	IsmBEIyNxawNBkV+VyxCmSp/pCUOyNpCm5xJIoOSJ+IOErBit90YxPknQrO2kclMMywtvqd5fPTqe
	IUI9DfkRj28rJwpRyDJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCdH-0001Fg-4B; Thu, 31 Jan 2019 13:43:55 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZV-0004oX-2W
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:24 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so2545503wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K4gOMPK7JwLenHksVrX0ybAt1GIcZsGbGGGhyJXhtdY=;
 b=DEfqdyST9YAEVz1EtV/pIdW8aoBrW256e9qVHmBeUZDofeRTYA9P6vaW1Cm/2LzvOy
 koCL5xjTAw6olPhlaZyfP34LRP0LcUXO65jiHZ+XiPTfzby08xryJi1xl1Kpk2iFROt6
 7fB2ZyGa+0j5aZKMQ4BvIARpTo22GoB4OVWLlvaB6sxRl2RI5+HdyQTsNaPOM70gyJNK
 KDSAe838+rOu9vXhRJuyGtEMl7rp+j4VTPUl5bkcVHuSYHa8MBolPzKAMl1D8DV0uOHx
 nvNiLQ39EUH/bcpnDQDiNNICA0Da3/BSiJyJveyEfnfn3zjZtD+BQebEOCqLSnMNCBa4
 QKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K4gOMPK7JwLenHksVrX0ybAt1GIcZsGbGGGhyJXhtdY=;
 b=YMrF4/XS/MC9UpgRDzwozQPPXJez29MMvZF5Jy4ApsvesHl068fxwGhLu1VYQbBYic
 /xl3unSzqv1K8c63wZJvoQsFSfRFS2IR9ukre/bEb0mH2UyKIVzMGPsqFf7HIsAP4fxB
 RfThyXWE1FrBycR3BhUya66aGpw0O6s1HaJm46QdVJCWbCI7180j+/sTaujoLPo6KKQj
 4wlaj5WV9uSQ3Y8Gy80D2UYIxfk5555quDulLKIEjoRbuVjCRualXuxsPO8rH3oWMo3q
 vr4iYXaTdLMgxl8IEJAQIPXXaygNMAxF8R/Mwdk44aj2ZOigAPRJeVKGMyyFcvaEimC1
 yhvg==
X-Gm-Message-State: AJcUukdqjRQpTsx34UFLyMAcmDRNPTIp+amFtmfPwcVCjBxiX8rX95XX
 Bg0TD4lf73rpcBIYY6mtr9lwnQ==
X-Google-Smtp-Source: ALg8bN7Fn0JRQyTqUKqHPKMNVeF06hOd2dDvbVr9wl3LpkcOz0KIAZQhSUn1uvU7rYYYylf82q9EdA==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr29414917wme.16.1548941999661; 
 Thu, 31 Jan 2019 05:39:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:59 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 15/35] ARM: davinci: aintc: use the new config structure
Date: Thu, 31 Jan 2019 14:39:08 +0100
Message-Id: <20190131133928.17985-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054003_360949_7B1FEAD3 
X-CRM114-Status: GOOD (  16.22  )
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

Modify the aintc driver to take all its configuration from the new
config structure. Stop referencing davinci_soc_info in any way.
Move the declaration for davinci_aintc_init() to irq-davinci-aintc.h
and make it take the new config structure as parameter. Convert all
users to the new version.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c               |  2 +-
 arch/arm/mach-davinci/dm365.c               |  2 +-
 arch/arm/mach-davinci/dm644x.c              |  2 +-
 arch/arm/mach-davinci/dm646x.c              |  2 +-
 arch/arm/mach-davinci/include/mach/common.h |  2 --
 arch/arm/mach-davinci/irq.c                 | 35 ++++++++++++---------
 include/linux/irqchip/irq-davinci-aintc.h   |  2 ++
 7 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 0dcfcbec522a..a0bfb3602136 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -751,7 +751,7 @@ static const struct davinci_aintc_config dm355_aintc_config = {
 
 void __init dm355_init_irqs(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm355_aintc_config);
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1878c97e5df5..eab575873255 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1008,7 +1008,7 @@ static const struct davinci_aintc_config dm365_aintc_config = {
 
 void __init dm365_init_irqs(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm365_aintc_config);
 }
 
 static int __init dm365_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 5c48a5e4090b..24ad7a09aa15 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -685,7 +685,7 @@ static const struct davinci_aintc_config dm644x_aintc_config = {
 
 void __init dm644x_init_irqs(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm644x_aintc_config);
 }
 
 void __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index e06ea3b61011..ab02cc93813a 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -646,7 +646,7 @@ static const struct davinci_aintc_config dm646x_aintc_config = {
 
 void __init dm646x_init_irqs(void)
 {
-	davinci_aintc_init();
+	davinci_aintc_init(&dm646x_aintc_config);
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 9cf3a36a802a..9e06974c85bb 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -19,8 +19,6 @@
 
 void davinci_timer_init(struct clk *clk);
 
-extern void davinci_aintc_init(void);
-
 struct davinci_timer_instance {
 	u32		base;
 	u32		bottom_irq;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index b31821e89a46..d67f443a471d 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
@@ -77,13 +78,14 @@ davinci_aintc_handle_irq(struct pt_regs *regs)
 }
 
 /* ARM Interrupt Controller Initialization */
-void __init davinci_aintc_init(void)
+void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 {
-	unsigned i, j;
-	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	unsigned int irq_off, reg_off, prio, shift;
 	int rv, irq_base;
+	const u8 *prios;
 
-	davinci_aintc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
+	davinci_aintc_base = ioremap(config->reg.start,
+				     resource_size(&config->reg));
 	if (WARN_ON(!davinci_aintc_base))
 		return;
 
@@ -109,22 +111,22 @@ void __init davinci_aintc_init(void)
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
 
-	for (i = DAVINCI_AINTC_IRQ_INTPRI0_REG; i <= DAVINCI_AINTC_IRQ_INTPRI7_REG; i += 4) {
-		u32		pri;
+	prios = config->prios;
 
-		for (j = 0, pri = 0; j < 32; j += 4, davinci_def_priorities++)
-			pri |= (*davinci_def_priorities & 0x07) << j;
-		davinci_aintc_writel(pri, i);
+	for (reg_off = DAVINCI_AINTC_IRQ_INTPRI0_REG;
+	     reg_off <= DAVINCI_AINTC_IRQ_INTPRI7_REG; reg_off += 4) {
+		for (shift = 0, prio = 0; shift < 32; shift += 4, prios++)
+			prio |= (*prios & 0x07) << shift;
+		davinci_aintc_writel(prio, reg_off);
 	}
 
-	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
+	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (WARN_ON(irq_base < 0))
 		return;
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
-					davinci_soc_info.intc_irq_num,
-					irq_base, 0, &irq_domain_simple_ops,
-					NULL);
+						config->num_irqs, irq_base, 0,
+						&irq_domain_simple_ops, NULL);
 	if (WARN_ON(!davinci_aintc_irq_domain))
 		return;
 
@@ -134,8 +136,11 @@ void __init davinci_aintc_init(void)
 	if (WARN_ON(rv))
 		return;
 
-	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_aintc_setup_gc(davinci_aintc_base + j, irq_base + i, 32);
+	for (irq_off = 0, reg_off = 0;
+	     irq_off < config->num_irqs;
+	     irq_off += 32, reg_off += 0x04)
+		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
+				       irq_base + irq_off, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
index d488e798bbef..cc851d58f07f 100644
--- a/include/linux/irqchip/irq-davinci-aintc.h
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -14,4 +14,6 @@ struct davinci_aintc_config {
 	u8 *prios;
 };
 
+void davinci_aintc_init(const struct davinci_aintc_config *config);
+
 #endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
