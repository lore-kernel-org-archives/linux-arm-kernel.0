Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF24C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1B32086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M70ApUSG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8VQohhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1B32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ho5B0GFQeTUkiRJOLhE0Nkoe83nYsSYK+WJsXe8VDNY=; b=M70ApUSGltlI+u
	REQYBQHO0/jeYUdP4WY0LX8xL9zXjDB9KeRVY7SMvcM0s0hOyV5Y8SY59off+YEhy8CjDIWzi8deN
	3lcy3AjGF/OWUQI93jjF7BsNxMe7d76xGc34ljmSS8LbW52IvcP8TIFBgEaHSZ9DIAHGjsaN4OQdr
	kbsGCtUhYJsV+jNkj9VFZaMT5bWADGmnEfexIAZuFc9wo/fxS3AAIkiPI5nmljQJU/nyhtmu1gCss
	v7LUsZ9h3ZtAdEWLG9eXYZqShE+rN7/lLELyYm2sfjrvZymHu0Gj6Ggv5g2wgAuJNjnmaAscRKGBo
	WR/UNIURpPHk1IVCiQTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXYo-0000ho-Js; Fri, 18 Jan 2019 17:04:02 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXd-00089A-9h
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:02:53 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so6339792pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4xR1KYQugEMkmMq57G98vJgznMGv5+b9o//ihdpDFFk=;
 b=W8VQohhRHylK8qIeIMPsCgeUBkdi246JIFWArzeRK06r73GzduMz7oIZ78WICDUblz
 e45HrHe+vYK3sW75OWoVPmedz3/n6+Vpn8v4nZqU/sFVuI9JL55JT8KKHjzFcrV7blzz
 YmbjdI80sMz7GdsWqSWFtE+FtZvRuFkoXVJQuWqsdq21KX7zRMEi0Jlkdfi5KSbiAdZ5
 nhSrAzga7K/HUkudnngpKnnNIBDANg9hpGGlO/r1GVzvFyG22T0RcaEjjwgr3xLrU9U0
 J8YwgwoqIc8UnCSrfo86OKT6jg1XujU6BZrDQxu3AbIVQ4yw2KHUcRqOokW3vlXJfwnJ
 LJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4xR1KYQugEMkmMq57G98vJgznMGv5+b9o//ihdpDFFk=;
 b=I0juERu9Itq6lI9wdDkm/WUtXR4tQMPsbMiIG2jrtgOPAo0cvMWZ7c5BvgsKuij3Oq
 H7DOFlxfIdM0F0R0F3W4lL+GK/cEMr7x97Ew0SjT0D2QaiLSk4VHTA6l7YC7S3urLt4e
 OGPlu3B7+DJpItPTGjmpSIDWGw98/UfV1/8B8uenI5PGbD0nfWQlHwEJHas7d+Ri0VuG
 V3Uy5Y4zQG1QkZsaZb2WB99hj67pbh/bzJXmYbCni+B0hZY4HPWwpcP9Q5Bg1jO66P9J
 LCe8UIibdYM4Zeyk2LPW3h67D/Tt2JwbSPORYkBqo32sIQuXhkKESEUqae33LN5C8V1r
 dZMQ==
X-Gm-Message-State: AJcUukfQQbruVVKTd3LIpCP5TLX6uSEZCN7pePwgQyykEpGAMsSHFy3i
 IOUdouBszhifFLBGcPhNqjs=
X-Google-Smtp-Source: ALg8bN7eKG9Zfd/C08iT/TSsDGBMH2LRelSemvSqKMOphpjky6CTf4WpERgIJdacBkOyODA2ZJbrBQ==
X-Received: by 2002:a62:3888:: with SMTP id
 f130mr19784070pfa.132.1547830968387; 
 Fri, 18 Jan 2019 09:02:48 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:47 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: hci_h5: Add support for binding RTL8723BS with
 device tree
Date: Fri, 18 Jan 2019 09:02:28 -0800
Message-Id: <20190118170232.16142-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090249_673614_31037680 
X-CRM114-Status: GOOD (  12.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RTL8723BS is often used in ARM boards, so add ability to bind it
using device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7ead8c3d8657..44f848c02c63 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -26,6 +26,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -823,6 +824,11 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
+	} else {
+		h5->vnd = (const struct h5_vnd *)
+				of_device_get_match_data(&serdev->dev);
+		of_property_read_string(serdev->dev.of_node,
+					"firmware-postfix", &h5->id);
 	}
 
 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
@@ -1024,12 +1030,26 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
 };
 
+static struct h5_vnd rtl8723_of_vnd = {
+	.setup		= h5_btrtl_setup,
+	.open		= h5_btrtl_open,
+	.close		= h5_btrtl_close,
+};
+
+static const struct of_device_id h5_of_match[] = {
+	{ .compatible = "realtek,rtl8723bs-bt", .data = &rtl8723_of_vnd },
+	{ .compatible = "realtek,rtl8723cs-bt", .data = &rtl8723_of_vnd },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, h5_of_match);
+
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
 	.driver = {
 		.name = "hci_uart_h5",
 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
+		.of_match_table = of_match_ptr(h5_of_match),
 		.pm = &h5_serdev_pm_ops,
 	},
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
