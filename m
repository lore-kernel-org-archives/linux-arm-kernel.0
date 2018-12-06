Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB90C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DAB20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MspQ4xuN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hArDA7Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DAB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c1hwJKrPY7FKnSkn509/zqk5w8u1ya435zjqCf9TCwU=; b=MspQ4xuNCu3jY8
	6+slB/ba94BTbjwB9Xx0MmrYd4CyJQ/ehFMc1a1xEKzkG7JC3ijhBWsJdpVWs1ANzOctvIrCb2+mj
	iQyoKRb3A2F9zecRSIdY9BFr6vr8QJkeYS+/H46bZbXELrpj9LlVM0ZD9vXsFRWqCf3k5PIAWWRJb
	y4Dbv2TTURoFPK1uWcOim/VSk/iYCoZ9uXmnwkvvMJU/RgkImgpsp7n+90aegsjBu5dGOa5LIdf8F
	d6e12VMz9Uuzf+kydzB/uO6b2E5WxHv02Pf5f+Rsjj7tp+zSUSCgMNW0JOoMJfYX30/hTU1r1q4tv
	mTX2B74FRI6HdRsaPBWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUo9U-0006gg-Vs; Thu, 06 Dec 2018 07:32:52 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo8d-0005jI-TF
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:32:05 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so11360198ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/HpNI1L8HsuhwgNUMOu7LqzJncdnpbI+pFBDjt+Ev0s=;
 b=hArDA7Lm4kGvYD1lDfctSAuJsBAoCVyRWdjxivCcrRBeFC9G/Fv+OH7XVQRwxnUJHe
 bRBgvL9Er465ru9Z8rEdtKtSspB5u/0VJivkR3IAsjNHagKvfrFt7s+az3MQPqWxKZ8R
 xs4jQAP2tPx4ciOcIikKXIuBUxgcv0XHUfAn7k18HuEynwESJFx30t9HPmdlIUkUgMCy
 eyiE2rlVEhiqIzzMeqNqruH5izb4Ix3iGw+ZkttCjlCPhObN9f0VSZv2Q6ungWv5/fm5
 ISe47lFiOkGWqRSi2mm3Ro5kNqQvzY6EvKIIF3CCU6kw4Ea3/+GMPx/Cm6x/rLuGSq6Z
 gRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/HpNI1L8HsuhwgNUMOu7LqzJncdnpbI+pFBDjt+Ev0s=;
 b=P6XyGP0QHgQIeMnQnsxS6n3fzXJb9avpUzaUV+ucqkQPbLFdqI9B3n0YzLcbhBeSdg
 Jo56HfFpLIcp1qVz9Wt6kcOZNu6txwqkxlGenjdZk4jxjisMsggvLFuYohar31YyOSgi
 PgqoEPMNOr07/8mkyNgGmFb7NG5kNOGkpjcKGXZYRj4N+CCgTe3kNIu0LCmPA3q/PK46
 +3/uyZ0D2lM7jXB1PBWANoS07pn3QpOXeyBjIS/B5tXV9P2algl8k+UE6zJa0DK4I0OZ
 N9mCE/rQl84pKH/oeQnWOx8pSTlXNP9+XG1yeOEmLQzrcTZoQOKZRjnox+5+KN0/b8ke
 k0Fw==
X-Gm-Message-State: AA+aEWbc67/GbJg8GwFskmQQLfOmNlAfLUxqkgD4HTqfoeh7I5SjXJCk
 XEvGkL2AM3C1KC/9DUbRcIU=
X-Google-Smtp-Source: AFSGD/VV6iq1ZcB9YwCOJUFIv/E1CkQz17qBKM6SEi5ohIOv9yca9tM20C7nSbraLkvDQyUC5i7NDA==
X-Received: by 2002:a17:902:968d:: with SMTP id
 n13mr27800208plp.109.1544081512108; 
 Wed, 05 Dec 2018 23:31:52 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:31:51 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 5/5] irqchip/irq-imx-gpcv2: Add support for i.MX8MQ
Date: Wed,  5 Dec 2018 23:31:25 -0800
Message-Id: <20181206073125.7255-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233200_171797_46CEC69C 
X-CRM114-Status: GOOD (  17.48  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add code needed to support i.MX8MQ.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index c2b2b3128ddd..17a2dad2d4c2 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -17,6 +17,9 @@
 
 #define GPC_IMR1_CORE0		0x30
 #define GPC_IMR1_CORE1		0x40
+#define GPC_IMR1_CORE2		0x1c0
+#define GPC_IMR1_CORE3		0x1d0
+
 
 struct gpcv2_irqchip_data {
 	struct raw_spinlock	rlock;
@@ -192,11 +195,19 @@ static const struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+static const struct of_device_id gpcv2_of_match[] = {
+	{ .compatible = "fsl,imx7d-gpc",  .data = (const void *) 2 },
+	{ .compatible = "fsl,imx8mq-gpc", .data = (const void *) 4 },
+	{ /* END */ }
+};
+
 static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 			       struct device_node *parent)
 {
 	struct irq_domain *parent_domain, *domain;
 	struct gpcv2_irqchip_data *cd;
+	const struct of_device_id *id;
+	unsigned long core_num;
 	int i;
 
 	if (!parent) {
@@ -204,6 +215,14 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		return -ENODEV;
 	}
 
+	id = of_match_node(gpcv2_of_match, node);
+	if (!id) {
+		pr_err("%pOF: unknown compatibility string\n", node);
+		return -ENODEV;
+	}
+
+	core_num = (unsigned long)id->data;
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to get parent domain\n", node);
@@ -236,8 +255,16 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 	/* Initially mask all interrupts */
 	for (i = 0; i < IMR_NUM; i++) {
-		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
-		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
+		void __iomem *reg = cd->gpc_base + i * 4;
+
+		switch (core_num) {
+		case 4:
+			writel_relaxed(~0, reg + GPC_IMR1_CORE2);
+			writel_relaxed(~0, reg + GPC_IMR1_CORE3);
+		case 2:	      /* FALLTHROUGH */
+			writel_relaxed(~0, reg + GPC_IMR1_CORE0);
+			writel_relaxed(~0, reg + GPC_IMR1_CORE1);
+		}
 		cd->wakeup_sources[i] = ~0;
 	}
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
