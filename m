Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C923C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652F42084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQcuuoI4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uLye05mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652F42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VPbB/yCTgLFSG8CONnEMGTNFRk3hOvE+CJobMZkkFaw=; b=VQcuuoI4Vvi7Fv
	4dVAcDSgbEc09bDS/RMMAPnKCfRxB0OEJhWi5s5mfSbi9dlHkM05cRRxquPvsRi9yXrtmYLQLKX42
	cuUKwiKI4QgSPHLljbz39FHfVekbnE1m/Cwi3ABuCPnxbpuGcxrfKKfYW0Ba0mtfFTy6edLDrrcJv
	opQeW5C0uw5K6sOcfa9aHinZlMLKfAcpJUvQbgoDRwBluj8IYnRXOF8JzOh7rZitYQ06U1OjCRDSr
	rqq5sX0JFA6losFeBdEbEaf+8VDsjExjQtRilGBaPiehwKxssnsm1Kpt+oYTbKz0VVRV1eyqbdfiE
	0biAnhIGemi2ZaI7sAKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8yH-0007D3-M7; Mon, 11 Feb 2019 10:37:53 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xa-0006WP-Ej
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:17 +0000
Received: by mail-wm1-x343.google.com with SMTP id x10so10932060wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ORsjA8hmqOYVa1A6z58C/tpqF85yI2kmPo177hZON40=;
 b=uLye05mHf5U4mdu8gXtjfTR+N3aOWDgsG2T1ERC4B3Socyqgmm/3fxEawS5ubPSdFG
 B/ugTQ69/ccJCN00HR4Lcd5V4LlAZZKtW1s8Og3uVxvxvXrVJyE11GUsT9OsoPTGzUHM
 KuzWsf48SBy2Y5Bus0/mXAoubrViDagkXNF2DHWvAg8468CqDAeNXfahxXHfjuX+acWV
 v+sU48xODUB6NESxzJW5iJF4xcMRX9IPNV7u8mxCsTi/tTgI90a5scml1fnBDrVw1L4i
 fdXYERqFuxqjpOg1epP/K3xE6iVPojWA+jj910LrTB/6BG8TRWFPJwSHGeuqSaBOuHeZ
 Djyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ORsjA8hmqOYVa1A6z58C/tpqF85yI2kmPo177hZON40=;
 b=fU5mUPj3pJp47th7UDIn/fMg6eQjefEzOfF52GRDJt8IzBYB7dR8PYaZaWfSGb6VCk
 GxH0FSbYqqugJHDFV96raFC9lwBlFEyPwnIyRlnONeJBKO3KtSltbAbJstwEzpw9r+vX
 I5htRLVldlRa2ixJbGogSQAIT1xlyMjunNh13kbpP+ilNJUWAmtsYWuVYDjFF2+kp79f
 NqtGl33l/WZtGNdr7D7PTG+SiWevcwZSKc9VtLG+H3fNlNXmec9JI2PG5+nf0rz1hy0d
 1/z1bjlAcFmWlAXZdc9iG3xV+3/Ie1tGCvUHsAm9pqRJsyMWPTxJjCczw6AN113Hz9h8
 ulVA==
X-Gm-Message-State: AHQUAuay46pyMthTPar6Pnd7BKx0iBYnbM+a0vw5X2SlXPD0nIyQ9HB7
 FH0wEtw9j95aZKi8qBEdgR5uJQ==
X-Google-Smtp-Source: AHgI3Ib/RRpS7Aag0oclwa7+AqIq9+WfvoGs3rvHUtSqAKvhDoU0qM6dtbyLVU0XyAbi8y51UGZqXw==
X-Received: by 2002:a1c:2408:: with SMTP id k8mr8550037wmk.110.1549881428735; 
 Mon, 11 Feb 2019 02:37:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/8] usb: ohci-da8xx: add a helper pointer to &pdev->dev
Date: Mon, 11 Feb 2019 11:36:56 +0100
Message-Id: <20190211103702.4277-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023710_927823_99D64315 
X-CRM114-Status: GOOD (  13.16  )
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
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a helper pointer to &pdev->dev. This improves readability by
removing all the &pdev->dev dereferencing.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-da8xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index c492c7e6f746..e8ede0b5e3f0 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -402,35 +402,35 @@ MODULE_DEVICE_TABLE(of, da8xx_ohci_ids);
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci;
+	struct device *dev = &pdev->dev;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
 
-	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
-				dev_name(&pdev->dev));
+	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, dev, dev_name(dev));
 	if (!hcd)
 		return -ENOMEM;
 
 	da8xx_ohci = to_da8xx_ohci(hcd);
 	da8xx_ohci->hcd = hcd;
 
-	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, NULL);
+	da8xx_ohci->usb11_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(da8xx_ohci->usb11_clk)) {
 		error = PTR_ERR(da8xx_ohci->usb11_clk);
 		if (error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get clock.\n");
+			dev_err(dev, "Failed to get clock.\n");
 		goto err;
 	}
 
-	da8xx_ohci->usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
+	da8xx_ohci->usb11_phy = devm_phy_get(dev, "usb-phy");
 	if (IS_ERR(da8xx_ohci->usb11_phy)) {
 		error = PTR_ERR(da8xx_ohci->usb11_phy);
 		if (error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get phy.\n");
+			dev_err(dev, "Failed to get phy.\n");
 		goto err;
 	}
 
-	da8xx_ohci->vbus_reg = devm_regulator_get_optional(&pdev->dev, "vbus");
+	da8xx_ohci->vbus_reg = devm_regulator_get_optional(dev, "vbus");
 	if (IS_ERR(da8xx_ohci->vbus_reg)) {
 		error = PTR_ERR(da8xx_ohci->vbus_reg);
 		if (error == -ENODEV) {
@@ -438,13 +438,13 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		} else if (error == -EPROBE_DEFER) {
 			goto err;
 		} else {
-			dev_err(&pdev->dev, "Failed to get regulator\n");
+			dev_err(dev, "Failed to get regulator\n");
 			goto err;
 		}
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
+	hcd->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(hcd->regs)) {
 		error = PTR_ERR(hcd->regs);
 		goto err;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
