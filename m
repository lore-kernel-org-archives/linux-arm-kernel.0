Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF67EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A876A2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUj1eaXp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxsBCFUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A876A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PtoMXSoDa5FUaS0VSyZcRZ5/625nJRGLKaOuLy9TBUs=; b=AUj1eaXpZZBT8N
	+Gb140sOevD9DasWqijt5HKJY7m3yD8pezl1ECjwcSHQ5jCWImBsWZWf3h7yZcF0vLdF0BxWjoAGv
	pRgRrwz8Vw8brl8SUMXvUFXF4lJaLGpIUSUVqG3hQyNnlc6iMUoY5Dh2X+gR3KJPQUgzygv5VNmkD
	zEOOHci3pctz8gEZ81I4dX0089zDCh7kE1t6Pj/rGwkP+wEL33i7gtzw9R+gG18FnWg9XubTV0WmZ
	4AeVaeZCrQyMHxbROMvpD4EEyVqrQloUpkNe4ATjc6Q1fd0gHiYrNrwSBErEEpnxvht8dfKt9kgSy
	8abmA/TDLdg+U1tWZbmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPaM-0004Kf-Py; Sun, 03 Feb 2019 21:45:54 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXQ-0000BK-Dn
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:13 +0000
Received: by mail-lf1-x142.google.com with SMTP id l10so8861540lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dT2LVsKqcyP9BzzXGpTvogZzt88o/YIOQOQXT90IB88=;
 b=TxsBCFUNRA6ExH2FPhSx7sNuLjt6s2PiohUB37Q+ImNIXAwB2L/VG9F5+PIZEwJnnY
 h6CvHKDtucNxJHXVKwi+w8SbJCuVvLPwdXf0SO9ihHyXK9U3fANS6Tqkm3ShWezxc6LZ
 zKN4Q0tlm/9SdfGaHvQ6wWdxNFxjS2Hi3lnII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dT2LVsKqcyP9BzzXGpTvogZzt88o/YIOQOQXT90IB88=;
 b=VD3TyrXPlhPBz5DKCRvOBY0hipnXyUyyh45whGR0hyPPnhWgFoSO2v+yPuLlk6xaM2
 e2NVndmLl3CdoqyxYWzre0NZ1RKYMPY2OaJVzpWgHCKrl2FPwiNJ1wJ7YH7MN7zo1hv7
 ZhjTtqgx6QkrdP9XtZbcW2IsNNXRBwg75rPCmkk/sS3xmqlKS09XOdOL8/z6Q3+KLiNd
 IaNIOT7LpXhmyJ+/nnJGXWJqh7XqwvCD/m+UDAKK997e2LDojIo3bIYrEHPRf9+JSZIY
 vQhsqBQ/ZysTN/PlTn+FS7IPS+ePxgM9kwe5SPDQzGkiVig6Ht7szZtyutEJpjsKAa2j
 tD9Q==
X-Gm-Message-State: AHQUAub1KkLHIrE9Vsn7AJU4FaoJyBwhb9WrJhw/pb5aeys8IwLzcg4t
 sWtTmWiZTiXDgFlLWRY6uJbhtzrnalY=
X-Google-Smtp-Source: AHgI3Ibc0OsRxur9hiCMlpjQHNIbuD56n2QB1cN5+ZMgVtoRSUzQWxVuFl7elSqWdYW4uWaU5qrn1g==
X-Received: by 2002:a19:f705:: with SMTP id z5mr18384474lfe.158.1549230170515; 
 Sun, 03 Feb 2019 13:42:50 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:49 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 14/17 v1] gpio: ixp4xx: Add OF probing support
Date: Sun,  3 Feb 2019 22:42:02 +0100
Message-Id: <20190203214205.13594-15-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134252_848283_68923F33 
X-CRM114-Status: GOOD (  19.69  )
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
Cc: Olof Johansson <olof@lixom.net>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Linus Walleij <linus.walleij@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds device tree probe and registration support for
the IXP4xx GPIO driver.

Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Bartosz: looking for your ACK on this, it'd be good if
the other GPIO maintainer is aligned with my ideas here.
I intend to merge this through the ARM SoC tree.
---
 drivers/gpio/gpio-ixp4xx.c | 84 ++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index 44c24948379d..38a77c8e0c9c 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/bitops.h>
 /* Include that go away with DT transition */
@@ -305,6 +306,7 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct irq_domain *parent;
 	struct resource *res;
 	struct ixp4xx_gpio *g;
@@ -381,11 +383,27 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 	 * from IRQCHIP_DECLARE(), then use of_node_to_fwnode() to get
 	 * the fwnode. For now we need this boardfile style code.
 	 */
-	parent = ixp4xx_get_irq_domain();
-	g->fwnode = irq_domain_alloc_fwnode(g->base);
-	if (!g->fwnode) {
-		dev_err(dev, "no domain base\n");
-		return -ENODEV;
+	if (np) {
+		struct device_node *irq_parent;
+
+		irq_parent = of_irq_find_parent(np);
+		if (!irq_parent) {
+			dev_err(dev, "no IRQ parent node\n");
+			return -ENODEV;
+		}
+		parent = irq_find_host(irq_parent);
+		if (!parent) {
+			dev_err(dev, "no IRQ parent domain\n");
+			return -ENODEV;
+		}
+		g->fwnode = of_node_to_fwnode(np);
+	} else {
+		parent = ixp4xx_get_irq_domain();
+		g->fwnode = irq_domain_alloc_fwnode(g->base);
+		if (!g->fwnode) {
+			dev_err(dev, "no domain base\n");
+			return -ENODEV;
+		}
 	}
 	g->domain = irq_domain_create_hierarchy(parent,
 						IRQ_DOMAIN_FLAG_HIERARCHY,
@@ -403,28 +421,31 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 	 * After adding OF support, this is no longer needed: irqs
 	 * will be allocated for the respective fwnodes.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ixp4xx_gpiomap); i++) {
-		const struct ixp4xx_gpio_map *map = &ixp4xx_gpiomap[i];
-		struct irq_fwspec fwspec;
-
-		fwspec.fwnode = g->fwnode;
-		/* This is the hwirq for the GPIO line side of things */
-		fwspec.param[0] = map->gpio_offset;
-		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
-		fwspec.param_count = 2;
-		ret = __irq_domain_alloc_irqs(g->domain,
-					      -1, /* just pick something */
-					      1,
-					      NUMA_NO_NODE,
-					      &fwspec,
-					      false,
-					      NULL);
-		if (ret < 0) {
-			irq_domain_free_fwnode(g->fwnode);
-			dev_err(dev,
-				"can not allocate irq for GPIO line %d parent hwirq %d in hierarchy domain: %d\n",
-				map->gpio_offset, map->parent_hwirq, ret);
-			return ret;
+	if (!np) {
+		for (i = 0; i < ARRAY_SIZE(ixp4xx_gpiomap); i++) {
+			const struct ixp4xx_gpio_map *map = &ixp4xx_gpiomap[i];
+			struct irq_fwspec fwspec;
+
+			fwspec.fwnode = g->fwnode;
+			/* This is the hwirq for the GPIO line side of things */
+			fwspec.param[0] = map->gpio_offset;
+			fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+			fwspec.param_count = 2;
+			ret = __irq_domain_alloc_irqs(g->domain,
+						      -1, /* just pick something */
+						      1,
+						      NUMA_NO_NODE,
+						      &fwspec,
+						      false,
+						      NULL);
+			if (ret < 0) {
+				irq_domain_free_fwnode(g->fwnode);
+				dev_err(dev,
+					"can not allocate irq for GPIO line %d parent hwirq %d in hierarchy domain: %d\n",
+					map->gpio_offset, map->parent_hwirq,
+					ret);
+				return ret;
+			}
 		}
 	}
 
@@ -434,9 +455,18 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ixp4xx_gpio_of_match[] = {
+	{
+		.compatible = "intel,ixp4xx-gpio",
+	},
+	{},
+};
+
+
 static struct platform_driver ixp4xx_gpio_driver = {
 	.driver = {
 		.name		= "ixp4xx-gpio",
+		.of_match_table = of_match_ptr(ixp4xx_gpio_of_match),
 	},
 	.probe = ixp4xx_gpio_probe,
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
