Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BB4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:44:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A142085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejhwCk2M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EiDA7RsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A142085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=55640GKZ93E1NELZh/w96GF+yOmqBnu9nbEM3y1UlyI=; b=ejhwCk2MFFRa1B
	1BM/nZ2gQGi/e1Gr3BiX0DbRUEAxVxyjS/A5oDH2LmzV4eWkXBzbQw7/eRgHL/b5ikqIFmg6GD1OP
	DMGIamJNYYwDWTFZ7qC07VFUU2+yD2Y6Sbugfe1e6tvfmRW9exQ0fWnEAnfU7TiM/fMvP8512fcSR
	Nz9TgEbd1HXUYukr1Ho5dBrqrLw8ZVv34lp0c19pKyuiwn4zLhIQaeZeDyYDXZEhSXymPbb5nTifl
	3Fe3r86X1vUhhgCowdoDIQgPPg3teJ1+tDv2kYzWWB9RSeFPXjmHG4OBuqFUdBm8FsfF6EQHAVxNV
	YV1KY146sRvPGc1b1uOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCdn-0001go-Tc; Thu, 31 Jan 2019 13:44:27 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZh-0005LW-49
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:29 +0000
Received: by mail-wr1-x444.google.com with SMTP id t6so3282147wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ys1Qmvh0LDODbKSEj2pf4iStmeI+PYiuCBLDhUYc/3E=;
 b=EiDA7RsYM7Hf3oBcp7uXOdxan633bxYkrbCqhbu4nq7hNTpYXt+nKDVVqFR5a7h1eE
 LzLWOM3sESUpBhUi5Yo02jZjDNkI31IqIhS8q64YSf8ltbuBH8J5Kk3m42EMF225A1YB
 Q66PXs9l7YAI7CJ8j0YTId3K0mdMVDoDLz70/yA83WijPNYREadQ0vhynnkExEQE4T1A
 WDHkC1fd1L4540TwwWWaBgsVaO+mhovznoaaAoJ1e9M7MikeEe6AOxU4QW0hWC6ETYpZ
 BGmtBs45RfLpeoY8cDKO/dulaYSPo6Y+srdWldI/83ZcTuRNdzSbQrnjKlWaMgSSh8ac
 4fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ys1Qmvh0LDODbKSEj2pf4iStmeI+PYiuCBLDhUYc/3E=;
 b=dAg8jQTzH9KEoG75ApuzHaM9nkbpzfnMMm8k2FBDq0kTI2z59aalpMq7kZR+93JR9U
 T3p0iqNVE2WORVbFPUiZMpZO5dVWuvPCJevF5ndr+ySfMk+xge212tdIUB9VH7fv72i+
 xIf5ku7bGvGH9meV9O+oFNLlrfe1KaynsTJNE9oMssnuN/3pahw72xIFoFS9X+yympIZ
 30bOSXIBToD3he+Xsjq8GEQpomfhPf1Uhosz97U4GUg7hHVMANzlM+zMkvtov4ZKykVT
 hfxv+O1Mpkaq9gV95NDp3TAegZvcua6qzCA9sm5i9OVLljuijrlegztAzSc9UePhSdFs
 eQDg==
X-Gm-Message-State: AJcUukfjMb64WKtRY+2wx2+A7E0mkDGuZhPJFLywSSdGA2aIDYEYW0AV
 49q7UJQsDljAGJJDHYWcT6mQNA==
X-Google-Smtp-Source: ALg8bN7cNp94ZetUb/cEUh1dkubZybHAloO89Ni1u6WTftgTo+9FzEhr12LRDMiZiwm36/b/q8G8OQ==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr35314651wrn.276.1548942011290; 
 Thu, 31 Jan 2019 05:40:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 25/35] ARM: davinci: cp-intc: use the new-style config
 structure
Date: Thu, 31 Jan 2019 14:39:18 +0100
Message-Id: <20190131133928.17985-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054013_880337_78AE951A 
X-CRM114-Status: GOOD (  21.75  )
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

Modify the cp-intc driver to take all its configuration from the new
config structure. Stop referencing davinci_soc_info in any way.
Move the declaration for davinci_cp_intc_init() to
irq-davinci-cp-intc.h and make it take the new config structure as
parameter. Convert all users to the new version.

Also: since the two da8xx SoCs default all irq priorities to 7, just
drop the priority configuration at all and hardcode the channels to 7.

It will simplify the driver code and make our lives easier when it
comes to device-tree support.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 92 +++++++++------------
 arch/arm/mach-davinci/da830.c               |  2 +-
 arch/arm/mach-davinci/da850.c               |  2 +-
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 include/linux/irqchip/irq-davinci-cp-intc.h |  2 +
 5 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 1f55d68672db..2ce0b7653c88 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -144,22 +145,15 @@ static const struct irq_domain_ops davinci_cp_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static int __init davinci_cp_intc_of_init(struct device_node *node,
-					  struct device_node *parent)
+static int __init
+davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
+			struct device_node *node)
 {
-	u32 num_irq		= davinci_soc_info.intc_irq_num;
-	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	unsigned num_reg	= BITS_TO_LONGS(num_irq);
-	int i, irq_base;
-
-	if (node) {
-		davinci_cp_intc_base = of_iomap(node, 0);
-		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
-			pr_warn("unable to get intc-size, default to %d\n",
-				num_irq);
-	} else {
-		davinci_cp_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
-	}
+	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
+	int offset, irq_base;
+
+	davinci_cp_intc_base = ioremap(config->reg.start,
+				       resource_size(&config->reg));
 	if (WARN_ON(!davinci_cp_intc_base))
 		return -EINVAL;
 
@@ -169,51 +163,29 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_ENABLE(0));
 
 	/* Disable system interrupts */
-	for (i = 0; i < num_reg; i++)
-		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_ENABLE_CLR(i));
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(~0,
+			DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
 
 	/* Set to normal mode, no nesting, no priority hold */
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_CTRL);
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_CTRL);
 
 	/* Clear system interrupt status */
-	for (i = 0; i < num_reg; i++)
-		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_STAT_CLR(i));
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(~0,
+			DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
 
 	/* Enable nIRQ (what about nFIQ?) */
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 
-	/*
-	 * Priority is determined by host channel: lower channel number has
-	 * higher priority i.e. channel 0 has highest priority and channel 31
-	 * had the lowest priority.
-	 */
-	num_reg = (num_irq + 3) >> 2;	/* 4 channels per register */
-	if (irq_prio) {
-		unsigned j, k;
-		u32 val;
-
-		for (k = i = 0; i < num_reg; i++) {
-			for (val = j = 0; j < 4; j++, k++) {
-				val >>= 8;
-				if (k < num_irq)
-					val |= irq_prio[k] << 24;
-			}
-
-			davinci_cp_intc_write(val, DAVINCI_CP_INTC_CHAN_MAP(i));
-		}
-	} else	{
-		/*
-		 * Default everything to channel 15 if priority not specified.
-		 * Note that channel 0-1 are mapped to nFIQ and channels 2-31
-		 * are mapped to nIRQ.
-		 */
-		for (i = 0; i < num_reg; i++)
-			davinci_cp_intc_write(0x0f0f0f0f,
-					      DAVINCI_CP_INTC_CHAN_MAP(i));
-	}
+	/* Default all priorities to channel 7. */
+	num_regs = (config->num_irqs + 3) >> 2;	/* 4 channels per register */
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(0x07070707,
+			DAVINCI_CP_INTC_CHAN_MAP(offset));
 
-	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
+	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
 		irq_base = 0;
@@ -221,7 +193,7 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 
 	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
-					node, num_irq, irq_base, 0,
+					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
@@ -237,9 +209,25 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 	return 0;
 }
 
-void __init davinci_cp_intc_init(void)
+int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
 {
-	davinci_cp_intc_of_init(NULL, NULL);
+	return davinci_cp_intc_do_init(config, NULL);
 }
 
+static int __init davinci_cp_intc_of_init(struct device_node *node,
+					  struct device_node *parent)
+{
+	struct davinci_cp_intc_config config = { };
+	int rv;
+
+	rv = of_address_to_resource(node, 0, &config.reg);
+	if (WARN_ON(rv))
+		return rv;
+
+	rv = of_property_read_u32(node, "ti,intc-size", &config.num_irqs);
+	if (WARN_ON(rv))
+		return rv;
+
+	return davinci_cp_intc_do_init(&config, node);
+}
 IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 565c306e5252..bdbd66ffd2ea 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -754,7 +754,7 @@ static const struct davinci_cp_intc_config da830_cp_intc_config = {
 
 void __init da830_init_irqs(void)
 {
-	davinci_cp_intc_init();
+	davinci_cp_intc_init(&da830_cp_intc_config);
 }
 
 void __init da830_init_time(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 794ddbe78534..fe370e85aeb1 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -683,7 +683,7 @@ static const struct davinci_cp_intc_config da850_cp_intc_config = {
 
 void __init da850_init_irqs(void)
 {
-	davinci_cp_intc_init();
+	davinci_cp_intc_init(&da850_cp_intc_config);
 }
 
 void __init da850_init_time(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 0a6607ea4560..9e06974c85bb 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 #include <linux/reboot.h>
 
-void davinci_cp_intc_init(void);
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
index 9b0c7d6189eb..596145c2f3d1 100644
--- a/include/linux/irqchip/irq-davinci-cp-intc.h
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -13,4 +13,6 @@ struct davinci_cp_intc_config {
 	unsigned int num_irqs;
 };
 
+int davinci_cp_intc_init(const struct davinci_cp_intc_config *config);
+
 #endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
