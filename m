Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9024FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:45:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F49C20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UB6AyIiF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pcvIFAkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a31z/nPoIOQfh69z+7a8/uvkTJx8K4AcSfEODimaTNs=; b=UB6AyIiFtMJaEA
	5Lt7yB6MQ7K1YgfIrGrgyJ8LW5xAFYYTrpm/SHGaS54yoiMDfBkjaJaA0HpjvqdfYz0r3nkMTxn7Z
	2dnKXr5btd90DbuBiwOuyhUxUr6mZtpvGPHzbShXuHJg2G9ij6CWywf8sI7zoJNxz9AF3ufg0Surz
	1t1thCRe/rWYcNqNi20eP/CIIWQnHmfefnQQmMzBmBLIVW+hJHH5V3t2QodC37x9j3o8crViD3BD7
	JT2tB+IxrVKIUgKNM3uvhNVGEUgMd5hE3ipryox3f7K17rpwV61b6qDkRkCfoSWRln9vJpQTZl+J6
	hbv6tt23uEx6OAxKZvFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVZL-0005vE-88; Tue, 12 Feb 2019 10:45:39 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTW-0006Tq-69
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:40:14 +0000
Received: by mail-wr1-x443.google.com with SMTP id v16so2058015wrn.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
 b=pcvIFAkbzD6aLfI1zGuv8vmUHhLTIM6okbBOEb/cE2xXmhgJej0a97vmKnWgPsXNO/
 Z/uQ8rngSoMdD9CJH/dXBIhF/A/PsFuooj1Qp3dKesj0PiGibAmL4bjekuPa7eAPpQIa
 el62fM/Y/+xd3BC7fXdfdb/LZR8k7zAacDbKlNJ/1pMezjGu2ZPvcG9UYHzbHzHmG6I/
 B9q9I/GfljSyN2u4d3pc8ZbPxCn2WcKsQuu07izrtAuC6E4KoTRkjF+O23qXrULJm5tZ
 rLfuekc3kcuqa1ImRD3OKXoSPEjfxyxaXXMgYPxsnAfa/0bb4ykrNvIn4dbxQjZXhwte
 n6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
 b=WP/Jph5sJqdZleD+KSwxlkF0Z/T8lR8aGAEt4rSf7lb+vblGwBqh3xC+nxTG4kUBT6
 mN4pFA7Lxh4tbsHRx6nAwimOpGcZ+3u9UDlFyVAGj/kn1tVRwSs69l8Y0donEhOntKym
 mDJtCmvUYqou1ce/Jk1tor0ggjCLA/aE6f8i/p+csChsuxaeAMUH/iG1fySvQZS+FV1z
 0Mcb/lrgkdiceMKGU94h+kWEMpKVGAzT4gDzBNEZ72bo46lX02RfbRABwKHVRExiEF/v
 Lq8Nw7Xi1XRnLWktDc1d3g4zZ7eI7PZR5r2S57Pu5k5CkZJiJYjh5UmOf40XyNDkl396
 XCuQ==
X-Gm-Message-State: AHQUAub1wYIye8VZ+WGTMn8XcP/3+V7WGF+B0k3i5Ad1TOvOBDDgMgD6
 yHvfwipvB0e9yZsJJpFirfK5BzUZoiQ=
X-Google-Smtp-Source: AHgI3IbOWiDWvI4UHOaOolrfv/BhYR63s/ALtCYeB2CrWQ3jlciMTnzRne5VZGW9zqQ7diEuIsSSXw==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr2319862wrj.0.1549967976928;
 Tue, 12 Feb 2019 02:39:36 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 35/37] ARM: davinci: cp-intc: remove redundant comments
Date: Tue, 12 Feb 2019 11:38:33 +0100
Message-Id: <20190212103835.7768-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023938_583741_F1AE19D8 
X-CRM114-Status: GOOD (  11.60  )
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
