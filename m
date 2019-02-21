Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CC820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BzK8H5ud";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFUvfAEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CC820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B4txw5kP3XO+U5U8RuAkgQ3FdLF0oXw8QkjPuE5Ut3A=; b=BzK8H5ud9SQ8Kk
	HTvbQbycnU0lY8Prrl/rKr6PLHCEGSEa91cdP/di9hN9m53ImZhVnNdKPf0xLIwWlMtOJ0OZfUhHB
	XWkY6HDk7GXh9Amd5D8bQ0aDIeHm6SJszbN2FQpK09wVNEuPyE/eDiziZM1RvOM4yaK6jjz1xXdNh
	6eVgulXuY7A7uWTOHL/2iKlBWE3v6ALzTQkK3QkAAYQ9ghsyt2hkxJ9embwR56GDpH2gXXZ+VgvQU
	QaVLS5D3n1CAUXbN5ZLnsUekLgf/T8eWDBsktpfmqpEmBvA1499Q/Roq/6xUOpe1lBojAmVa/GDYv
	Dd1mLopz4Kqlv9jMR61g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqbY-0000mZ-Bf; Thu, 21 Feb 2019 15:49:44 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXz-0005nd-KW
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:32 +0000
Received: by mail-lj1-x241.google.com with SMTP id v16so24368046ljg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eqn2Bvj9SCb/dO93NxImMW9IFWDZSqHXlOR9B6GuSXg=;
 b=hFUvfAEGbccvJsuv7TCEaxzUJu5Uwpi3II7OzkvxptGlljChi6M2eDYjOcAQ9Jly+P
 G0Culc14pr5dt18AMhsWZp3WOxNv0M+sJkW2vH3lyc0+Wcp2ZcMmRdCMPj9PH+4fK2/u
 ObD656WFY9SlG2iDOKaC4zWgzxnAAuXXUGacsh3V0moULSgZxe/o/U/h1LWOZy5x3s3G
 xOBliBGiJSBWz6f60bTmXhIs3GI1ZfJ4xUFCC20qRzu+nTlx5lu8+ZjwXlMeMKAyAt1W
 ql5kZKUyOjZY2A6Rzbu4psI353GDNGuM5eTup+w15SztW0ln00aL+olfyEhprzCMJVI7
 TViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eqn2Bvj9SCb/dO93NxImMW9IFWDZSqHXlOR9B6GuSXg=;
 b=K0k0XekNvobRN74NuM9Ry2EyilLYeR0mMZMMksav1CFMZR/Zha8ZnVEZoEjUCR6KIv
 /tk4ITst30PN99Xs7fntjiiLTf/sl+nwvN4PpaivDbHvaU5DPofu3hQIJe4q3jzk2V26
 CVJHyPorY8nNCzBLDtunkJuRAGU7W2HOLuvR0DJLac5RvoWK9mSG0zT91gze9LxGw3pY
 G5BfGK/Ij2DY0MK9NAFcZnHxr7/sVx9Qb+unMuZCTn9Nb05INuwsRB9ot5ROxO9XNqPz
 xtpLod0Qx8DF4lRJoY477FtKZwCqWRvGtNtnNYk4HqUFt6dC4L0pk2ibltJqx0LJTADM
 w9cA==
X-Gm-Message-State: AHQUAuYh7ZW34EtdRK+y21HcqKvOGCltqa77slBLmGaVLkpfVUgIarzC
 jzeS6G4dQP2c7IfsT5ckBXStXmIetro=
X-Google-Smtp-Source: AHgI3IZFs3SgJ7orBCurHWlpl484ByM4JozigVG4cnpEbhvA1u7E41GZj+zv73GwqUbbIuPfaw86Yg==
X-Received: by 2002:a2e:5d88:: with SMTP id v8mr24542366lje.150.1550763961783; 
 Thu, 21 Feb 2019 07:46:01 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:00 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 21/30 v2] ARM: ixp4xx: Turn the QMGR into a platform device
Date: Thu, 21 Feb 2019 16:44:49 +0100
Message-Id: <20190221154458.23763-22-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074603_962313_4B46BE43 
X-CRM114-Status: GOOD (  16.80  )
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

Instead of registering everything related to the QMGR
unconditionally in the module_init() call (which will
never work with multiplatform) create a platform device
and probe the QMGR like any other device.

Put the device second in the list of devices added for
the platform so it is there when the dependent network
and crypto drivers probe later on.

This probe() path will not be taken unconditionally on
device tree boots, so remove the DT guard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c    |  6 ++++++
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 21 +++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index e7789d06c39b..cdcd6d6b6d3d 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -155,8 +155,14 @@ static struct platform_device ixp4xx_npe_device = {
 	.id             = -1,
 };
 
+static struct platform_device ixp4xx_qmgr_device = {
+	.name           = "ixp4xx-qmgr",
+	.id             = -1,
+};
+
 static struct platform_device *ixp4xx_devices[] __initdata = {
 	&ixp4xx_npe_device,
+	&ixp4xx_qmgr_device,
 	&ixp4xx_gpio_device,
 	&ixp4xx_udc_device,
 };
diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 1bed048924bb..133914e99aeb 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/soc/ixp4xx/qmgr.h>
 
 /* FIXME: get rid of these static assigments */
@@ -288,15 +289,11 @@ void qmgr_release_queue(unsigned int queue)
 	module_put(THIS_MODULE);
 }
 
-static int qmgr_init(void)
+static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 {
 	int i, err;
 	irq_handler_t handler1, handler2;
 
-	/* This driver does not work with device tree */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
 	mem_res = request_mem_region(IXP4XX_QMGR_BASE_PHYS,
 				     IXP4XX_QMGR_REGION_SIZE,
 				     "IXP4xx Queue Manager");
@@ -355,17 +352,25 @@ static int qmgr_init(void)
 	return err;
 }
 
-static void qmgr_remove(void)
+static int ixp4xx_qmgr_remove(struct platform_device *pdev)
 {
 	free_irq(IRQ_IXP4XX_QM1, NULL);
 	free_irq(IRQ_IXP4XX_QM2, NULL);
 	synchronize_irq(IRQ_IXP4XX_QM1);
 	synchronize_irq(IRQ_IXP4XX_QM2);
 	release_mem_region(IXP4XX_QMGR_BASE_PHYS, IXP4XX_QMGR_REGION_SIZE);
+
+	return 0;
 }
 
-module_init(qmgr_init);
-module_exit(qmgr_remove);
+static struct platform_driver ixp4xx_qmgr_driver = {
+	.driver = {
+		.name           = "ixp4xx-qmgr",
+	},
+	.probe = ixp4xx_qmgr_probe,
+	.remove = ixp4xx_qmgr_remove,
+};
+module_platform_driver(ixp4xx_qmgr_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Krzysztof Halasa");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
