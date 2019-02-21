Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A51BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCD02084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TCf+vlG1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFbOJfO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCD02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ByXrciwL3JBI30s2iFGj6oarpBCLvORYvGZVkodZK5s=; b=TCf+vlG1eluhIv
	LxR6Gj6QH7vwhCX1xv9pwshtYocpHGdceIYkywnis27FLO6O4mni8t4SoIQ2ppt8BUDOvFJ0ktvhq
	3uFwLd+Uf7eldW+APnSM9Ls/m9X6WwLUokw7dW3MGhIQIp9x9lOv+Q6pnqNSEuS+ne86NAjlV/Jtq
	EkAhoF+RAzWSA/awvYWJAB6jR/YiIQJrEvO/c7r+wt5WGZGLHZXgprRf37gj8l1H8s7IgBMkhQCVC
	avpXNO17tHDcGZumD4+fUXbCZ9YhvVJXYtPTy9FhQluVeHFTD76jfQUqGIhu6d4Y6766zkLDjU9oh
	sokWGfC2fPH/+cjvolmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqZt-0007uF-H2; Thu, 21 Feb 2019 15:48:01 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXk-0005RO-7k
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:13 +0000
Received: by mail-lf1-f68.google.com with SMTP id j1so20698717lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n4i2gWkuhmO+iyl/cag9RpDLmpTF1yZZjxQj5VMEKeQ=;
 b=OFbOJfO5tfQmA0j0aql1xKvXpa89C8q8fKNzngPegkX619gQV9S4oW9newm2fIcyB7
 hvjet+vJCPCCJKj3f0fnEqJvNlaEhas2pZPK9IYXglRyP5iMb+kxcdqHz90mgiBHEJNW
 OeCCCcCJROb9Jr4cke56Lf7wU2vOSNQFH2kQjDvQm/tOclW2bwb3IMR23oIARt4WxZbg
 OV/1/706G0XXLGYiAoptB8IPoogHDciecsW7EKKUlz5a1NzXCmrB9bcceOBqPD2MlXoQ
 uqwWe7uioBv7IU5YXG/SnYUYfLMdwf7xTbHiMoWxel3ajpR4QqmK376EZOXuQFziCqjG
 OZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n4i2gWkuhmO+iyl/cag9RpDLmpTF1yZZjxQj5VMEKeQ=;
 b=rK0V8ZocVNR7ovuXrroS5EpRyYacXGFeOyxJo45kvElVS+QJ6aIKVocpJvdvwTZpAI
 cPWGg9P9yoZMxVFG/6x5chC/ItxovqrjQv0DykwsRnib4yCS20p4EW/U/AYZIs6JwuIH
 LWJjOKGTSjvH8rE+S0278ywMohEYFyBlIun6IuvbFvLVOjkSVw0uwq7ZttVzkeLGK3cy
 Na7G0G23sT/ci90mWMEtaDjRGnVOcGeriu9kB8JRiesZrmX8S4YzgNv6NHnVqEQJI9QS
 e663lxhRlCiyIE6eCO4ZPr5fctScSRI7aw3fO5/9UyFIAvgh7Ug1UpRjKmGBvKFTPbIW
 WSdg==
X-Gm-Message-State: AHQUAubYh0hbKo5DwOCLqnIdWIa2kyO86sbT2eQujcgSPj+z854WmERs
 0XK3bWJerlTYyO9zNGl4jigNfoYz1z4=
X-Google-Smtp-Source: AHgI3IbNFHAAh1c1rq2gsHHl/N/SCJtuQoUpecgoFUGCY8AMjZhVKN/DbLWyYUam6Y+ffn6yl06SSA==
X-Received: by 2002:a19:4f57:: with SMTP id a23mr25331334lfk.46.1550763945094; 
 Thu, 21 Feb 2019 07:45:45 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:44 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 14/30 v2] gpio: ixp4xx: Add OF probing support
Date: Thu, 21 Feb 2019 16:44:42 +0100
Message-Id: <20190221154458.23763-15-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074548_839759_88FFF7CE 
X-CRM114-Status: GOOD (  19.52  )
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
 Linus Walleij <linus.walleij@linaro.org>
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
index eaf317f73f75..4b1cf7ea858d 100644
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
@@ -306,6 +307,7 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct irq_domain *parent;
 	struct resource *res;
 	struct ixp4xx_gpio *g;
@@ -382,11 +384,27 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
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
@@ -404,28 +422,31 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
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
 
@@ -435,9 +456,18 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
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
