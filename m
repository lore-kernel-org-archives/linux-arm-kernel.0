Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD9C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF872083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RLO/XJJM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vAP2BenT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF872083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FaMXeJHq7wApVtKpit2YXatF4nUeF+aUX8DRj8uQP9U=; b=RLO/XJJMHQLqJR
	5XY516UG8nj1ivIGuPikbANI6lSs/qE7hfMBjxR3ms+XD+illNcKnRm6XcRe6tmrrHG7htSfYaIj5
	tr745EVajUGOvTmULcOgNzVcagXxjiEvqSdQ9ZNqxLjVnR2mu1bUs1dtGY8Kdb49ofQTSPITPOjkB
	A7Kjg1YtAt0vyDQfhkHEkjagjYndZ8S+ubepnAfZFjp/bub7yoq+Rs6u2OcMHHl0v/D8dGE87+F9y
	gTHsS9+iODiji+VqoO0mjvJbTb+t0OZFDu6OwqWepRfkJbeNKD6BK6mqpTFZ8i6hRAaxT+iAeRiKP
	27W7vhEldPfbLeUZ30+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxwM-0008TU-KD; Tue, 05 Feb 2019 10:26:54 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxvS-0007Lj-La
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:26:02 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so12169804wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nLOzCbKWD80mlDEOSPNdWjjwiH1Ipwg9Oy8HlbpRsTU=;
 b=vAP2BenTdlZm0orJT9mvE5UCY8UMTRZWEauOeamJFuOW/jGj8fV0mV5qFzFJewGLbd
 JFvmy55LgY64QP96lKrxdgpMGk5FKq/S/1k87WiFOUlqOhikHS5rlh1d0xd85+lVSiN2
 6XbSQGqrFt6QE09vtEoqi1amlddpYzcJUvbAeWNelZlMH950txMHvgmu5vuzZ9/7mTFU
 QuA8YIzd8l+XEnXIuky08t/ZDyZXHQ7xC5ht7UH+YjMNQsBmBqh/pOiEqzpnY9ME/1by
 vwWnckJ7Qpl80NXD+g/CAHh/uTr8xhTMeCKO4AOrmo0L33jELUp2X54CUdkWM1zyOkqA
 9+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nLOzCbKWD80mlDEOSPNdWjjwiH1Ipwg9Oy8HlbpRsTU=;
 b=QtbVI5Dw2cX+jAkkVCNJrnXHOeLHsZqMfr+3aR9V2EiFkKbTXAG+5DbTUFRCSQZTml
 ntsNWQ6GaSNtVtjpMHP6pqvy1TbseM+P2SrssixYk1HO1KIGV5V0JF+C7zgQiXF0ua7f
 DVLZjRCFqOwpPf85hvjfRmE1q6pZ48eHgKmH7rSq3IeVSJHY9zclKMjRY6P+sK/2mdZp
 pBj/X4BMIDLQBLUISmnxqINegsPbTgPenO1nYR+5k+eEeRYY5PdaaLcTa3uiuXnXWpKO
 lqWpGwvUkupEcDuifR4N3k2X/x1Jvev/V/w75t2LrHR9l0l6sdskwxsCfIaMHN2Npgq5
 BH1g==
X-Gm-Message-State: AHQUAuY2N48gFaQJJ7g5kovVhf/LC/+uH4sJFFQevhI+bvdeJewtzjCD
 hQttcjgF26bgPFnB/WYaDaA8uw==
X-Google-Smtp-Source: AHgI3IaAs81CZZtfteh3BPxtLJAaLsBYbc/ux/lHNRGTT8q5dKsCcDlFmHXEK/CTWJ+bO9cLbgRPNg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr3088898wmf.3.1549362355078; 
 Tue, 05 Feb 2019 02:25:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:25:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/8] ARM: davinci: da830-evm: use gpio lookup entries for usb
 gpios
Date: Tue,  5 Feb 2019 11:25:42 +0100
Message-Id: <20190205102546.29457-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022559_180392_B1EED476 
X-CRM114-Status: GOOD (  12.31  )
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
