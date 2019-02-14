Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357CFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FB72229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pHo6pxRx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BqkA7cFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FB72229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DVfvKMgUQU9kuU7Lyh1oX6wQ1paWrAKAwYzykfV7Ehw=; b=pHo6pxRxmyueTK
	YkpFPa3nUGSmBxh32tFJtU55PEgF1QTVsrVLvHuVu8F4YTSJziZjrDfLmcAzhqElTxQrYu3ABCNLA
	fm5P6blpHhD9HBqgOsfUk/f4Exd6f7jINHTsxZQ8v2mSJo4ZEgu2n9MRGWaG3fMbeeXuy9TfyDlnj
	/NrY/raN9ZGz3ETgoUR/xhkbhDkxeCLkkf9b+msRtndlbEgi+WRut26JltnIehq8ST7rQz3pKO0Tw
	vvVa2U5CmqdYQDLZV5yDY8bj7fTGJu06G2kP4pnL421pnLNSAfrnQxEdTpNuJU6oNbhI65+U71f49
	yWMvLRvKh3M9WNsnv4KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIO8-0005X1-Nz; Thu, 14 Feb 2019 14:53:20 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINb-0004lY-D1
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:52:50 +0000
Received: by mail-wr1-x441.google.com with SMTP id l5so5703865wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M5s8LgF6tZAAsjgatoDHdRTjLQOzD7FAKkqTEC3Dngk=;
 b=BqkA7cFgY5eQZK7myk8BKxWfGkvj9AutRjzEtoyt1z8IetYbkItoh3f7UuvdeqD6K1
 sVr784C5j3xCUGprBkB/fQ0iANsaCu/UTxfxE8x8TWP3NYX2PD62Z+IODyAYNYPxK9Dj
 lqyAwEVKi8jJyOm3JY2uQcl2Yw79QGcJ9IV82PLhySB74KpqPhJJGXHIVHMlrL+UTwvq
 PHEPHkDaGcO9TQudMMs+RBi3kqhjnmfV5bKV+YCiyhT7xLu5FPAJHmFZ68eIYBbccpm4
 IRnUQAPN8WH36JIw6g5eFxBS73Q2quU6joKwBAQIsIqv4+n2YLg9dz4S7JgsiR3Dv3lD
 K8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M5s8LgF6tZAAsjgatoDHdRTjLQOzD7FAKkqTEC3Dngk=;
 b=HzvHE8WxsZGbKb13ER71l6dLEo0nhKfEdy2zmeuSXNJDUPiLbI2brf64agrzCtvHJQ
 yAQc358NpeTo8ohgOp8EDDi/RGs0eUrmrxpqaoEkU0RT9/zBXg0QM9smlSBTrGQ3jbE4
 hfqmIYYyfhgMBnI9sYCB3RkmaxSRsp2JbWfDjJI3bVElwOomQYcsKBoLeWe4ZZqMY3xW
 c7ubtN0PyQJ+YhA9MIK+n/oNnFokzKT2GZHbXWLkerJtbj4fAQXqQaNbMC/3IQclFz4l
 /YNRqCC9XY7u1se+hyZ5I2FDWWt9ryLJzx9AbUGKQ/+8HaHCVRDW3rfMNJuwWiNK3+LG
 x6OA==
X-Gm-Message-State: AHQUAuZ5eXJ1p/cXyv8AkGkQj8deK8v0V83iYdM1sTP2OV5gO1bjQsoR
 RQj02h4oHch9h8OI8/xZ1TvThQ==
X-Google-Smtp-Source: AHgI3Ibl8067TtcXcDLRsWxeFZGUOkyzXVfDDfiNstZzj6kRDNEVTg3BvvFO9JxCuRx3meXDC2CJ/Q==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr3265081wrn.45.1550155965831; 
 Thu, 14 Feb 2019 06:52:45 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 03/37] ARM: davinci: aintc: use irq domain
Date: Thu, 14 Feb 2019 15:51:57 +0100
Message-Id: <20190214145231.8750-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065247_692376_8852D7A8 
X-CRM114-Status: GOOD (  14.77  )
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
 arch/arm/mach-davinci/irq.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 952dc126c390..efba6dbdfd62 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/cputype.h>
@@ -40,23 +41,23 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static struct irq_domain *davinci_irq_domain;
+
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
 	__raw_writel(value, davinci_intc_base + offset);
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
@@ -74,6 +75,7 @@ void __init davinci_irq_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	int ret, irq_base;
 
 	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
@@ -110,8 +112,25 @@ void __init davinci_irq_init(void)
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
+	ret = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+					    "AINTC", handle_edge_irq,
+					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
+	if (WARN_ON(ret))
+		return;
+
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_alloc_gc(davinci_intc_base + j, i, 32);
+		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
