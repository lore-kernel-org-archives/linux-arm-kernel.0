Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A1C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:38:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9D92084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jkr9nu/E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="beupPIha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9D92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rAYZct9vur1f61n27hUcQw3pd/HU2teNMgG/TRyvULQ=; b=jkr9nu/EpK28hO
	cponto/eF0qnHMS3RV2s2c1Q2z63xJTX0zAN3AxhXYmE35HNn5ppyc3oZismexMOj4L+Gznc8/U+A
	KT0tBOhj99ZeMvKN84r1CDdbyve1AhgOhnR8Mu9ZL3HpnNSD+ougd2usb/oDcI8IfgLKMMbkCIjZ3
	XRfxZIifQgOKgbWAR4gFmU/Mri7Fj22ZHwo+lb96aODZQQf1E8vWUQD8V4PhLLMRwu7qlM6T5E5mh
	aNzo1Mr11muy+cAmbtSXTfl9SW3BEi53up0/sOOoXAfbtr+0qQ0u4nUKMwNozHTND7If4fGFqCUzi
	BoLjb16/U/e5WMlgViPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8yq-0007iI-8a; Mon, 11 Feb 2019 10:38:28 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xc-0006Xw-2c
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:18 +0000
Received: by mail-wm1-x342.google.com with SMTP id t200so16366482wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 02:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D/VsXHRwtVGabkOsfPCt+jyBM76WQDq7lQ5hZjyQkII=;
 b=beupPIhapQPL6ylvBgwwVgVdOaYx4xjqH/zSbKbnraRrx9ToB0FO8C3cPLRquvThrk
 Hkgcm7hibv2CsXLLletboHoKCjIdzB5/jQO8afldqt6jk2AG1GDgW8Wk8oSnZjLL2J8O
 x3AGBoChuKPMFbzPU3V+HiLWBCU9Uy7t4fS6G9jNgTxuZmZ3VLoO/F6y7EiTdfLb20N8
 0/ukPHZgRw6gtQfR6PHXFw3DBo9couHG7pPggCvluJEFPEBeUeVdBe8butFW0OAb5AWV
 SrflHxSjn9wrbFDl711nvf8yhDjpDwlwE1ARLzcRsPkx7MxQ49wLojS7O6a0pR3vxdBV
 6p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D/VsXHRwtVGabkOsfPCt+jyBM76WQDq7lQ5hZjyQkII=;
 b=lt44HgB5Z90lK+kCwEdNanwIvlzAVuxZFwyQbYwEeWegdRtcB1pgKuj1t9Zy8Kb0TV
 n/+Lj6rzrEzgjO4xHgBTmEWxi/0AoD8t++cffEWJE4/GBwX5DrymJHpNNZKSicw7JMqL
 D40HFu3HrroQGIk0HgeGlmBjpUaG6zVEh94a4K81fkXNtQV6edyK9c0Q9clCIV29Tj0M
 AC6ubSa7ImTYWTvwF+QdwcnEIvAO3dyQHBtDsunfE31ccprxuUjFtaW6NDQyyOzdah0Q
 abBGairZzTtyi/VnYvhtlEwuPLhu2GNnSIlDiiP8oqSp7U+vtkeqXrKzesKrtTq4F2Qv
 LQhw==
X-Gm-Message-State: AHQUAubcmy+Ea92qpKVUPWfBr2geDvRcbcJAEPskAjdRffGVBIf3SzFJ
 UnHkcQMwHFhqLer4E+lLRcCgVg==
X-Google-Smtp-Source: AHgI3Ia4YHL7VkxiIK9g155puXWkq2+zX2KsPf97SnFlvhBgVTX8tMBPASRi53oK4Rsy8sIPMYtZaw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr6467462wmb.136.1549881429968; 
 Mon, 11 Feb 2019 02:37:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 02:37:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/8] ARM: davinci: omapl138-hawk: use gpio lookup entries
 for usb gpios
Date: Mon, 11 Feb 2019 11:36:57 +0100
Message-Id: <20190211103702.4277-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023713_176609_02334FF2 
X-CRM114-Status: GOOD (  13.42  )
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

Add lookup entries for the vbus and overcurrent gpios for omapl138-hawk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 94c4f126ef86..856c5707bae9 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -302,6 +302,14 @@ static const short da850_hawk_usb11_pins[] = {
 	-1
 };
 
+static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
+	.dev_id		= "ohci-da8xx",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, "vbus", 0),
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_OC_PIN, "oc", 0),
+	},
+};
+
 static int hawk_usb_set_power(unsigned port, int on)
 {
 	gpio_set_value(DA850_USB1_VBUS_PIN, on);
@@ -390,6 +398,8 @@ static __init void omapl138_hawk_usb_init(void)
 		goto usb11_setup_oc_fail;
 	}
 
+	gpiod_add_lookup_table(&hawk_usb_gpio_lookup);
+
 	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
 	if (ret) {
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
