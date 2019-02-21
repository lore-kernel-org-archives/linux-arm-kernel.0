Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67016C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D7C2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ElvKrbCr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3AxkbmR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaNGjlTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t9GhCzn/vWKN8pRTZ2bV06Jm5fY+YIBrT99jzOYq4vI=; b=ElvKrbCrTXH8Tg
	3fTIXjjH2Sr8KXpvDik7UUG27/k1I/S+8pqwLht0cnErmb4fLndETqhxj0KPw4NJaNaaTA4p8leIX
	2MKzrIDDdhJcNWTHMF0z9KOJcQnvizKq0zaBcZAsdyfCpZL9HT4acPPRFCODoyYjwPSIpcdqaZjkR
	2kPy5bOngG8OCpesX7xiIPrx+IPJxYi+edX7DQ3k19HFN8hLQHasQCDeFqFZYm9FnMKsdD9G9sO5u
	vcfwWJovsI7nkBQseIdPDznAe3vBXTY62mMEAS7wPYKRmU81sVVQg17Zl8mOMNXgXXF8gZt2AC1XL
	DiqTFPjSw/1E41KasfUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqwG-0005zk-Da; Thu, 21 Feb 2019 16:11:08 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqvv-0005aI-0o
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OxN6fmUBC5lmGuFwAi3SDeqR+0s2c70kF7erNQAujHE=; b=G3AxkbmRDbtHholEIeEAsPQXSS
 hbGepriDUFwrU1H9uKBtq+WifZphv/EkYAYzdor2RD9LmtsCV4EPogM64A328Ve8yqOu/snUj4OJF
 mrFtwITWe3s0LlSSTM/qBBgTLp9Ag/mda7/JllDz8wUqv32wolGOfN9O11A6wNZaPNZ9kdPe5CLNw
 EWfQE3y9/vy3hQv4WM2kxD78uelb4EWfifM/INDzeRc0CN9o+KkK63X/p6sN+SMDbHBmuFCcmWgO/
 zGxSvTxjuOl1BWbB3WKIyvnvGhfly2wTi0q2lrzLlEozirfbz4jU181C2TqudB6sHLVYC6+slexlf
 X+gkiwIg==;
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXy-0002AV-3B
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:02 +0000
Received: by mail-lf1-x143.google.com with SMTP id u21so20751996lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OxN6fmUBC5lmGuFwAi3SDeqR+0s2c70kF7erNQAujHE=;
 b=WaNGjlTC+qp+ctPTuKkbUZKJanv+8fA/ci1UtcdSmntCn33SBn8PinDKqPp6SC/E2h
 ty94TCT3bYD0VSAtPCU+7AlM7vCF9et/75yuz/6/Q5omkBA6LO/BqIbI0I1QFRNaRKvI
 q7GRbUDhjeFC4HWfn/XDNmKIptWa+LPLs/uyGIqzewlJVltFtPkrfJbkARAn2pnjduQo
 TY0q3SEmws6fpOaXzcEbbvCRxYDiEBKPVyZmvT4oiLkMbqoQ/zH+CrhVDQxBAABNwlTQ
 WB3c1LrDdxtBqUBMw2INlC4wEngcFGbCbDi4Cx0bsDj9e+D5Sv9XR/0DxrKjIn/mVL8y
 /ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OxN6fmUBC5lmGuFwAi3SDeqR+0s2c70kF7erNQAujHE=;
 b=IS3NhmZloiVXhK/Qqx2APC3+BEsXv40SmML5gZHr11QhGWwWUHAxRIOJjVfdbUmvfM
 vJatrbUtaUPEtWTR73tGwGWh/VCdmw+08hoPVb7CtZyXGbRAScNs+QvTe9//IE3NoANs
 egE86+CQbQ3hjgB0KdnYvr7hCEl8mi9keJgL/A0eANPaxToJyaMs7EJh3xWiiD9vld8g
 X3uKorzoKfDoGAr9D2n3l3ALesd/tV3lCXPEfyOz+B/3b91FMdN1sbvnLqjikfYuLGMr
 omiWqxEqroKh40THkRJAMKXhxxWdtjgc1yOEbuP6a+DOENs8NLymLCijaQu8waDk8yww
 MMPA==
X-Gm-Message-State: AHQUAuZO9KhfzhjV2n3Jvs62Gl6WX/aZsPlFGNr+Zpfk8G7561D3BP3C
 UbimK09pNC9gaIN/vNXJpaYW2BL7oNU=
X-Google-Smtp-Source: AHgI3IbheL7YPziRmou+MgfIYqQ6Tko0R+oqvmL2VFzluurww+/Z1DbBo0JT5vO3XPO6/5n0ykY8Pw==
X-Received: by 2002:a19:4851:: with SMTP id v78mr23809322lfa.98.1550763959322; 
 Thu, 21 Feb 2019 07:45:59 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:58 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 20/30 v2] ARM: ixp4xx: Turn the NPE into a platform device
Date: Thu, 21 Feb 2019 16:44:48 +0100
Message-Id: <20190221154458.23763-21-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_104602_200061_EECF620F 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Instead of registering everything related to the NPE
unconditionally in the module_init() call (which will
never work with multiplatform) create a platform device
and probe the NPE like any other device.

Put the device first in the list of devices added for
the platform so it is there when the dependent network
and crypto drivers probe later on.

This probe() path will not be taken unconditionally on
device tree boots, so remove the DT guard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c   |  6 ++++++
 drivers/soc/ixp4xx/ixp4xx-npe.c | 23 +++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index fc4c9b21ca96..e7789d06c39b 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -150,7 +150,13 @@ static struct platform_device ixp4xx_udc_device = {
 	},
 };
 
+static struct platform_device ixp4xx_npe_device = {
+	.name           = "ixp4xx-npe",
+	.id             = -1,
+};
+
 static struct platform_device *ixp4xx_devices[] __initdata = {
+	&ixp4xx_npe_device,
 	&ixp4xx_gpio_device,
 	&ixp4xx_udc_device,
 };
diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index 1f6e01369d54..e3294457b5de 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/soc/ixp4xx/npe.h>
 
 #define DEBUG_MSG			0
@@ -683,16 +684,10 @@ void npe_release(struct npe *npe)
 	module_put(THIS_MODULE);
 }
 
-
-static int __init npe_init_module(void)
+static int ixp4xx_npe_probe(struct platform_device *pdev)
 {
-
 	int i, found = 0;
 
-	/* This driver does not work with device tree */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
 	for (i = 0; i < NPE_COUNT; i++) {
 		struct npe *npe = &npe_tab[i];
 		if (!(ixp4xx_read_feature_bits() &
@@ -717,7 +712,7 @@ static int __init npe_init_module(void)
 	return 0;
 }
 
-static void __exit npe_cleanup_module(void)
+static int ixp4xx_npe_remove(struct platform_device *pdev)
 {
 	int i;
 
@@ -726,10 +721,18 @@ static void __exit npe_cleanup_module(void)
 			npe_reset(&npe_tab[i]);
 			release_resource(npe_tab[i].mem_res);
 		}
+
+	return 0;
 }
 
-module_init(npe_init_module);
-module_exit(npe_cleanup_module);
+static struct platform_driver ixp4xx_npe_driver = {
+	.driver = {
+		.name           = "ixp4xx-npe",
+	},
+	.probe = ixp4xx_npe_probe,
+	.remove = ixp4xx_npe_remove,
+};
+module_platform_driver(ixp4xx_npe_driver);
 
 MODULE_AUTHOR("Krzysztof Halasa");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
