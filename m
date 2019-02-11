Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AFBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBB82084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bedcx73L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TCld4ftq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBB82084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ntiGG97f43KkXNNLQVbBtOrJ1DuPXg7ICS065ynklPo=; b=bedcx73Lk99Ulz
	wExOhHK+nYOxPO7QdWT7JZRXOAFj7IHA5SCWEAEanDdbpE0Ac5URgiEpbRx62y1YjGNqW76AW+O68
	ddkTzfwchmXkyUi/3nvMLP4yg+T7C5uRtKyA5TL7TlXI0n0cWZLe2E9Et4Tk/yRbhComDlLWnTs2A
	FVdbxlmx0WZbZBKD7xxQooOIfE7jWqRslayhJ1rZV+YUeBMZBiDNtGVTKvYXoOXnMYgLqV1iJ2t5f
	uoCIQmCreQ/PEJLUCa/uY/JSuuDyb+c9LXRDcEl0wbv1YM1Wj3jLm1Z2TdUT0oDDOhK+mIsfxCVaX
	QJj59xaYy8BriMWFsw0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8xn-0006jc-Dw; Mon, 11 Feb 2019 10:37:23 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xZ-0006Uz-7G
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:16 +0000
Received: by mail-wm1-x341.google.com with SMTP id x10so10931913wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZNwPEUUTlCKX5Tqu2ze2gsmyzvW07YJCGJtag7575fc=;
 b=TCld4ftq4o8gIrjIznjZq3jxcUZNeaxWAv8Iw0vN33auSy+j/cBSUURcWRlCrpTsyB
 tB+fj7UL22HKjx+Ez8cDvi2t/KERMJRTsbklW1HGgHSJawHsbCHqsTNlyEh68oJ5YwGW
 jKDoDC9+w9yhuGPmx8JFssA9SnzFQFrNdddUGUy7z3gmrkEYjtBilyoWErP5Vou+xDFN
 in+55gJWdO7Og5X6ajvsiIYxeZMrJ7pwhoJ/VAWYdoZ2vzs/Vqd7YRZJfmxczpC3/gFM
 uN4O6lx7oRlSqsvABBtqy+GH+FEpQ7ZZuQOQUY2xjZpup6KoFrI8SSasJxw9hI/uFcjP
 WLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZNwPEUUTlCKX5Tqu2ze2gsmyzvW07YJCGJtag7575fc=;
 b=I3EHSaVdhiS5mz0AFp5zj/ASknCFbchqfRg5DPiOjasmQjYcNblJSzPvVWXB4+BMxd
 VvWygpWPO+Nbk1xOEywdF4epNKBGbbpnlkerudux0vqXhyDuIrCLbzuES4S/Fb9ZZbjn
 zEQskCifE7LGT2PvoakI4D6dqg31i2L9fEmZIwzyA+RipPsvzCGSjmxt3Jna1SXZ9ael
 oo1nL1DN3af2+dAcPbNTBSQwIOCO9K00IJZsGPMgaLTCB9Iut1f1w0+SISuI4SR5gBtw
 NKYReRxg19P6dcSFEIrwssRvVZT71xHyFHKBw1sTvdWj0X2EYClnh2h3bkcA52J8QFA0
 goBA==
X-Gm-Message-State: AHQUAuZju79JOjDszR7xT8VNQwgIUkRriBpeUbktkcKuIer51phJsMDH
 aZUgpN26PrIqVPneKfZHK4/aSA==
X-Google-Smtp-Source: AHgI3IapcLHP60sKSGdnr6I8oTwK59n+VObCekkqjdq2A/HslDpU3Tujq3LohKnrjKJC+aDBWpfZVg==
X-Received: by 2002:a1c:7a18:: with SMTP id v24mr8376506wmc.107.1549881427522; 
 Mon, 11 Feb 2019 02:37:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/8] usb: ohci-da8xx: add a new line after local variables
Date: Mon, 11 Feb 2019 11:36:55 +0100
Message-Id: <20190211103702.4277-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023709_885403_60BC1613 
X-CRM114-Status: GOOD (  11.72  )
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

Add a new line after local variables. This improves the coding style.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-da8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index a55cbba40a5a..c492c7e6f746 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -405,6 +405,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
+
 	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
 				dev_name(&pdev->dev));
 	if (!hcd)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
