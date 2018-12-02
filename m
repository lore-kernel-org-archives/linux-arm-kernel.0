Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A863BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BA820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rbZISlpd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8v7t5zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BA820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=us7701/IpwLqy8ZzWcGaoY/gQMA1RseM5iQPWCaenCI=; b=rbZISlpd3lYw4I60xV6vAIpXBK
	O/QtspFz9YnopWrH3bc/tH2V/Hx7BBr2gIEh3qFCiddC2cAQ9rLmBOE++F0syCfSf4GICHRNO59j6
	J63eNzQcD3Or8A2xgZYNYax7SsYdidFKcaf4gKFi93MVSSKO8x2SZyKqX26cYS1NcWoKNV1rE73Av
	cg7WFa09KTll2MJVkuVP1Xw8HEdkmcEghNlXL3eBqGpLTmaYrP9Rs2BE0zNvbnT3u6n4R7+9nQK/5
	9Ln9RkglrEoOHDoaZaVerzEHGqn3oqtXd1e4rISpX1H7jRj1rkBHqxaAbk1kZoYnlrdeWZjpepYo+
	0wMj20Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYJr-0005G5-Ly; Sun, 02 Dec 2018 20:26:23 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYI6-0001xY-F3
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:42 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so3689445wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U5HquPP+e02dVOAMk7E3AUX6XcA/ii1Z/T8jnzUactc=;
 b=L8v7t5zbQqh3/DPYoJLHYE40hz4yqDp09mr0+ytfO+988shSCu9X7GkxbxVX0Fvdec
 IO6VkFhMbltF92r1jmInr2Cd+4dCc6zxZoMBfd1Z3rTzVdhZBI6Zsqu4gsmC2np5D4EQ
 dRBXjcmy0GoWomDyQlSzAZw8Hpu7xx2Nq5Q22UeEH/aJulByTagBEPWI2SKRXPKt0JNA
 UnjiJ8O6fvT+AN4CBEU44l8BiTiNCY8//BAs9eFepowwyfZQka5AfketwwXGcrewxz0j
 MfwYqf+VLOKqmgGZiuNpXIGPJv3gxocJp34ct4FujbpTHvBJvGV1Mv9SfK/xi8xeleLr
 tlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=U5HquPP+e02dVOAMk7E3AUX6XcA/ii1Z/T8jnzUactc=;
 b=RWhrK4hYxgvOEARkELCPgZmzR/IKQPHQ56PpFwehvn7nXDGyzCAn+R21Dp1nCj8UBr
 6oeaiNGFvz6Q41H2S0K9SgAzuliXWCNxXslx0pTaOMJ1bE/2HIKfnfIGueL+rIqvuwsu
 YLQnHEsfl1aR1iUt6e+dzqR2pxH00gToYAsBPPp/VAURd+EgJc+H0HoQAAaXgrVKga/w
 EtzO2gk8PdH62GjO7vl83k4dJJRH80128GL+oGLnVNFD8Eyut31d9RoS2hwyN60eZzsr
 4qcOimeGUFoQMZD3xhmsZCnEchWQuRJavGtC6LxmNp4Lehd1wk7r6dLEXThAgbEPmfmC
 le5g==
X-Gm-Message-State: AA+aEWYy3mUIoNRMXCyFEcMfIbVoC+oX1+K9dYpjOs56EePBw5w/i/+C
 9xrjjdemtDJMKJgJGq1OTLg=
X-Google-Smtp-Source: AFSGD/UFKK2jtp9cBl8PYI9aqb6iLHAmap/42TqW2mdTbBNEWU2kbvckHWh2BcLHDt88Mu+0GCuM6g==
X-Received: by 2002:a1c:c148:: with SMTP id r69mr5870493wmf.147.1543782262710; 
 Sun, 02 Dec 2018 12:24:22 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:22 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 07/17] irqchip/sun4i: Add support for Allwinner ARMv5
 F1C100s
Date: Sun,  2 Dec 2018 23:23:41 +0300
Message-Id: <5fe6eafae0bd8994dcdb5ea6b9255a64e6cdf02c.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122435_123254_5E46A7AE 
X-CRM114-Status: GOOD (  16.00  )
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

This patch adds support for suniv Allwinner ARMv5 F1C100s SoC which has
stripped version of interrupt controller that found in A10/A13.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/irqchip/irq-sun4i.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 507f4e3..fb78d66 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -32,6 +32,8 @@
 #define SUN4I_IRQ_MASK_REG(data, x)	((data)->mask_reg_offset + 0x4 * x)
 #define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
 #define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
 
 struct sun4i_irq_chip_data {
 	void __iomem *irq_base;
@@ -105,15 +107,6 @@ static const struct irq_domain_ops sun4i_irq_ops = {
 static int __init sun4i_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
-		return -ENOMEM;
-	}
-
-	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
-	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
-
 	irq_ic_data->irq_base = of_iomap(node, 0);
 	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
@@ -149,7 +142,41 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic",
+		suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
