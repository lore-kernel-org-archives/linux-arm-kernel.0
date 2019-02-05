Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EFDC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3138E2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pdy3k6EG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RSbmwGTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3138E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XbpuvRwFFHu2RwoAVsKA/qu8IjG5/pjEeQ93EdByIKA=; b=Pdy3k6EGyC3mS7
	agYANh41KSJFEvne26uG5VqKvXwuKqbSsapRhPahsy8sJ8usbOMva+/r+nH/1Imhckxuf/z0maAvh
	9mErx0m4HId4m0Yz4S7AWPWqKabJvJSAeMF3L8YIiQ1dUVBDvBHfxJ/78CBxVAVSdfvB5yjhFAizo
	XcEWQYs4WaNgbGWEso9ihyVhIPSUSuVzGoxox5HFzFIUWkVdOruByaCjgumeXzhGyHoqb/ljI86Iq
	RejbRyjJuW5QmdViYIMiZcxzNjpXW8RrGTdT+TURJg1JvjEo/hITH7y1dtreLVW9vyaDDyqA9JHNn
	S/Dz6fcS8dAxHCeYBisQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxvc-0007Yp-IF; Tue, 05 Feb 2019 10:26:08 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxvN-0007Kf-H7
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:25:54 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so12169675wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3EpyubzHmpBYIwWB1kg4OB1nrghXCzVSBiVe35BMGlw=;
 b=RSbmwGTBNDzgAS9Lt5lvqih71f9/sSFeCPyK4eSrPS/tAUmSE0BmxWJCL8iRsztWa2
 N7Ey0QqNAJhyEeCLmi75nu9eEOqEjoEG5FevLevCJl1b2OVPUxoPEM2eyBrIrDbN1H0W
 0Ru8fiaYlFq9ExKOYyTigL4V73NED9/XzLSrl/vUT6d9szov+BqWikXT6kP8sXQ5SCIX
 ZcXaTp3S3O745Pm/38VvFntkDoOAqG7WnAGlYE1EqszR0ArSnWRZcadksSZTJ7SMCpmz
 7WyIHZiKwtdqx/e/Ndmjz8UcCWYJbQ8H/jwC2TmZMVMz9rDQU+ZgWTENIh2McrH0dvvK
 6UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3EpyubzHmpBYIwWB1kg4OB1nrghXCzVSBiVe35BMGlw=;
 b=E0c6lJLaYcv4gqL2HQT8X+KujhWdpZwP0x/PSXdd5XAxroZLxjFkiQvLuZ+UuVzce3
 o33sk3sXsmv5mU+Z4dcrS2O8p0OwivIJzOr5xjKe4wU3nbvy8LJlMIcJ/Mk1Ub/pJwxB
 SdYshcu337IQLKbsuCGx5vUjHns88UjW7/4RFOqyjTFUI4qEbTEvXJZFPPGlXj6iGsV6
 s6S+Iq7wzBEKqR3FV6qGT+5qNje0plDRu8OFopnjKQVhJ7H6VokGfA21IGB8H+plzvAF
 e3iE0lp1r1C2r4KZTefJ27udX0eYXH3iTlCW5Oev1mREYR61EH6DbNVX9ZUyLh9K9Xml
 G74w==
X-Gm-Message-State: AHQUAuY0oLTt+gDKht4Kw1RAhaREiWGy6jjyJfZyCJUgH7Mo5lw6gq0g
 lkgn7MoRTrJriiQHD7tC5thIEw==
X-Google-Smtp-Source: AHgI3IavTgvkr8R3vGnWMQgauROLW65WfKaGxIbsFxWdWDcT0vKa4XoS0uCH6ylybl6tTZuKkciMew==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr3118795wme.120.1549362351739; 
 Tue, 05 Feb 2019 02:25:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:25:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/8] usb: ohci-da8xx: add a new line after local variables
Date: Tue,  5 Feb 2019 11:25:39 +0100
Message-Id: <20190205102546.29457-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022553_563434_E0E60910 
X-CRM114-Status: GOOD (  11.08  )
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

This improves the coding style.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
