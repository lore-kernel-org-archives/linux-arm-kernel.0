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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B328C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1EE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3Sfv5gW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pywTVcO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1EE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OxzhaiCm/AUAmJ5o3EWo5LwohWNrF4v2UavaM0gueW4=; b=q3Sfv5gWaONNd4
	nMMSVvqyNZjHaLM3E7shGgFsO6tZ5Y46PISqijAq+f5eEEZt+/b3kDo76Nq2jvBniYRihLZpEdxsA
	M1N8yYJ0ZVlgKoRykibhEWipsT79RIGjyHKPeQ5K9Y6e/spqK0JwM/bxTnki6y3+B/KkevVDIaTcZ
	TI82P3pjr/Ci2fb5mpwIgRfvOShMVMLWO4yJPwQ6zpSNKd5E9k5pbD0zZdnLNM9xEXjh+v7kFnC82
	SfmkfIW5Q6K6hR+yAVTg7DOb3ao42jDO4kpKyF4IJ3dD9xhylMRDgYVnWzrwTcOzQLuEALukV60pJ
	G9DuafqHqUKiLjGUx8Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXYH-0000G6-Fc; Fri, 18 Jan 2019 17:03:29 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXXb-00088F-7L
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:02:48 +0000
Received: by mail-pl1-x642.google.com with SMTP id u18so6607993plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jFEUu0iFvQYztS9g4BUdYLNIZwJ1NonHLyGxopxGJbE=;
 b=pywTVcO+DpWWCNXOmqzrHFpvyS521dw4vRXXY+31xsUMVGpIEiHHodTkbjeGeAkH0G
 ijzes2TXZ3uLqONaDqtQ5NJDGqfMmRtiOsAPToCvWtjn4XWMMm4gQID00FhBd3zgCAup
 dBXoawZQUh0QXLLLQ4yn2f92WW5WCswHPHT57RE56vkU4vCAaHfVS+8x5c/poaiaNANF
 7CBhFFyUyrgL7uHK6Gb80GCVPLdMAj641DlRCfd7i3t5mZ8rLXlWt3nnd/M8n2dNdpIP
 g60WsdqC10hB4b2Eog/1WMf6/GMRYeJz6yEX5dt+jqIavBDelbv+9wvf7e+Mwky9ShKo
 kUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jFEUu0iFvQYztS9g4BUdYLNIZwJ1NonHLyGxopxGJbE=;
 b=XrLan6nCCeTpn7YhS4yfbCg1um1GZwhfFgwyzdlcycxEXDnEwjwvelzeTc75vfBe+Y
 lUaGozDZm2wblokUFib+QiICWTOpXv13aXtl/99DsIC8xEOFMpDqBGYJ9t37EwauVGpa
 2xUUUP3G7r9ohNL3eZhdH+mY/bdcWTkaUGRUoJBxwkp9M65efTcYd18kU1zpCGo2nXBa
 NDXSl1EeyU5taMx3Zsf+Ae0X/HSaG+AZmCRoUSUApe/5nBh50gDnGNmIw4gdWdzVmet7
 UWcTFPjaX92Kya8BqJtjR+Vg/L3ZjTCAjbkOjskLR9lAYFqkc1Lc5FoF2cePlB3lDM24
 DOtg==
X-Gm-Message-State: AJcUukceKVArURVjzTQ4mizmqtag4C92mHjYbdjMk4eL7oO1Wd2SfmOa
 JWe8Yc3O1qM7+fjf45TEhzc=
X-Google-Smtp-Source: ALg8bN4RkK6wHVXxv15RcaeOc3A+ypBDn75Lj3dSW/DHGg4PYPYfnEC+ZoHcA89/Fdvj6Pa8xVbxfA==
X-Received: by 2002:a17:902:145:: with SMTP id
 63mr19834028plb.256.1547830966075; 
 Fri, 18 Jan 2019 09:02:46 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net.
 [216.71.193.140])
 by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:02:45 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: hci_h5: Add support for reset GPIO
Date: Fri, 18 Jan 2019 09:02:26 -0800
Message-Id: <20190118170232.16142-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090247_263116_BE10FB01 
X-CRM114-Status: GOOD (  12.87  )
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

Some boards (e.g. Pine64 and Pinebook) wire a GPIO to reset pin of
RTL8723BS

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 069d1c8fde73..7ead8c3d8657 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -107,6 +107,7 @@ struct h5 {
 	const struct h5_vnd *vnd;
 	const char *id;
 
+	struct gpio_desc *reset_gpio;
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *device_wake_gpio;
 };
@@ -833,6 +834,10 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
+	h5->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(h5->reset_gpio))
+		return PTR_ERR(h5->reset_gpio);
+
 	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
 
@@ -921,6 +926,9 @@ static void h5_btrtl_open(struct h5 *h5)
 
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
+	/* Take it out of reset */
+	gpiod_set_value_cansleep(h5->reset_gpio, 0);
+	msleep(100);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
 	msleep(500);
 }
@@ -928,6 +936,7 @@ static void h5_btrtl_open(struct h5 *h5)
 static void h5_btrtl_close(struct h5 *h5)
 {
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	gpiod_set_value_cansleep(h5->reset_gpio, 1);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
