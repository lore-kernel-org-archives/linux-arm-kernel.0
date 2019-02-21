Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:49:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7887420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rNBNuESc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3/fZ62a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7887420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e8mNGFbz21pwieT5ELVrh4YWtuKnBV5+zxcC67u8z9w=; b=rNBNuESc4bGa0y
	/81rdog0J+rMJLnaENFZVSKRQQcFJ8CnAPhh0DnkMs9cG7ww+VrF9BASBWWJUk+meRYKb63ttIiak
	ntwSh7nydlBMh7SQCzKlvWaxrO7+R78X5v1Bu+A6sqXdARMcUuT3qsIgGPLOeEzJ2QfP5jzs74TWo
	hfAOmeyv+L3pSSXsFWuGqKchZoPdZwpDv/lJDgOMm8o6JIM2eUOs5gwp5LcUpHKRiCV1u/ctzBRyP
	4+4EoBcMMao7gcKZ0JydgRU2cLk13sTqZ7Nk2LHPzig5/JVHgsUyhF/MOB/1m6L1hBeF1o/JV2Et5
	b98l/KWwQtKdzgFmK/tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqbf-0000uL-Jz; Thu, 21 Feb 2019 15:49:51 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqY9-00060K-Jp
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:34 +0000
Received: by mail-lj1-f194.google.com with SMTP id f24-v6so24414051ljk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wxq/g1XwOmGH57v5gJ5VN8B51U6PYBwzcFrtP8VTd60=;
 b=t3/fZ62aCTRO9RhWEKsJEIO4T6axSVaJtnPyDlFSLQIjX2hZYZuVwU93Wehy3UdxOD
 He1eA5odkLWJYh3pmIukRE9d/YCZiPDGK2wKqMMWiR6+4NwLu0keXfBX4R5Sv0Vly/he
 yyHeeaqhqKMNey5AtZyBcBuxBe46CWTwm22y13E4FNFqCVRL8AhHW4iOuqDKB/WcqgMx
 EAHmtcwhty7waiKnWMWt08wqX7W16RFG0VMNYFMhUw9sm9XM0bK8wUyljREHp4wFLL2p
 FG4fkYyZ4Ddz5P604CloSOOvYWy2QBh/r+PrJfwkop6DRG9ol7pYUtoVuBbRE8pAdEDD
 PIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wxq/g1XwOmGH57v5gJ5VN8B51U6PYBwzcFrtP8VTd60=;
 b=UNzWlyBGu+hYQ9zqCQl0CPaw6CbBSBsWaACcw1s6+ptozeULtMqQBkIHAsNO/dQ94O
 p6bU4jEEByiBHYhLO6RaJHz3by25gdz5Dm53uJom9ZevflD71mfg3IdtcJAHCqnlpg4r
 cUAEGR62EPhg70rXJ8CLQdF3buOF6lUOToQMXYkBIw4dLvb8DI2lQ3ZoxD4caFISJ9DE
 4nhkrx5ppAL+WAtp6r6b75PngaISoMQdMNVy0U2r09XkjuDPDVfzv1tGbsjsQ2MAafI/
 AWPoTth9FN7i/KdxSMfHuGFlC6q1g4jSZhdlR2RAbedEWTfrV1qX4BO0X8arbI4oU1ve
 pI/Q==
X-Gm-Message-State: AHQUAuYHXk48wMJGxnHh6RSfNRzWJSWS8p1f6a5JVndgDHwHNV7aZRWm
 xZRA/Ki6e92cl0+QZ4vzno0w/EuGeW8=
X-Google-Smtp-Source: AHgI3IYIhAAljBGXr/S2/gBuOm4Y2/R1xvknOb2WWv9iJmvl5NyElxg0dl+Nbmn6wLJ3Fsy7UoWotw==
X-Received: by 2002:a2e:9448:: with SMTP id
 o8-v6mr1468185ljh.164.1550763971045; 
 Thu, 21 Feb 2019 07:46:11 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 25/30 v2] soc: ixp4xx: qmgr: Pass resources
Date: Thu, 21 Feb 2019 16:44:53 +0100
Message-Id: <20190221154458.23763-26-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074614_403446_4CF7F853 
X-CRM114-Status: GOOD (  18.68  )
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

Instead of using hardcoded base address implicitly
obtained through <linux/io.h>, pass the physical base
for the QMGR block as a memory resource and remap
it in the driver.

Also pass the two IRQs as resources and obtain them
in the driver.

Use devm_* accessors and simplify the error path in the
process. Drop memory region request as this is done by
the devm_ioremap* functions.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c                 | 25 +++++--
 .../mach-ixp4xx/include/mach/ixp4xx-regs.h    |  2 -
 drivers/soc/ixp4xx/ixp4xx-qmgr.c              | 71 +++++++++----------
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 07c3cb312a92..cc5f15679d29 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -66,11 +66,6 @@ static struct map_desc ixp4xx_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(IXP4XX_PCI_CFG_BASE_PHYS),
 		.length		= IXP4XX_PCI_CFG_REGION_SIZE,
 		.type		= MT_DEVICE
-	}, {	/* Queue Manager */
-		.virtual	= (unsigned long)IXP4XX_QMGR_BASE_VIRT,
-		.pfn		= __phys_to_pfn(IXP4XX_QMGR_BASE_PHYS),
-		.length		= IXP4XX_QMGR_REGION_SIZE,
-		.type		= MT_DEVICE
 	},
 };
 
@@ -176,9 +171,29 @@ static struct platform_device ixp4xx_npe_device = {
 	.resource       = ixp4xx_npe_resources,
 };
 
+static struct resource ixp4xx_qmgr_resources[] = {
+	{
+		.start = IXP4XX_QMGR_BASE_PHYS,
+		.end = IXP4XX_QMGR_BASE_PHYS + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = IRQ_IXP4XX_QM1,
+		.end = IRQ_IXP4XX_QM1,
+		.flags = IORESOURCE_IRQ,
+	},
+	{
+		.start = IRQ_IXP4XX_QM2,
+		.end = IRQ_IXP4XX_QM2,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device ixp4xx_qmgr_device = {
 	.name           = "ixp4xx-qmgr",
 	.id             = -1,
+	.num_resources  = ARRAY_SIZE(ixp4xx_qmgr_resources),
+	.resource       = ixp4xx_qmgr_resources,
 };
 
 static struct platform_device *ixp4xx_devices[] __initdata = {
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index f5d5b258c3f7..588b76651085 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -43,8 +43,6 @@
  * Queue Manager
  */
 #define IXP4XX_QMGR_BASE_PHYS		0x60000000
-#define IXP4XX_QMGR_BASE_VIRT		IOMEM(0xFEF15000)
-#define IXP4XX_QMGR_REGION_SIZE		0x00004000
 
 /*
  * Peripheral space, including debug UART. Must be section-aligned so that
diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index f3775346e007..64572f2d6ff0 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -16,13 +16,9 @@
 #include <linux/platform_device.h>
 #include <linux/soc/ixp4xx/qmgr.h>
 
-/* FIXME: get rid of these static assigments */
-#define IRQ_IXP4XX_BASE		16
-#define IRQ_IXP4XX_QM1		(IRQ_IXP4XX_BASE + 3)
-#define IRQ_IXP4XX_QM2		(IRQ_IXP4XX_BASE + 4)
-
-static struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
-static struct resource *mem_res;
+static struct qmgr_regs __iomem *qmgr_regs;
+static int qmgr_irq_1;
+static int qmgr_irq_2;
 static spinlock_t qmgr_lock;
 static u32 used_sram_bitmap[4]; /* 128 16-dword pages */
 static void (*irq_handlers[QUEUES])(void *pdev);
@@ -190,7 +186,7 @@ static irqreturn_t qmgr_irq2_a0(int irq, void *pdev)
 
 static irqreturn_t qmgr_irq(int irq, void *pdev)
 {
-	int i, half = (irq == IRQ_IXP4XX_QM1 ? 0 : 1);
+	int i, half = (irq == qmgr_irq_1 ? 0 : 1);
 	u32 req_bitmap = __raw_readl(&qmgr_regs->irqstat[half]);
 
 	if (!req_bitmap)
@@ -381,12 +377,25 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 {
 	int i, err;
 	irq_handler_t handler1, handler2;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq1, irq2;
 
-	mem_res = request_mem_region(IXP4XX_QMGR_BASE_PHYS,
-				     IXP4XX_QMGR_REGION_SIZE,
-				     "IXP4xx Queue Manager");
-	if (mem_res == NULL)
-		return -EBUSY;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	qmgr_regs = devm_ioremap_resource(dev, res);
+	if (!qmgr_regs)
+		return -ENOMEM;
+
+	irq1 = platform_get_irq(pdev, 0);
+	if (irq1 <= 0)
+		return irq1 ? irq1 : -EINVAL;
+	qmgr_irq_1 = irq1;
+	irq2 = platform_get_irq(pdev, 1);
+	if (irq2 <= 0)
+		return irq2 ? irq2 : -EINVAL;
+	qmgr_irq_2 = irq2;
 
 	/* reset qmgr registers */
 	for (i = 0; i < 4; i++) {
@@ -411,43 +420,33 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 	} else
 		handler1 = handler2 = qmgr_irq;
 
-	err = request_irq(IRQ_IXP4XX_QM1, handler1, 0, "IXP4xx Queue Manager",
-			  NULL);
+	err = devm_request_irq(dev, irq1, handler1, 0, "IXP4xx Queue Manager",
+			       NULL);
 	if (err) {
-		printk(KERN_ERR "qmgr: failed to request IRQ%i (%i)\n",
-		       IRQ_IXP4XX_QM1, err);
-		goto error_irq;
+		dev_err(dev, "failed to request IRQ%i (%i)\n",
+			irq1, err);
+		return err;
 	}
 
-	err = request_irq(IRQ_IXP4XX_QM2, handler2, 0, "IXP4xx Queue Manager",
-			  NULL);
+	err = devm_request_irq(dev, irq2, handler2, 0, "IXP4xx Queue Manager",
+			       NULL);
 	if (err) {
-		printk(KERN_ERR "qmgr: failed to request IRQ%i (%i)\n",
-		       IRQ_IXP4XX_QM2, err);
-		goto error_irq2;
+		dev_err(dev, "failed to request IRQ%i (%i)\n",
+			irq2, err);
+		return err;
 	}
 
 	used_sram_bitmap[0] = 0xF; /* 4 first pages reserved for config */
 	spin_lock_init(&qmgr_lock);
 
-	printk(KERN_INFO "IXP4xx Queue Manager initialized.\n");
+	dev_info(dev, "IXP4xx Queue Manager initialized.\n");
 	return 0;
-
-error_irq2:
-	free_irq(IRQ_IXP4XX_QM1, NULL);
-error_irq:
-	release_mem_region(IXP4XX_QMGR_BASE_PHYS, IXP4XX_QMGR_REGION_SIZE);
-	return err;
 }
 
 static int ixp4xx_qmgr_remove(struct platform_device *pdev)
 {
-	free_irq(IRQ_IXP4XX_QM1, NULL);
-	free_irq(IRQ_IXP4XX_QM2, NULL);
-	synchronize_irq(IRQ_IXP4XX_QM1);
-	synchronize_irq(IRQ_IXP4XX_QM2);
-	release_mem_region(IXP4XX_QMGR_BASE_PHYS, IXP4XX_QMGR_REGION_SIZE);
-
+	synchronize_irq(qmgr_irq_1);
+	synchronize_irq(qmgr_irq_2);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
