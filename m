Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257B720881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hoeiLvkI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="isRcx9mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257B720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uTXqAV1zKld2xv4PhmQLJWczg4uhsjwUc5imCuje/gk=; b=hoeiLvkIhgmuQt
	bmRDWMy7TYMCoAE8zX+kesBpUuhdUldx4Cx7VJHsZwajF+T/MBdmE+tzHPJUQwCCckI73H+jUjedW
	k3KKph02dybwdu9MEdLNZHtkSY48fI+43gxOvHgGJ30lC6ueaNjNZCfvIsiA/mlMwpzlbUYTkniZY
	APmkcLWs1MizKhJ2ABmOovMiXr/NQP75rEZd81fufk3808qHWl942jsLdI2XL9RSCKPu4w9u7s2RJ
	bKB0udDYOGjW2r2Um46eoAU5sTuDSMxnnX+HRKiPUDs8S3h/7eYw7HGx3ySLCZIZInhyGyBvvRoKk
	KiWXrrGzqfr3xNqgNXNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCow-0000lm-U4; Thu, 31 Jan 2019 13:55:58 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZW-0004q7-GA
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:24 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so3274124wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IVtjfjJdrfrUAxYWIg2RkYAV3AoagHAUWgDBm80EJqQ=;
 b=isRcx9mW+RI31av6Dcbwmiw+5pBDfRY828eYpRmdcfhI5YbEcusJ7sfAhK8Wy0De1O
 xYgIWwi7+iwOI0Zs5pwhFCys0QSqIHrkl72ohszExQQ3tObbCE76zlremfTzVsl0BB77
 8npAmi5DrDEQuFeqJpuiVU1kgsPb1+aUoMbTJ90y+4m+jVRcSyXxUQGKv8HUp9bJmKfg
 AtelJll4scRpriPZ2Ms14WmPs3fGSojNsXbM7OFL0Hi3uVkfiNJnm5Ut6jPhDzkr41gV
 /8AtFLRaPh8DJoyLSP+HvIxkvSYPF3epPPMlYF9yHWV7Y/0MRQoHRPD0KnLQSp6vwE/X
 oxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IVtjfjJdrfrUAxYWIg2RkYAV3AoagHAUWgDBm80EJqQ=;
 b=RXW9xpQJdvzEbCdZC96CRSDVdyt2IETRuDf+blKtCvkf1Wz6BYXJ+VVkrMomXyG1Mj
 jpqqtPMs7bxSA7tvBCPFWZR2wRRCrXg1FSmkJ6KpvGyEPPyGTQ+MLVyEPV0G0Isk6zSj
 AIfjBmS5qxvsca1DdtJbN0whGn/qGIc+0nk61Mg8XuO5UM64Sk+EZXL265+lTqmVc5dM
 JuuJ3VuOXrsqDYc+PM67VRdw42eyKa9Rvmnxs5vgehzDyhgdxG59bVzSyPmW+89NvcEw
 Cr03ALOfrU/yIjLpW1hT5U7GH9bIhpA5OCFJJ0WK3woClxJkZ7MC4Uu1InHqjN7Lo36a
 FOKw==
X-Gm-Message-State: AJcUukeJf3eR9RtSHNSuiZf1YeLqgUF6qHzU8hb74S3+TgGGQKHkw6sD
 QFZeHq8ENSKdSg5DB+2P6jGl0g==
X-Google-Smtp-Source: ALg8bN4WeQvFMwbH2f3ATmmTso+nUUilBM8hLSwpZJ39/4Z3kMtfSSrLXcZQFheaQ8iXZFn3XoCTuw==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr35273924wrw.123.1548942000881; 
 Thu, 31 Jan 2019 05:40:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 16/35] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
Date: Thu, 31 Jan 2019 14:39:09 +0100
Message-Id: <20190131133928.17985-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054004_031490_3337C2D4 
X-CRM114-Status: GOOD (  14.73  )
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

I've been unable to figure out exactly why, but it seems that the
IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
level irq, not edge like all others.

This timer is used by the dsp on dm64* boards only.

Let's move the handler setup out of the aintc driver where it's lived
since the beginning and into the dm64* SoC-specific files where it
belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 4 ++++
 arch/arm/mach-davinci/dm646x.c | 4 ++++
 arch/arm/mach-davinci/irq.c    | 1 -
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 24ad7a09aa15..beb97101c881 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -14,6 +14,7 @@
 #include <linux/clkdev.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -616,6 +617,9 @@ void __init dm644x_init_time(void)
 	void __iomem *pll1, *psc;
 	struct clk *clk;
 
+	/* Needed by the dsp. */
+	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
 	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index ab02cc93813a..70505c92d5fb 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -599,6 +600,9 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	void __iomem *pll1, *psc;
 	struct clk *clk;
 
+	/* Needed by the dsp. */
+	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
 
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index d67f443a471d..2e114ad83adc 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -142,6 +142,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
 				       irq_base + irq_off, 32);
 
-	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
