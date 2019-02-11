Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124BC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315782084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MOcV8ewG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="u3Q4zH4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315782084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eSX9sSCR6Bvdl+8rYs7Yg68vjAjgASUsNoDO0S4LL6s=; b=MOcV8ewGXipig8
	aSzOg5goKYESkLKbNb222+Z4/OkWSF+mVazI5slKw1wPIVQNVPkr++5w89pLu7wm2ndbSf7y3YRkx
	kL3dlml/9Ziq2kEH+PDcaNK3OclBxOHmlDoeUUMlwwDIeU7pAC51ogF0lKeUCocjS1BkNLvRLDqp1
	QuW3SOFEN+WgFc5kiAqMgbj/xLvkJPxWf0Lgt8SxiYXmUBQMQ+/xvJsLJsso1q8PLY6/L0Z60/BXK
	xlHSLlLYON7lEIp4QvnIhBwCunwRoO1/Qtf0yHB/ZUjfa1+Y6md0cRcYm9CtjKCRkBwFEWpHtAsRs
	mo7jXVZ40W5WH9DxmMvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8zO-0008C6-A0; Mon, 11 Feb 2019 10:39:02 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xg-0006eJ-2H
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:20 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so16799184wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
 b=u3Q4zH4InQZAGR7svFMkRl7v89pFKfHGoRrnJFlv5DW9Px1T+nn4Q2VhAPlAPpq9Vc
 MO+q9mckzodN35P/zXsf2kMs2hUX306418rHNrmmGXyZA2ZoWXhkjisQAY1JyYwkKzHs
 lB85w49K3cPwbDMTMw0WaLs4xaa11TgDZuie+m/2RZ+8qMprTWEv5+IeJPyaGZRRfD1I
 MMikG29Rk+LjyyZ+RYXT4XxSMl7qC5CGS32pm2Jjq4CsgecqzVuJ4bzRM9OCIBkK5hDg
 AuCfBpK5kAE+t5DNYH7bfn5rSQOpkGvKg8k2ASkkrun97VzQ3biLXyYtoVmJHn6geSif
 j/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
 b=iaIJ2v6XvbKMNFsLTn5ZMsdn29kDaJk68lCV846EAt7T/1bYabO52LpK1CEdsA/C7O
 k8wPhnBIAYU5BeoY2AvmOycbz63C5FBMaqXGW8qJWTsKJNSB/0zkjuWjmKDcb9Do2WND
 9SBh+HsuikPsuzngkojoYhSt8BPLeDKgdAJQQx/8tM6w/4bFp4Z/3lVdIEZ1X6FlAzoL
 qFAh+H8IQjSr/TWlEZByuoHpcWcZ2NtCwhxpMPwXKvLockd5RHaWR70tv7qu1xYe342x
 wK5XT2pMpUp69BZJg3eyQzGTTSUpdMCufLI8UOt5QnEuil85AH5yTyhD6PsM1PYZDPNr
 m5Ag==
X-Gm-Message-State: AHQUAuaGLEEQArvNJe6A1DzdyZstCzvvJrdKdGVqhYPG9io2XoKcA3FQ
 0i+Hp5gPfVvKCuPlU1GI+iLXGA==
X-Google-Smtp-Source: AHgI3IZe1dMiumbFFArVH10zKtDOgopWjaSrOZMfbCL3N1BeBwlapJzl5oFuZGmteU62M2T/bQ24Cw==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr8285090wmi.141.1549881434634; 
 Mon, 11 Feb 2019 02:37:14 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 7/8] ARM: davinci: da830-evm: remove legacy usb helpers
Date: Mon, 11 Feb 2019 11:37:01 +0100
Message-Id: <20190211103702.4277-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023716_337815_C110601B 
X-CRM114-Status: GOOD (  13.65  )
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

The logic implemented by these routines now lives in the da8xx-ohci
driver. Remove dead code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 67 -------------------------
 1 file changed, 67 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 0712a37153a8..8d30f68773a0 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -52,8 +52,6 @@ static const short da830_evm_usb11_pins[] = {
 	-1
 };
 
-static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
-
 static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
 	.dev_id		= "ohci-da8xx",
 	.table = {
@@ -62,60 +60,11 @@ static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
 	},
 };
 
-static int da830_evm_usb_set_power(unsigned port, int on)
-{
-	gpio_set_value(ON_BD_USB_DRV, on);
-	return 0;
-}
-
-static int da830_evm_usb_get_power(unsigned port)
-{
-	return gpio_get_value(ON_BD_USB_DRV);
-}
-
-static int da830_evm_usb_get_oci(unsigned port)
-{
-	return !gpio_get_value(ON_BD_USB_OVC);
-}
-
-static irqreturn_t da830_evm_usb_ocic_irq(int, void *);
-
-static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq 	= gpio_to_irq(ON_BD_USB_OVC);
-	int error	= 0;
-
-	if (handler != NULL) {
-		da830_evm_usb_ocic_handler = handler;
-
-		error = request_irq(irq, da830_evm_usb_ocic_irq,
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				    "OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch over-current indicator changes\n",
-			       __func__);
-	} else
-		free_irq(irq, NULL);
-
-	return error;
-}
-
 static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
-	.set_power	= da830_evm_usb_set_power,
-	.get_power	= da830_evm_usb_get_power,
-	.get_oci	= da830_evm_usb_get_oci,
-	.ocic_notify	= da830_evm_usb_ocic_notify,
-
 	/* TPS2065 switch @ 5V */
 	.potpgt		= (3 + 1) / 2,	/* 3 ms max */
 };
 
-static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
-{
-	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata, 1);
-	return IRQ_HANDLED;
-}
-
 static __init void da830_evm_usb_init(void)
 {
 	int ret;
@@ -150,22 +99,6 @@ static __init void da830_evm_usb_init(void)
 		return;
 	}
 
-	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port power control: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_output(ON_BD_USB_DRV, 0);
-
-	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port over-current indicator: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_input(ON_BD_USB_OVC);
-
 	gpiod_add_lookup_table(&da830_evm_usb_gpio_lookup);
 
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
