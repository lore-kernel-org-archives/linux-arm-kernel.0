Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3BA20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZTTMOxs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inY4dKgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3BA20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mK8EY0lCiMOTK2ET3IAx4oLHa+oFfc9ONjAAcSZmU2Y=; b=DZTTMOxseHGrIr
	zg6uiUnokxWLX9Hdj9agq+iB6fx8uB8HQ7XK5thoIl5CzZoYdeFtwcUqIlwYId76+OXZw3Fci8SuP
	QIKd7FSxcwYTw4Rz4m2KfchxQYW+ioCPqcr8ShNRg6vVA8BT/fhT8zdN/aIeMD+yYvl9EGB8FyP7T
	ycbSvtQGM5qTVwRt1ZaE9YRx/J2wYN9d4P2bS4P0mVtWmou3rmf38SXsBoZ0FaxlZ1+7uNm3Uqjci
	ogf1dmpLCZKe2WtXspX/rSBg41w8qGXEeHcgcV3NvbuHAm1g1w0bRHj1q7uOxBXiR/QDyiW9RiGJb
	AAKRkbh78AQ+I9vUPVPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqZB-000716-VN; Thu, 21 Feb 2019 15:47:17 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXY-0005BX-Rm
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:54 +0000
Received: by mail-lj1-x244.google.com with SMTP id j13-v6so24437386ljc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QeAjnzLoPiZyS27+mrcrChGYl9RVcTYFeb5TD/4DxtA=;
 b=inY4dKgdAd6jiYm9qDKqL9+pxB5Nt6vS4MA/vDMS4VBh5guqAdCTqwwsmX8jLwP50K
 PEangOdp7JYsFRqqXasV0fn1t45YRQcvirlFRTriAlEwS2Qz9tN6Qa4xi5rhqy9WVzEe
 tTH4xulwh9xTDGCOX7nQVGTlcZh4l2QcCwkO9yyj+YxRApHF9ldgWF0h9Y7FO6SiQeWq
 VMFdZfxe5fKwJswjN7za8VUjQkph7Hkg0kYDOEpHAHSOq6VSY0pTFr13Q0lMrXDMVVuE
 MuPIti9U//qdAo9qO0KEFnGGtlP548lzZbMWCya9lMOM2kX2gHDJQ0u5Cky1c7Matn2f
 OgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QeAjnzLoPiZyS27+mrcrChGYl9RVcTYFeb5TD/4DxtA=;
 b=ay+4Qs3pi+BQPfTxleWqT1LckVhbY9LtFr4n6BMbx/mw+gqrbzFjWLGWgIrlHNX+6c
 xbjFmS9dZdEiC7JZZIbzwPvHjsdvcV2EHGlned7GzeAeejWrToRm1aN/pU0KUXTZOZN2
 VD1uBqirm4QSKV52qYFoVVL8AvMxqlo1ISXYaUCVPaOva6T3LjrZ5/rdB2RUiN+jZnvj
 SP8nYLiSdawCaz/0jlVDMsupfw4ebkqAIpS0pTjFmIqDKvCXiMOPZ4DH88Fk2FXkAfZn
 mV3P+/zCX96XmjwPgOc3QGJ9fzSeyPY2VIJUnw6+FJ0g/0bHFf14QMxGWdsbMOMWQ81F
 m4lw==
X-Gm-Message-State: AHQUAuYmx7O3Fh7SFpCJr7syptFE7HWWQuW1bg63NR5cqOj1vMuPasrB
 8EmTMZRaNSyAonF7FXicadrV2BC0sgw=
X-Google-Smtp-Source: AHgI3IawLzMVZaqXNr4H3kPnCBnTWQKqique+tY9LshIqcG8i74o0d2U8zoteHZOmvclS3f9vhNUAw==
X-Received: by 2002:a2e:890b:: with SMTP id d11mr5088196lji.174.1550763934656; 
 Thu, 21 Feb 2019 07:45:34 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:33 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 10/30 v2] irqchip: ixp4xx: Add OF initialization support
Date: Thu, 21 Feb 2019 16:44:38 +0100
Message-Id: <20190221154458.23763-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074537_149533_8E9B1A0D 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for probing and settin up the IXP4xx
irqchip from device tree.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
irqchip maintainers: I am requesting an ACK for this once
you're happy with the driver, as I intend to merge all of
this IXP4xx rework through ARM SoC.
---
 drivers/irqchip/irq-ixp4xx.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 89c80ce047a7..1ea7561fddb7 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -15,6 +15,9 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-ixp4xx.h>
 #include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
 
@@ -360,3 +363,45 @@ void __init ixp4xx_irq_init(resource_size_t irqbase,
 	}
 }
 EXPORT_SYMBOL_GPL(ixp4xx_irq_init);
+
+#ifdef CONFIG_OF
+int __init ixp4xx_of_init_irq(struct device_node *np,
+			      struct device_node *parent)
+{
+	struct ixp4xx_irq *ixi = &ixirq;
+	void __iomem *base;
+	struct fwnode_handle *fwnode;
+	bool is_356;
+	int ret;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
+		return -ENODEV;
+	}
+	fwnode = of_node_to_fwnode(np);
+	if (!fwnode) {
+		pr_crit("IXP4XX: no domain handle\n");
+		return -ENODEV;
+	}
+
+	/* These chip variants have 64 interrupts */
+	is_356 = of_device_is_compatible(np, "intel,ixp43x-interrupt") ||
+		of_device_is_compatible(np, "intel,ixp45x-interrupt") ||
+		of_device_is_compatible(np, "intel,ixp46x-interrupt");
+
+	ret = ixp4xx_irq_setup(ixi, base, fwnode, is_356);
+	if (ret)
+		pr_crit("IXP4XX: failed to set up irqchip\n");
+
+	return ret;
+}
+IRQCHIP_DECLARE(ixp42x, "intel,ixp42x-interrupt",
+		ixp4xx_of_init_irq);
+IRQCHIP_DECLARE(ixp43x, "intel,ixp43x-interrupt",
+		ixp4xx_of_init_irq);
+IRQCHIP_DECLARE(ixp45x, "intel,ixp45x-interrupt",
+		ixp4xx_of_init_irq);
+IRQCHIP_DECLARE(ixp46x, "intel,ixp46x-interrupt",
+		ixp4xx_of_init_irq);
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
