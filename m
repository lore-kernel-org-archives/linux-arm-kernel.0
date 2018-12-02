Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA4F20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c3YMcs1i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip7YB2KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA4F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bVPdMgONU1+5VtnPRJlqPqqOB1tnPFsGl2Nct/Ry6EE=; b=c3YMcs1ihMvcYDUJjLyMHdQZ1v
	yPyJubgW6oVU638tdGchxyOeqPJr2CM+e3VPnBDkgQVKrjdDaydppn9XZ4kw4UbLJtm8OfItpwG+P
	Jb34dkL7ayXjs0iWjYOzpZvRCsW0epSrspFOKC8ndgSNHAba2st3hoPDXKnVtSddOFgdj4CE8mHF/
	8btf+D41bn9RCj4ihnLTPa1CjN6A0E/Lh7SrWFiBGV6KJfR13/3GUWzAoseWMjuHBcuTGC49UpcXO
	L6go7RNcKIiGTshOt6aYjLUdMSvhjZB73pPd1vEXBT8aBhhHnn/c+4UTW9wvDLXNQ5KwUWnfXN5Ya
	WIHWkJYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYJU-0004nm-15; Sun, 02 Dec 2018 20:26:00 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHz-0001xC-FX
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:36 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so10029909wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6Tg/Nlf4DVosGXWUAPR1HKg7aUMJ7+jsissUOrruo7A=;
 b=ip7YB2KP/uFzP4hjDqvDTMMAqKjIV2+DA8xEXmeRnJLu9l8IFwiYOXK7vgwn5gFwtv
 YKWVzlWU+lu9LCEjGsHISnjUiAeOT3T101u+myvtj8x53lyXxizmHRcbagnntyIK0YAo
 qBGVOZMZC2MdsI5XAB9f5CrsJ2qCrWV18AFhkB2TnWSHxzoke2W/YkAi3BVU1NBUMTzQ
 +B5yQPQOozGmdE3hf6geB/zIWNF0LTZd0lwOTaD8O6NQlP7ux9jdHBhg/9BSiqZ+PMLK
 B8SMUL/ZjfAsg5eF2w15B1QgXCwpB5JAb2I0+cjtGHxa5Sno85koz5Sjz10Emt6Tqur2
 52QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6Tg/Nlf4DVosGXWUAPR1HKg7aUMJ7+jsissUOrruo7A=;
 b=AUbpT6U+AZgjjdVjfHapYi4/cdmRiBsaeq9o8QCwaKUxanZ9eYmYd6S+ajyiPS0dTj
 BwdJEVY9JH8Kd7a51b80KrDAhiprUTaSueW69JPnMisYGmog+sv31fTMfCyruiDQtQOv
 QTRkFGRSlct9UBdPmntQVU1H4Y+kd2Y4PGdU62w3IvkCrQ+lbEi4gvW0UwYXe8kx3vHG
 vCNGDwtf/anfLmOi/oWIj5P6BML+SyhhR6bn7COA4/mtBLPwYNWOmCQABCHTK+mb9bkM
 X6eMAFbbxB4tAFmHi8qpc1ul3uhMWwJ03Ix2i07xLxRtBnj6jVoInFtkcPqNxDPmQxrQ
 SOGg==
X-Gm-Message-State: AA+aEWZwAbo6W3zdeMd3r6omOkQ1u6HpCAzcVKjR/9Cbfq8b1ZKBZJLN
 nAbTMUmY0C3/5iWIYRuz/38=
X-Google-Smtp-Source: AFSGD/UYA/ZwoZ4cE+mkzHvdE0aO2dQwEm7fduDyEzyRE4V5YN4GOBJWtdIx5rtePcpxa8cIJ1sDZg==
X-Received: by 2002:adf:b102:: with SMTP id l2mr11224233wra.296.1543782260969; 
 Sun, 02 Dec 2018 12:24:20 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:20 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 06/17] irqchip/sun4i: Move IC specific register offsets to
 struct
Date: Sun,  2 Dec 2018 23:23:40 +0300
Message-Id: <f1dd4d8331163271cbb4742b33004282678b6ffc.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122427_552320_35095A38 
X-CRM114-Status: GOOD (  15.65  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch moves IC specific register offsets to sun4i_irq_chip_data
struct in order to support different chips.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/irqchip/irq-sun4i.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 0c32506..507f4e3 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -28,12 +28,16 @@
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG(data, x)	((data)->enable_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(data, x)	((data)->mask_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
 
 struct sun4i_irq_chip_data {
 	void __iomem *irq_base;
 	struct irq_domain *irq_domain;
+	u32 enable_reg_offset;
+	u32 mask_reg_offset;
 };
 
 static struct sun4i_irq_chip_data *irq_ic_data;
@@ -57,9 +61,10 @@ static void sun4i_irq_mask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base +
+			SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 	writel(val & ~(1 << irq_off),
-	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 }
 
 static void sun4i_irq_unmask(struct irq_data *irqd)
@@ -69,9 +74,10 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base +
+			SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 	writel(val | (1 << irq_off),
-	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 }
 
 static struct irq_chip sun4i_irq_chip = {
@@ -105,20 +111,23 @@ static int __init sun4i_of_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
 	irq_ic_data->irq_base = of_iomap(node, 0);
 	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
 			node);
 
 	/* Disable all interrupts */
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(0));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(1));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 2));
 
 	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(0));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(1));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 2));
 
 	/* Clear all the pending interrupts */
 	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
