Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E609C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:38:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3082084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pq3UQXzT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oWmZOODH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3082084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AjtmYJBj/egwa8bAuPkiEAaJ7MyGc9szYv+Md295QMg=; b=Pq3UQXzTqKMuma
	OKBCM6GUYSDhkFSz3vi2YFqyifU11LpdgAJsE5B1IhEHV6fOWiIeQJrGBKCyS0S1LbwVugUsAYJdw
	PWu6352KPVNm5Xtr+1fiO66qTnxdRwofMuhbMJzccZTpxo1DSUwLEP7pw7LN+pH0OSUeMYlFCbNJh
	h+bWqRe1KTkQ1hi6jOYF8TV7RSXhWHkBz3rVxy04mKvaqTcMjcavVWuZQ8oL7T6nC76F9bWi5jI+R
	U4BtOZEqlP3h0DxNH0QOD2liAqgnmdeDLwYvyCVpmLjtBoI0dR9dIVbtcH2xEqmN5cyQofoFBqc/l
	np9UNWvedBfDz6wATeQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8ya-0007UX-Le; Mon, 11 Feb 2019 10:38:12 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xc-0006ZI-NL
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:18 +0000
Received: by mail-wm1-x341.google.com with SMTP id f16so16319964wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDfzI32lULSZi0KPO52EnMBMtQh72KGGsTTNyrojGSQ=;
 b=oWmZOODHEAixm/1e2wgdfOLsfIc9IDHSjpG1BwW0YuPn2nUl/ttK9oOzgpCPJtzS6N
 DuKSO+zvN/upV89PdkHuedTqjSJX/AJKkafNhPrmdRpOmO1jF1kEMkGhz7k/bYyb1scx
 g340TQM7jblbGE5aPe6knXbPMrpCnYwGDzun+BWgwjNA3JuIxo/+6RTTA6jHztqlUFK7
 yOZs0jo0M6VVIN7EEHP5uELpGpDhFAa895/GyEqymT8PaIXDmd0eIwTOX+ob0Ie2F0/U
 3ZoZDJJrWQ9OKcRWjUijSWeduUbFFA3mdqWdutGDLfO5hlNdlHuRsyh9ebelNVyDgA3o
 PcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mDfzI32lULSZi0KPO52EnMBMtQh72KGGsTTNyrojGSQ=;
 b=qc78d0010Q70hZC+O0/z9cb2tVe2E5Z7h5gWcyf2ZsuR4eKQSpbEkPBJswWWd4nsiZ
 +lvD9hICSK1Snz2gMINF52dgA/kCVFFLukl5Z2RFTwqIy5iWMM6/Znh7ppPdsKa+hA1+
 Ku+skSOK+Z3Aut1u6eHFsHoO4tiJGKDKWWh9C1zvDzRBaxvnEtaUaVKY2+yhQ+odcBkf
 8Q/HrwE36vR7kk3OcUAiTbQl2KV2T/OyBpQW7itexNjKuXpj8ypmUcKbR9utaNbf4OT9
 KhXPGlcFqjVL6l6YUkYTT5TALTM1Wc6RFj0aB8Tn6O5tarpJvCQBVyhD1dVK4rLT9Efq
 2g1Q==
X-Gm-Message-State: AHQUAuYoxZRn9u+Jr7yKsaOcWJh9xEYLBzma7cs+OiV1hvPA/2EtZk+E
 HsADYdcnJAn2gYL8j8r75P2cXw==
X-Google-Smtp-Source: AHgI3IYXhpG/oxXOdIneaSd3s3Pky+0wz1hkzYaJnd5e3gipZIWhNMei/K1g/PlCdRxJnupjWMrGxg==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr17674777wru.21.1549881431259; 
 Mon, 11 Feb 2019 02:37:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/8] ARM: davinci: da830-evm: use gpio lookup entries for
 usb gpios
Date: Mon, 11 Feb 2019 11:36:58 +0100
Message-Id: <20190211103702.4277-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023713_690851_EF43A6A1 
X-CRM114-Status: GOOD (  12.78  )
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

Add lookup entries for vbus and overcurrent gpios for da830-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-da830-evm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c4da635ee4ce..0712a37153a8 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -54,6 +54,14 @@ static const short da830_evm_usb11_pins[] = {
 
 static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
 
+static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
+	.dev_id		= "ohci-da8xx",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_OVC, "oc", 0),
+	},
+};
+
 static int da830_evm_usb_set_power(unsigned port, int on)
 {
 	gpio_set_value(ON_BD_USB_DRV, on);
@@ -158,6 +166,8 @@ static __init void da830_evm_usb_init(void)
 	}
 	gpio_direction_input(ON_BD_USB_OVC);
 
+	gpiod_add_lookup_table(&da830_evm_usb_gpio_lookup);
+
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
