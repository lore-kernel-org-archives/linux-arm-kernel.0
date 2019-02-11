Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:38:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5939F20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jx5MAVTu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TfE6WQSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5939F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yv2RMkYnGMj99Pz0+3UqTaeapu5Buqo7jFb5UEBq3Q4=; b=jx5MAVTu66NfzO
	mTjrxtEO89jYHu5HyUdlmwrfimMlcTzFf3Iykj/N2F2785jKOfAkcSYcxQFtHU8zTd/or3f6r/iml
	LjlgxzgP7lWkcKD3iWEscK4RIM3MyxSPS+Nt7vuyHQ5s++M20FUj3BQIXwk8B7e0cO+hiEtP5ZBBy
	e72y4VIO8/NzkT+txdbx35wyI5mVYyd/l54S45iWe/HHw5UFqw0CvE7pWZE8UXdr2PLZlaBN4HU0y
	j2fzs4UV/1gDdIgZK6hD0BTZdGXHzQvoHGO2zKoD7m4zBBSjtqy4kTPNVTBjz8oEgK1iwtOTYFu3g
	NtHY7qvXhtS8xu/wwngw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8z8-0007y3-71; Mon, 11 Feb 2019 10:38:46 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xd-0006bR-Uu
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:19 +0000
Received: by mail-wm1-x341.google.com with SMTP id q21so16300189wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PatZI+PBeu5EDAbtmqHN1dIkr0rFbuYENoq6lvPpAmk=;
 b=TfE6WQSicMIya7zncLgIUVwcSP+ApnZapuPOWt8UmZEilaAw9/yde+tfzFhyDvVBoP
 Ydi9eg/ZsfJxOCRBu18lagVlc4Z6vSisfj0/fbVfsRTLti27d63EKr/Vlgb4Yp3AV4n1
 Xp5pdkH9tiSrVg4ZBeEw8IDHQ20NUQNxcNCgs1jb6w75o54D7J0B48n235f+jjq/xQbq
 mHW8JqeH/2lB9ZwQHt2pDzOLScH5pAYKcB4sj8dnoXoEEvaQF1QBtTjXrpv9W5BU/vhV
 Eif+SkBn0HGBRSGxKUVAaJGjAqIcJKhtVRGTuVL58vyPfdfDvHgP8mAGOq4FZ5zoYPv8
 40zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PatZI+PBeu5EDAbtmqHN1dIkr0rFbuYENoq6lvPpAmk=;
 b=ewEhPS054HbBidU5Uc6y3t4Qxl4HA9BiFM+8+pYhFyWDx5ud+5rtByfwEnY3/PGNBq
 D6Ze69WK7GUwQmDHvV7G8gAoxHKozpDazpyheVSBpb3rLK0gfvmBWo6pxvtrdC5tOGUK
 XcVPAp4XVtJeBxGU28L8qmxnDjlXzVyekFhm+7IjBWvhYf1MXQWDhytrgSIkCeFWzFrO
 XwZzkzGHKz+qN4XptHcE+hDigoZjai/VDm7hV2/AUAQQogCyerKQkMRVn/dXHo5jig7o
 GlBJJ/kH2Tb/JfPqMvGYzFmZSuJl+9BIpl9CNTpoz4BaZOWMq5bcRPMW6+AUs/e/b885
 KzZg==
X-Gm-Message-State: AHQUAuZEfcPw1E24BjmwnTC4YQS5N/fhKtVWm4kq9thQb+Nc6VZmf6gI
 RIZAdH16wrRl+W1W4SC1XCETBA==
X-Google-Smtp-Source: AHgI3IbtH2tOw4AuuQFPW6QFljREQ/DwC011boIisES66MFwobAzARakeG3KjtCHSQeA9KbgGmotjw==
X-Received: by 2002:a1c:ef13:: with SMTP id n19mr7203271wmh.70.1549881432486; 
 Mon, 11 Feb 2019 02:37:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/8] usb: ohci-da8xx: add vbus and overcurrent gpios
Date: Mon, 11 Feb 2019 11:36:59 +0100
Message-Id: <20190211103702.4277-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023714_408327_D32AC9F2 
X-CRM114-Status: GOOD (  19.62  )
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

There are two users upstream which register external callbacks for
switching the port power on/off and overcurrent protection. Both
users only use two GPIOs for that. Instead of having that functionality
in the board files, move the logic into the OHCI driver - including
the interrupt handler for overcurrent detection.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-da8xx.c | 99 ++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index e8ede0b5e3f0..80c23307fbfe 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -40,6 +41,8 @@ struct da8xx_ohci_hcd {
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
 	unsigned int reg_enabled;
+	struct gpio_desc *vbus_gpio;
+	struct gpio_desc *oc_gpio;
 };
 
 #define to_da8xx_ohci(hcd) (struct da8xx_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
@@ -86,12 +89,13 @@ static void ohci_da8xx_disable(struct usb_hcd *hcd)
 static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	struct device *dev = hcd->self.controller;
 	int ret;
 
-	if (hub && hub->set_power)
-		return hub->set_power(1, on);
+	if (da8xx_ohci->vbus_gpio) {
+		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, on);
+		return 0;
+	}
 
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
@@ -119,11 +123,9 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
-	if (hub && hub->get_power)
-		return hub->get_power(1);
+	if (da8xx_ohci->vbus_gpio)
+		return gpiod_get_value_cansleep(da8xx_ohci->vbus_gpio);
 
 	if (da8xx_ohci->vbus_reg)
 		return regulator_is_enabled(da8xx_ohci->vbus_reg);
@@ -134,13 +136,11 @@ static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	unsigned int flags;
 	int ret;
 
-	if (hub && hub->get_oci)
-		return hub->get_oci(1);
+	if (da8xx_ohci->oc_gpio)
+		return gpiod_get_value_cansleep(da8xx_ohci->oc_gpio);
 
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
@@ -158,10 +158,8 @@ static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
-	if (hub && hub->set_power)
+	if (da8xx_ohci->vbus_gpio)
 		return 1;
 
 	if (da8xx_ohci->vbus_reg)
@@ -173,10 +171,8 @@ static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 static int ohci_da8xx_has_oci(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
-	if (hub && hub->get_oci)
+	if (da8xx_ohci->oc_gpio)
 		return 1;
 
 	if (da8xx_ohci->vbus_reg)
@@ -196,19 +192,6 @@ static int ohci_da8xx_has_potpgt(struct usb_hcd *hcd)
 	return 0;
 }
 
-/*
- * Handle the port over-current indicator change.
- */
-static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
-				    unsigned port)
-{
-	ocic_mask |= 1 << port;
-
-	/* Once over-current is detected, the port needs to be powered down */
-	if (hub->get_oci(port) > 0)
-		hub->set_power(port, 0);
-}
-
 static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 				unsigned long event, void *data)
 {
@@ -223,16 +206,23 @@ static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 	return 0;
 }
 
+static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
+{
+	struct da8xx_ohci_hcd *da8xx_ohci = data;
+
+	if (gpiod_get_value(da8xx_ohci->oc_gpio))
+		gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
+
+	return IRQ_HANDLED;
+}
+
 static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	int ret = 0;
 
-	if (hub && hub->ocic_notify) {
-		ret = hub->ocic_notify(ohci_da8xx_ocic_handler);
-	} else if (da8xx_ohci->vbus_reg) {
+	if (!da8xx_ohci->oc_gpio && da8xx_ohci->vbus_reg) {
 		da8xx_ohci->nb.notifier_call = ohci_da8xx_regulator_event;
 		ret = devm_regulator_register_notifier(da8xx_ohci->vbus_reg,
 						&da8xx_ohci->nb);
@@ -244,15 +234,6 @@ static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 	return ret;
 }
 
-static void ohci_da8xx_unregister_notify(struct usb_hcd *hcd)
-{
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->ocic_notify)
-		hub->ocic_notify(NULL);
-}
-
 static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
@@ -403,9 +384,9 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci;
 	struct device *dev = &pdev->dev;
+	int error, hcd_irq, oc_irq;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
-	int error, irq;
 
 	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, dev, dev_name(dev));
 	if (!hcd)
@@ -443,6 +424,27 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		}
 	}
 
+	da8xx_ohci->vbus_gpio = devm_gpiod_get_optional(dev, "vbus",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(da8xx_ohci->vbus_gpio))
+		goto err;
+
+	da8xx_ohci->oc_gpio = devm_gpiod_get_optional(dev, "oc", GPIOD_IN);
+	if (IS_ERR(da8xx_ohci->oc_gpio))
+		goto err;
+
+	if (da8xx_ohci->oc_gpio) {
+		oc_irq = gpiod_to_irq(da8xx_ohci->oc_gpio);
+		if (oc_irq < 0)
+			goto err;
+
+		error = devm_request_irq(dev, oc_irq, ohci_da8xx_oc_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"OHCI over-current indicator", da8xx_ohci);
+		if (error)
+			goto err;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(hcd->regs)) {
@@ -452,13 +454,13 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	hcd->rsrc_start = mem->start;
 	hcd->rsrc_len = resource_size(mem);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
+	hcd_irq = platform_get_irq(pdev, 0);
+	if (hcd_irq < 0) {
 		error = -ENODEV;
 		goto err;
 	}
 
-	error = usb_add_hcd(hcd, irq, 0);
+	error = usb_add_hcd(hcd, hcd_irq, 0);
 	if (error)
 		goto err;
 
@@ -481,7 +483,6 @@ static int ohci_da8xx_remove(struct platform_device *pdev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 
-	ohci_da8xx_unregister_notify(hcd);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
