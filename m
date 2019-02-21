Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF40C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:03:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92E42084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dR+uHmH3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQF5aotq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvztOVPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92E42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w6nuK6ZGiqSUV8+PzKXijEM8EIgSzJY0E9UbdQXSOaY=; b=dR+uHmH37PsfzA
	cr7NYzLLH/umbviQOm7pv953TnojVCyvrXOj47dj5dKIAx5bPRq1N4tNfM3wmXBg6zZsAQwc3ic98
	+uu9FrJffT/V23oxrvwBkhoHuyW7p/Ru1axyCuxIpcY5ORtRJsUYWKs9IapWu6r0LNWhR06MhkXR+
	ljJ318DZn+aPSS5cVuES4SQ+rGlbRVXWnBcOKGvQ2ShYERBkX4JnD7MpcFyp7Uq2nA9Iahfi/MwtF
	4L494f8dUwqFTkRlGrRMvelHgF7Pl96R13o+MrCp+FON3hG5RsvfRkgVGlT0AMi1ST6bnfn+ghoeK
	v49o9u42loy8IbtR1YSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqoV-0001ci-If; Thu, 21 Feb 2019 16:03:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqnr-0000bs-FK
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=viQosBtHxW3hm4OeJu5mhQ4chI41Fb8tTjJF6BETtcI=; b=nQF5aotqsPAKqt40JUFjyBJ9eT
 awAMMMGd8dLEpoovxoBrxLvkhhwGxN08lPiKv0R1UNpfgTqlLaWINAdtR9uEWAPW1CMFve38S30Cw
 l6IFh5jsuWzqjBIQNr7QogrtqQdxKW7DQTSVCa9nu6uy49LZ6C/jED3vQHayFH3db+QTMCWWyiwCx
 gSkWzgdyhxEc/aGf62GlbglrP60rqOgmrzb4y8YzKWY+1uCIHKW5G/UGnohEgijXyHdN9w6uPKJj1
 FI3qA0mGtWR+vsG40f6pM7TUrxkxbfhFTCHVoSKcjHFi4BjbXBE2oHBOaJLyBolL4YTaPR7Yo7t34
 9Y8Oqa7Q==;
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqY1-0006qf-W5
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:07 +0000
Received: by mail-lj1-x244.google.com with SMTP id d14so13227123ljl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=viQosBtHxW3hm4OeJu5mhQ4chI41Fb8tTjJF6BETtcI=;
 b=uvztOVPXfS3TTpYg3blvdV0FzV4Vcrkm5YPfB89Ox7rybeE4y3pCzeMFttVsKa9PBC
 tkWIOenKFixx67U5+EMVUGamy9t4Q0nsqU6Raz2jyNROYl7knUjkuwtYzWiMaWonndUJ
 MrzYKuDoxlEOW/e5HppAGxcUvEBy469lNn3tQasaQXVIcPLfEBlL75MLAa1FiJq+TEK1
 F2wuuvq4szEErSXzwj1ThrU3R6Fo7UrMuZdbualpTGcGwAhrEnwrkspYsIc60VroMTb5
 xOHVVBWxz+yO2n9H75eUBkGDxmLNZlBH/CoVxN3qV5PYiDN0agFuTUiOE3OqAH0RVzgM
 qMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=viQosBtHxW3hm4OeJu5mhQ4chI41Fb8tTjJF6BETtcI=;
 b=ZMpjftH5CRsLIJBoJLu5oaqOOHuEnIQYoYCTJBr8C6xyUoF+q6mJNF2+67+Jvs2nJe
 NSVOjcH7apswnO3jc+/rkypxdqDs6nWeM19+SnwlQpgYuCr49sTdeBnglG7LXGsOQ81k
 BC6ynZLOjpbUHQt3WqkhLPzeJH637pfzb/X8gsLgSUBCsgWN6sHk/YSD8hX55LP8JaMX
 hJEmx6CrWIp8tUvdwMhbuUSCvn4OjEZ7CIzqUe5wd7gbR5YrA+xQFvj2vXXdgv1pCfG/
 LpGISI6lKqDhEgvgE74DRL8ZXw8MUBYNsmkm2OZGJ0GARB/I07nrPu2RFzOVr0cb2gNR
 loUQ==
X-Gm-Message-State: AHQUAuYnITwFPQCarOiW7rEENVwMaVnFMAV5UuFy5r2tx6hzvrxe9g6k
 WnQld1Jz8QRhXbWm/Pp2t+toR/I9Wa8=
X-Google-Smtp-Source: AHgI3IbYImtozlDehh8z6fpCSPXNrzhrN8+5I7timIwqUvAIqwALEO6LM13dkkZkUnbBr84A7VI/Hw==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr22130680ljg.29.1550763964074; 
 Thu, 21 Feb 2019 07:46:04 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:03 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 22/30 v2] soc: ixp4xx: npe: Pass addresses as resources
Date: Thu, 21 Feb 2019 16:44:50 +0100
Message-Id: <20190221154458.23763-23-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_154606_065971_47BCC206 
X-CRM114-Status: GOOD (  23.30  )
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

Instead of using hardcoded base addresses implicitly
obtained through <linux/io.h>, pass the physical base
for the three NPE blocks as memory resources and remap
these in the driver.

Drop the memory request region business, this will
anyways be done by devm_* remapping functions.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c                 | 21 +++++++++++
 .../mach-ixp4xx/include/mach/ixp4xx-regs.h    |  3 --
 drivers/soc/ixp4xx/ixp4xx-npe.c               | 36 ++++++++++---------
 include/linux/soc/ixp4xx/npe.h                |  2 --
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index cdcd6d6b6d3d..07c3cb312a92 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -150,9 +150,30 @@ static struct platform_device ixp4xx_udc_device = {
 	},
 };
 
+static struct resource ixp4xx_npe_resources[] = {
+	{
+		.start = IXP4XX_NPEA_BASE_PHYS,
+		.end = IXP4XX_NPEA_BASE_PHYS + 0xfff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = IXP4XX_NPEB_BASE_PHYS,
+		.end = IXP4XX_NPEB_BASE_PHYS + 0xfff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = IXP4XX_NPEC_BASE_PHYS,
+		.end = IXP4XX_NPEC_BASE_PHYS + 0xfff,
+		.flags = IORESOURCE_MEM,
+	},
+
+};
+
 static struct platform_device ixp4xx_npe_device = {
 	.name           = "ixp4xx-npe",
 	.id             = -1,
+	.num_resources  = ARRAY_SIZE(ixp4xx_npe_resources),
+	.resource       = ixp4xx_npe_resources,
 };
 
 static struct platform_device ixp4xx_qmgr_device = {
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index 459abe2eb4b5..f5d5b258c3f7 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -132,9 +132,6 @@
 #define IXP4XX_INTC_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x3000)
 #define IXP4XX_GPIO_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x4000)
 #define IXP4XX_TIMER_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x5000)
-#define IXP4XX_NPEA_BASE_VIRT   	(IXP4XX_PERIPHERAL_BASE_VIRT + 0x6000)
-#define IXP4XX_NPEB_BASE_VIRT   	(IXP4XX_PERIPHERAL_BASE_VIRT + 0x7000)
-#define IXP4XX_NPEC_BASE_VIRT   	(IXP4XX_PERIPHERAL_BASE_VIRT + 0x8000)
 #define IXP4XX_EthB_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x9000)
 #define IXP4XX_EthC_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0xA000)
 #define IXP4XX_USB_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0xB000)
diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index e3294457b5de..d2dd916816d4 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -155,16 +155,10 @@ static struct {
 static struct npe npe_tab[NPE_COUNT] = {
 	{
 		.id	= 0,
-		.regs	= (struct npe_regs __iomem *)IXP4XX_NPEA_BASE_VIRT,
-		.regs_phys = IXP4XX_NPEA_BASE_PHYS,
 	}, {
 		.id	= 1,
-		.regs	= (struct npe_regs __iomem *)IXP4XX_NPEB_BASE_VIRT,
-		.regs_phys = IXP4XX_NPEB_BASE_PHYS,
 	}, {
 		.id	= 2,
-		.regs	= (struct npe_regs __iomem *)IXP4XX_NPEC_BASE_VIRT,
-		.regs_phys = IXP4XX_NPEC_BASE_PHYS,
 	}
 };
 
@@ -687,23 +681,34 @@ void npe_release(struct npe *npe)
 static int ixp4xx_npe_probe(struct platform_device *pdev)
 {
 	int i, found = 0;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
 
 	for (i = 0; i < NPE_COUNT; i++) {
 		struct npe *npe = &npe_tab[i];
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			return -ENODEV;
+
 		if (!(ixp4xx_read_feature_bits() &
-		      (IXP4XX_FEATURE_RESET_NPEA << i)))
+		      (IXP4XX_FEATURE_RESET_NPEA << i))) {
+			dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
+				 i, res->start, res->end);
 			continue; /* NPE already disabled or not present */
-		if (!(npe->mem_res = request_mem_region(npe->regs_phys,
-							REGS_SIZE,
-							npe_name(npe)))) {
-			print_npe(KERN_ERR, npe,
-				  "failed to request memory region\n");
-			continue;
 		}
+		npe->regs = devm_ioremap_resource(dev, res);
+		if (!npe->regs)
+			return -ENOMEM;
 
-		if (npe_reset(npe))
+		if (npe_reset(npe)) {
+			dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
+				 i, res->start, res->end);
 			continue;
+		}
 		npe->valid = 1;
+		dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
+			 i, res->start, res->end);
 		found++;
 	}
 
@@ -717,9 +722,8 @@ static int ixp4xx_npe_remove(struct platform_device *pdev)
 	int i;
 
 	for (i = 0; i < NPE_COUNT; i++)
-		if (npe_tab[i].mem_res) {
+		if (npe_tab[i].regs) {
 			npe_reset(&npe_tab[i]);
-			release_resource(npe_tab[i].mem_res);
 		}
 
 	return 0;
diff --git a/include/linux/soc/ixp4xx/npe.h b/include/linux/soc/ixp4xx/npe.h
index 3a980845e557..2a91f465d456 100644
--- a/include/linux/soc/ixp4xx/npe.h
+++ b/include/linux/soc/ixp4xx/npe.h
@@ -16,9 +16,7 @@ struct npe_regs {
 };
 
 struct npe {
-	struct resource *mem_res;
 	struct npe_regs __iomem *regs;
-	u32 regs_phys;
 	int id;
 	int valid;
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
