Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3BAC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:27:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5FE2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpKHk3J8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1acO/Tza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5FE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eSX9sSCR6Bvdl+8rYs7Yg68vjAjgASUsNoDO0S4LL6s=; b=LpKHk3J8cFGxq2
	PMJ6xaJJDr1wu8SsyS0rXTWNWmZfWArj+qKqg0jvdsmG9LMhsi5mgXrCCymzYWLkmREtopWqtO9IF
	UDOlAOc4icmax7u4wBl1I8ekYgG8Px6aZM1zTYQW0Vn+vuA73w0M2/Co1mt+LaTmix/+Tyi6820oS
	Mxw5enhjrZ+wx1NBpUUOUi90wVDdBIaToi+PEbgDYjrD0oe+HRZIj6b4ZhYKKBxUy4oIlW1feilk+
	vlY0TTdfpGVHfz6qIDGFUPNjech2q+58qIgRhN0F4cbdwqubOmjPkF+I+8oiNvf2uUxJrCtWEUhu3
	oDJE2KJSZh9XEaii7OXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxwn-0000RI-2Y; Tue, 05 Feb 2019 10:27:21 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxvW-0007PY-Ef
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:26:10 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so2960309wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
 b=1acO/TzaTS03s9bceKurSqbS0vnd6Wsw05XIWMfb6Q2TUUfpvFDveRnfJ2Kzk4em+l
 OjQL9v8R1DrfVaeDQKUkF8JOrVbqpzOgHmFXnRmTr92FWfHKpJddgbQc7TQmC4ztVaS5
 tPZtuw7wux1ULY4TvoZEMToU38yEeWQi9Twg+kDMuTrCEdw6plCxpJX2C0ihtxWe2TC6
 ey5twDj3VC8lUzf9lCYzwyIdbiMb3NrQ6rd5Od4Kic4x+LZIisPDbAi9+PTCNgdbFcCQ
 zQ0kEbnp3QIochiozQP6p8/PQ1IU5+yylC87Xie+1IvcLeEG7kztOVefqgvRU2moGjaG
 0ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bcVd+xaXefW/PkS3D+eVHZxbCvxtmtyCV/GOjJgMVBA=;
 b=lPqhMm0SjBKXHJ4Vtr2HdH/ZUsdtyc1THdoQzkhv7LD5M11xZubxOL9qPXJBOJyNxA
 8deMavKh/FqNKOqCLJIqZGYivDCwjdWqUYYqWe0E7nPqV9k9k9qn6kbA1ixDmKJuYyT9
 mli7xLHk1vLe75XWtWQAVK+LPUNIsjiDX0zZ42aJs4miHplkQsgDigPyo/EQKwvxNx9l
 C6LwNdMWEfL8ckoN/0RdVPJNDJrQaK7zl20H+nLFpQHbaf6gy+bz7K4x56Mll3NArlJE
 c+4DyV/tQu7jKU3WEC7MFeZyMr428EK8EwLOOhHKP7edIGAem+As6vYmr/EIrNHxc0sJ
 aFTg==
X-Gm-Message-State: AHQUAuZr++WEXq3yC14n8RbIvj7Au8MwUyGsCfHTapen/nK6PH/W9k8D
 etiTsv4BM24uIIU7gc+YsjMVRQ==
X-Google-Smtp-Source: AHgI3IaJHGNe/jeXwZM5GgTrUi1I/64CzT56Inrtp+00XAI6g8YCac9ynWVLI2Q0xYU6hZq2/Weg2A==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr3225217wrm.2.1549362358789;
 Tue, 05 Feb 2019 02:25:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:25:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/8] ARM: davinci: da830-evm: remove legacy usb helpers
Date: Tue,  5 Feb 2019 11:25:45 +0100
Message-Id: <20190205102546.29457-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022603_033428_FEC4C0EB 
X-CRM114-Status: GOOD (  13.40  )
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
