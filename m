Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3AC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8712083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="el+ejj/2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pLsvjfhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8712083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XrG3wISALEHEYOkN+PrFFIA2JATu3qWNjsOPmj9Po6U=; b=el+ejj/2V1eAda
	GQsR7Qmh7i185IaPHHncPPCYPA1Xhi4aUGg3FF0A1uoT2ICgoeMRAfSN47zJaFNZDuwpMnxjcgyn3
	0bPyADb9Pk2tS3g/kRZ8MSDIOVwxqSz/OeokQK+0W3ossYVEp8u+Q6FZvV55pHpSLA1HwVlkPlO3I
	ijY+Y/UYDmoPVwadKTKsYvxqDC56nnfhwbyYWGc8ZYpgdJX+SHF3agsgNHoMxYZfBQIuLpYhSTq96
	VkZA5a4rAtP5Q5hvMwPGenyYL0q97obFCO7JppKP0CLqVCSUaCIAmVsc6/1W/gTQ3NF2cTQwdVrkZ
	qvj1Ej8And1540pXAVEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxw5-00089q-K5; Tue, 05 Feb 2019 10:26:37 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxvP-0007LG-Cw
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:25:56 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so2976588wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=27fRyiWZ0ynKcoArUhLUGUmMVLR0Snw6wALdX/O3/sY=;
 b=pLsvjfhe2Sy72wpGSTZbBewjTkEl0VspBE+T+E1szo5SGxX/EqNhmaSDxa3VaAqpk9
 iY2q1k1tvbYR0+FRyPooAuFg0g0K8hhpfw4nM1OANWTI71KI9xXCCo9nBal3lNDDgF6r
 HZ+sITobg8KTheefnAdWQ9ZdtUct49EseHmWHNHmeowUg7BwLt+ipykYCYmspsbo1zdk
 ka8b7/Jqgyf3vrDLet67yeyIvSmvtKHUr/CoKABmShP7IjSq0sVDZZIZOiB4z0kH9Oph
 GHUQgHiP8LWxqWEho9Y79r69uOk/mtB6Gu90H9poeiMKKX/ygxY+E+28X+OtMsZlosAI
 seUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=27fRyiWZ0ynKcoArUhLUGUmMVLR0Snw6wALdX/O3/sY=;
 b=abuAcRsC6bN3uFX5UPMeSpkaEr91idjUjbBsmVWif87BDaszs2ObXphoY1L3KBkSGu
 anjKed48cLnX4W0KnYqwajWkHyTyuGdlQoqhBoJizx6W3xokOnG4ZqS9sNla/NNn3yBQ
 cHhcMP3pgQCKp7vr4Yx4lDECz7PNdJGGqsb/P9RNQb+KVth6J1M7QP0plmxz0Bg42+rZ
 CWhRyupiWwGVyIFLq79zSusAqCTOuLyqIeKw5BAB9cutJRclhZQQ3AfgZsfte4WUmp/P
 qiuZ2ahy6OdJtSRXyDt+Q2zrm3VOnXIVSN8A8qOzzyRcNiI3VGxI2OrHilASnHuzJRfH
 qRYw==
X-Gm-Message-State: AHQUAubIqJiHtwBUe7U3kbpH775/1YoDap+31DChWIzbLMKkVhbh5Qho
 t0lvCyQnSr+arfW5hJX4mqbuOA==
X-Google-Smtp-Source: AHgI3Ib//l3NPzOtNoGwt14htmcBcVhmPw9WtBzSknykhyhvUWdPbFvZ/ophHf3xBiYQnoYsUR1X9w==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr3022054wma.19.1549362354011;
 Tue, 05 Feb 2019 02:25:54 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:25:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/8] ARM: davinci: omapl138-hawk: use gpio lookup entries for
 usb gpios
Date: Tue,  5 Feb 2019 11:25:41 +0100
Message-Id: <20190205102546.29457-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022555_433821_1C7B2D4D 
X-CRM114-Status: GOOD (  12.95  )
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
