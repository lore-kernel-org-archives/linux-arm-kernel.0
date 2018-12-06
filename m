Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490352146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qmsz1O7M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmedYPKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490352146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sI02/tVVN5BhlbV/TOsPXhzwBeeiq8tZ0WZW0TExJhw=; b=qmsz1O7MBkM46H
	4O2u+8nMek1zQ5LN30gdMh5UXVt/K9CaHki54+rin36EAyLRVj09aZlU1P3G8yv2a/R5ALhxrm8BH
	lzIQGx2b5R6yXFO3OERmSWETbniA3CY0hTqMElJZ2HBOAg1JBw9GbNqONUW5oNvIV58gW4kSaDctB
	sNfxUv24R+OvY/ud3Z3z6lvyIG2dT4jCgoSuJT07uHslwd4wMCg3QaqjSuZBiVjXA8rrhr4ceSOM6
	xJTTAh51qno7eWIG5zoQy8zfv/NnmCMx0ZbkUi89I56ozh6g80UL5FvQW2AiGgPOWwQ53qFVNl3nL
	cgi0+rVbRHypmIzglJjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoA0-0007E5-Cu; Thu, 06 Dec 2018 07:33:24 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo8d-0005ep-TL
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:32:06 +0000
Received: by mail-pl1-x644.google.com with SMTP id u18so11374107plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nCmWZWkjSO04W3R6eoda+PMgnu8YZorR38g+0MPbFl8=;
 b=RmedYPKuJlzfD3dyoXNGvWBtT6Y4A8ljx+RuFnHVx2mbo8gp9JKeHVq7bOvMhhCTVS
 YBq1QAqWfZhsoDTmJJiteOB2kAgRku+AsinQTt++0ffT692exyA7wTuGyBDaPOFVW/J8
 qUbym03yFY8fQwIOXmug+Ek4WRfW3uh99lOJ0dP3To0RTiFn97l3IA4uL4NGr6hLCdQo
 p9YO6CnZe9M4XHlNoAsY//YexPMXjrYhz2fi+nLmxfn+1bRbzIbZk7riPbDRUmzuMSwY
 yYfS+hYV82VJr+nL00w6RTcIe214GRL1SsD33sZpxEzMNHdwNw8FOFc2P4vXoQ1fsEP5
 Zd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nCmWZWkjSO04W3R6eoda+PMgnu8YZorR38g+0MPbFl8=;
 b=a6k3jO33Hyus7w/BqhyvsTw7H0ZgUo6PtTiWZtvs8KP6XQ9UA3zFkZ15L3RvuEFmso
 DMZYB4k4MTk01cCGqUcntl14k5FEVQBuvzdCldmuHXTUDSOlce7batMInbrxka56SE8i
 jmrgp5poGhmn02tU5f6FyyDCyZOvZv5RSkTzvI3Gg3XpbcseVOp0HEe0GJKWE15d8KbC
 cEHxnei8QL5L7Uku8Ig+Rh13OTMVeTsObRk9kwo05QBJ9t1Yq1xNNYM1uIDLthgkzN6M
 WA+jC6OhgET6/mFjlr/wCvtUvA7eKR5YQcRzr6zF9kNx8AhMRieTgNSBNgxjpgaC3TvL
 093g==
X-Gm-Message-State: AA+aEWZdUH2I5o/s02OUFWWKZwiORAQUVB3dxsKJWZgm2SJn7P1XtRWB
 ow0KNeu5CSsYu0319idz18o=
X-Google-Smtp-Source: AFSGD/WPZiPGuSbiRx1Z/A9FzknRnytfLbknJnMhpsV5bjT90fCq/696T1qgUgdPDqlCKRPkx1CRhA==
X-Received: by 2002:a17:902:f082:: with SMTP id
 go2mr27379293plb.115.1544081508277; 
 Wed, 05 Dec 2018 23:31:48 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:31:47 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 3/5] irqchip/irq-imx-gpcv2: Make use of BIT() macro
Date: Wed,  5 Dec 2018 23:31:23 -0800
Message-Id: <20181206073125.7255-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233200_368161_3B7DD768 
X-CRM114-Status: GOOD (  13.69  )
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

Convert all instances of 1 << x to BIT(x) for consistency with other
kernel code.

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
 drivers/irqchip/irq-imx-gpcv2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b262ba8b2652..077d56b3183a 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -78,7 +78,7 @@ static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 	u32 mask, val;
 
 	raw_spin_lock_irqsave(&cd->rlock, flags);
-	mask = 1 << d->hwirq % 32;
+	mask = BIT(d->hwirq % 32);
 	val = cd->wakeup_sources[idx];
 
 	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
@@ -101,7 +101,7 @@ static void imx_gpcv2_irq_unmask(struct irq_data *d)
 	raw_spin_lock(&cd->rlock);
 	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
-	val &= ~(1 << d->hwirq % 32);
+	val &= ~BIT(d->hwirq % 32);
 	writel_relaxed(val, reg);
 	raw_spin_unlock(&cd->rlock);
 
@@ -117,7 +117,7 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)
 	raw_spin_lock(&cd->rlock);
 	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
-	val |= 1 << (d->hwirq % 32);
+	val |= BIT(d->hwirq % 32);
 	writel_relaxed(val, reg);
 	raw_spin_unlock(&cd->rlock);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
