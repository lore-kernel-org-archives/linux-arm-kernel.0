Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6DDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:12:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B87D222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AH4MnMWD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j9mYcbjX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AyCU4diG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B87D222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0bR0SWmTKb2IcvZ8sGlbcfcyQM9uXqiCmwB1W3zH9nY=; b=AH4MnMWD1nj7Tb
	jCQI/vyEM5if2DmTwi+Nk0FaeEwfIiQ9T1EcgIizClrDsiTfRcx+xIepvWkYe4KhdTizu+IxHBSu7
	gEszrkX1y03TKm+tq/vEBNbiD0StHX0M3a9YUjzEJ9ptGw0qwjJF2Lf1iXPdbhxop61rfwN3+Qhmx
	8lTL+UtUuJ5JxXV+tiHhUjQdYmakD0gzAs/qo/KdNpm4eJp+Q6OhBn7Y7UWD9MySyNKy31MMc8a3W
	ydQUl1CpK/mRTCm2uvVcB03jyIHRSFzK4s9HjILZPC0zviZ15Cei9MT1XjXVtPLRbIXpwc0bpE1MR
	mONnxgj4sHEfw2oFsUtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIgM-0004ew-6N; Thu, 14 Feb 2019 15:12:10 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIf7-0002yt-NX
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=; b=j9mYcbjXglMzg3deg68yaA8sQ1
 njFmOQY6QwcoQJFoFSkce12iaTS76Ha1Ov3Q/yCD1nEIkYusaE1jpH1kxa92CuPW18b6EiPGDpcdX
 aL7soNAKm4N+UwtyZ6onuX6WIrU7Wg4EmUJgMCz2VO8QM+Jp2Sbfb0PO0g57sT1Q2t9V98GOtL5M1
 u66e9TshtfXpdmQfUbklfgwsU40U1gI9n27M2jDKdIZ6g7xZwBkNv1E5ALjnS//E0TJ7neKGf/JqL
 byC5xJm3jbtWjx0eYnh2o1uuSaGywfJzUHRIR4X36SbMet+SDgzBQyUOceNjht1VxhfAo10rWxxQJ
 VTrXYdig==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINz-00060O-2l
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:11 +0000
Received: by mail-wr1-x441.google.com with SMTP id t18so6823439wrx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
 b=AyCU4diG7pR/uyn1n4EV9kfiX7l0TJT0nnZXHnIR3e2E4RkDTa2Y5dFkRoR/mrw6gk
 GlG478tQxFJO/i3vdfL9o4ZkQuPY6e/R28Hw2J4r1FP7gf8Wb55+lNNf2DFssF7Rjb2y
 U1UH+fFx6PVvbyYrF/cfMISwoxSLZeSjLvWVf0TvzBrEpIXH/Oj0escwhBFCl7NEMAwE
 QQU6Wvm5i7AaLo7XSJbDtA4QB9cnpw+nNHaooDqsDzYm5axLfa/flzXxH6TgvJpsNGX5
 bDK0bvq1mpJPe8Fgxe4PIQ+/uXYrDgVCsMQQX3cE85cwTVyVUlGuoCrJRoJgCdD7bwup
 KTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
 b=ZCUz7b1mRcvqhXBzgcEOam23zclXRNTcSUftPQzA56N+6lYm69GOij8OsEq+jmG6vy
 eYDEyfEq09qIRAfxN4Sq2nnWXHzS02e0Xf6LeQiK49ojqyKlgbaO/UrUx8desuYfXd5Q
 mk0M7lRWVrfOoKLNYGpmKRcjyLl9PfyeQyWt/yR5MbEDQlLM36uSxP22kZKMq8fgMW5h
 TLE4nGxWnL21mb+4MbBihKaRddyoOwK852YhuHz3bVmfwEfLbtjyflQEeLGoh4KbPz4M
 kXpfKSe4fJmCUdT214SJ5oBqvNwdI4p5/1+WuEFyzqwqzQ+pWDiP4LnIwLU1hloFOild
 JP2w==
X-Gm-Message-State: AHQUAubPeky8kNEbv7BH6HyRFeEhrzSHhT6MNPXceixkAdY2CZpWRA7n
 lYarXfffk+fubvP9uv2Wbj21kg==
X-Google-Smtp-Source: AHgI3IbQaWPH5FDilf9+cAnt6bz2PikvmtDzAd0PbFaQ6eQFexmp0Dsw6LjWLiv1vRl5ATwgN4zrMA==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr3121739wrs.318.1550155984808; 
 Thu, 14 Feb 2019 06:53:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 18/37] ARM: davinci: aintc: unify error handling
Date: Thu, 14 Feb 2019 15:52:12 +0100
Message-Id: <20190214145231.8750-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095311_140130_0971668D 
X-CRM114-Status: GOOD (  14.12  )
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

Instead of dumping stack traces, just print a specific error message
in aintc driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 1b2eeddfabd1..2afaf19dc46c 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -91,8 +91,10 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 
 	davinci_aintc_base = ioremap(config->reg.start,
 				     resource_size(&config->reg));
-	if (WARN_ON(!davinci_aintc_base))
+	if (!davinci_aintc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return;
+	}
 
 	/* Clear all interrupt requests */
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
@@ -125,20 +127,28 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (WARN_ON(irq_base < 0))
+	if (irq_base < 0) {
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
 		return;
+	}
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
 						config->num_irqs, irq_base, 0,
 						&irq_domain_simple_ops, NULL);
-	if (WARN_ON(!davinci_aintc_irq_domain))
+	if (!davinci_aintc_irq_domain) {
+		pr_err("%s: unable to create interrupt domain\n", __func__);
 		return;
+	}
 
 	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
 					     "AINTC", handle_edge_irq,
 					     IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
-	if (WARN_ON(ret))
+	if (ret) {
+		pr_err("%s: unable to allocate generic irq chips for domain\n",
+		       __func__);
 		return;
+	}
 
 	for (irq_off = 0, reg_off = 0;
 	     irq_off < config->num_irqs;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
