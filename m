Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:10:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8D6218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bvo4ylfC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QUeOU85x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w3nTqgmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8D6218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a31z/nPoIOQfh69z+7a8/uvkTJx8K4AcSfEODimaTNs=; b=bvo4ylfC3VgHIV
	25e8Ow4V6QuUnq0yqKtvBZKg9vN+Er9v8YGa9m6h49zaIlIHC5DyvFreWzKfmgWqgsPHuhVVTHjSa
	4G++oupryLpmUrhHyKBhOH6Pg5QGg47OvmEBaRj9BZ0tsNUj1KidmxAPvin5o6Hr3CMJvdojhdkFi
	5I/sU9KCWjagDt5379OtzT7EQJhJXLj49wxBy9hjiEkHcNjc//7q3Vm4ajAQoB1FbZBRZeJL2mOzD
	/QyPRswpM2bmCJA9ZdLVV3brJkKEUqlBOoGi9PpEIHfxZqE61S7SCxvaXTxd97IaWLn2G7YhxwuIU
	7bDvHSytcNR+mrt+epcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIeK-00016q-Ds; Thu, 14 Feb 2019 15:10:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIeH-0000So-GX
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=; b=QUeOU85xqqUyKdDd4xW85Rz6hA
 fp7355rkoPOy0a/lvQ1Z7tn159oi/3GKR4NFIj2zEZfp25/jS0ygj63SfWjeRX0mDgQI76LMg7pi0
 mL9CF1vV0z9y+5DeeFjWqvY40VcvbuANtCIiKSAmCAgDnFOUG7CvP+6rXg29W42BF27VwFGTwfEqz
 meozf8Z9B6vGRi/Zc1amh8B8E+ofaZqdf0hE2CTwYIddu43XtBP905Y70YOAhOqh+PKyrgwOcTCzl
 gQbR87pqbYMM02jgXb9aJNNrzy09Mc3C0LkQ5bqtXYJsQrq5XBKz26COsrNXhgmTCQvwTf+ImOEgf
 XDnsWRgg==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIOD-0007pX-N6
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:27 +0000
Received: by mail-wr1-x443.google.com with SMTP id l5so5705933wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
 b=w3nTqgmdVjXLMVjYsM0ujnlUSdoziCTXEeTKsG1sLi3x3U9fAjBmmJ3fb5ppf/Hf2V
 COf+NPBhV+IchdXWPqXhj4/3/dU5HTX3GcH0bWx1s/c5wGLfxoZx+thegvmB+TWASbiT
 aCwvrKIr4KG6oamd41jYZy1TF8t0g0P+qP0yvmuxaOZPp23j97Nl2DaKCsegTSBBM6+K
 mTwBfsj1EXFaCqk215G36FSmw8KxhIgOwx/1ant2EizrshZvSGnlUR/LRqx020iZq3yq
 ALoG16BPwVpg0nW5zn6lhoVs7+rZ5n4WBxIyH8h1SWTVss9FhZ/SZMvoLPbR7SWESKwT
 9nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
 b=GHr+1FGOCXSPsJBOwdvEYOJWilYWzkdK+FAWpiqP/av5cbSd0kP0OTsKzsJwVoqpvU
 tL3d5LByMZbqScppDoxlzAXkgctullHcxgVztcukQmpj4UcqZStIXWouvDcv4nr76gUQ
 e/xlp617VHZE/S46hxpIeEwkxfbNOtEd/wnk/0KqN08PSoOcJzUVq5cdh2vB6Q4Z1N1v
 Fb5xw+QgTwSoe4FLNEzBH/EXmZjpznMsPaLmUa9aTaISVM8rYaD46zwpYeWbdJl/TwMn
 Bpn9of/Wk/YGYeANVobnA1N3zBK8O+xeOUeFASZj+A36ljtTR8IX/Jm0BX/u6F/OocG/
 OjbQ==
X-Gm-Message-State: AHQUAuZgEwx4HDqf5TwNs7yK5Zc8TZ6ZkV49R2sJ7qYBGrlst2gibNNo
 QBYZcqYVLE2N/lHeGuLbjPL3oQ==
X-Google-Smtp-Source: AHgI3IZ69LEUTwcyKTMiUGEw39TftmUZE/9/jTDns23doIfGX5NHvKq9oO90uRQVPmHfbx9jrhMt4g==
X-Received: by 2002:a05:6000:128f:: with SMTP id
 f15mr3064136wrx.74.1550156004389; 
 Thu, 14 Feb 2019 06:53:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 35/37] ARM: davinci: cp-intc: remove redundant comments
Date: Thu, 14 Feb 2019 15:52:29 +0100
Message-Id: <20190214145231.8750-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_145325_830073_A6A31345 
X-CRM114-Status: GOOD (  11.84  )
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

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index eeb3351016f0..276da2772e7f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -57,7 +57,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -66,7 +65,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -215,7 +213,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 		return irq_base;
 	}
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
