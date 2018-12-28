Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:56:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3D82184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HrjOjUnN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zit6QV3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3D82184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WSe4YXwFeq5dD68PUuDbClx+qhJslcDKO624LEKQ4Fo=; b=HrjOjUnNVW3LJF
	EzNFF+R+e2dd/gowAWrGB0dwgiF60Zte/5WbJpcsMs3k8HUZQdTrbBPa1IkwlZLtvqZdMQ3CnBbZU
	Z6NKGz7dC11Rz6c6hdNkyU77WnxRlkpCyznOmMBgNcomx4M2QXiFRbcAoKFhrtUE+ERUZRgGtnmgw
	xfKNemECcefAPQkPiAzukY8RWJl1FraTxFc8f2LYvDnZneN3PVRD3MN51FcasChVEr8BWbEyd6rpr
	gIFyxIGFT7R0YcxP89QmvVXLuS53Jn5bSlfVZgHZxI3L0ZvpGpSB+s+uvssOG78Ytl7mbAM0CyELx
	wZIdlhLTnYdIVGXX4AXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd07P-00048c-VL; Fri, 28 Dec 2018 21:56:35 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd07N-00047x-0R
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 21:56:34 +0000
Received: by mail-pg1-x543.google.com with SMTP id w6so10511756pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eOnYdI6yMqe6Kolc8LcsRt72W9JKJj6PmETexZzwaCw=;
 b=Zit6QV3qr/AJY79cn2cqXbWUPGDC9eUT3xNjkQXygl3V2+zgXO11ddB+oeS+joq5dr
 kzRatnhEd89aiAiYzNg9mD4QuMLUa6Bg3Yj/u3ELCapNY7xGRE28K+5ocD0oAzfWjyGg
 JdRPyJvm6Ef+qGAcUBkMwLJtjVkj8cDKol52s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eOnYdI6yMqe6Kolc8LcsRt72W9JKJj6PmETexZzwaCw=;
 b=WqszvSBSZI54ot3Jw08JwvuKPmQPIgNGauKRUcTY8e1xfhOelByYDUXNSPG+ZHGl7t
 TpwG3t4H//IG52hj6sNWtClwv+vMPAqogWJgd2Clytv1E7RuRzVKmaz3pc0kA0q1ubNh
 0JRoSmCcb2/RNtjhy0+PcKpD6z0Uh0yU2ha6f+V3Rjflf++wsxFKHZju6j0kYIHoDt2j
 sUO8aspuu60lYwvQ5hXsmhmFQthYRR6DMT5sLkGCcL4ayUhLEesCBudQZgg5+vUk4tlq
 nFOQHyDaASat2b6t2Ub0N2N5zVGBOoI8iUZMvoL2NLoZA+ITjmflq4uX1+GVPJ+yi9W0
 6/1w==
X-Gm-Message-State: AA+aEWYI4RVLC45sB2M4f8dGvJOFGs67zuoqRwhAPWL3WwLNJZZCBTnV
 uvBY4JAXz69mydWFSec+djK8+w==
X-Google-Smtp-Source: ALg8bN6OZVi2smRjTZLHMaRWSuGUF0lGusloYIXMJegHnidSza3sMbUFFnLjDR1UtncS+7MdUAXM/g==
X-Received: by 2002:a62:34c6:: with SMTP id
 b189mr30355957pfa.229.1546034182230; 
 Fri, 28 Dec 2018 13:56:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id f67sm61824491pfc.141.2018.12.28.13.56.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 13:56:21 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: robh@kernel.org
Subject: [PATCH v2] driver core: platform: Add an error message to
 platform_get_irq*()
Date: Fri, 28 Dec 2018 13:56:20 -0800
Message-Id: <20181228215620.120672-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_135633_051585_ADBF24D4 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 javierm@redhat.com, linux-kernel@vger.kernel.org, a.hajda@samsung.com,
 andy.shevchenko@gmail.com, broonie@kernel.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A grep of the kernel shows that many drivers print an error message if
they fail to get the irq they're looking for. Furthermore, those drivers
all decide to print the device name, or not, and the irq they were
requesting, or not, etc. Let's consolidate all these error messages into
the API itself, allowing us to get rid of the error messages in each
driver.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Update error text to indicate irq index instead of IRQn, use %u

 drivers/base/platform.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..e7af7cd63d0b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,23 +79,18 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
 {
+	int ret = -ENXIO;
+
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
-		return -ENXIO;
+		goto error;
 	return dev->archdata.irqs[num];
 #else
 	struct resource *r;
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		int ret;
-
 		ret = of_irq_get(dev->dev.of_node, num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
@@ -104,11 +99,11 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 	if (has_acpi_companion(&dev->dev)) {
 		if (r && r->flags & IORESOURCE_DISABLED) {
-			int ret;
-
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
-			if (ret)
+			if (ret > 0 || ret == -EPROBE_DEFER)
 				return ret;
+			if (ret)
+				goto error;
 		}
 	}
 
@@ -122,13 +117,32 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
-		if (!irqd)
-			return -ENXIO;
+		if (!irqd) {
+			ret = -ENXIO;
+			goto error;
+		}
+
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
 #endif
+error:
+	if (warn)
+		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+
+	return ret;
+}
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	return __platform_get_irq(dev, num, true);
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
@@ -142,7 +156,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr, false)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -195,7 +209,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	dev_err(&dev->dev, "IRQ %s not found\n", name);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
