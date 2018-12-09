Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C160C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387632082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJqx/JTU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vV8BDERd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387632082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BwMW0nH51L30eCtLrqWrAnlnBYaWoSZ3pT0j+2tOFzU=; b=IJqx/JTUiocNvh
	v81fqOoU5/yI1uz9MpmoHXtfSE+TatSZpJRWK7MpVU1uThoUiaI1/mol1Ulh5donIozwYPquHJcwr
	G6+iNjbNDvSrplEXvi/jUFKKG/oc90gH1WYCFMSiqNkZyE+zHjA81t8yqEo1ZrrVWU8h9UH7IwAgr
	I52T+2Ev9D7iulCFJTPXZUnwI8VHtGEoxGovX02MPlSpKKFb9z4rQCxA+AyEyDfsFqIJz8woo46zk
	7o9Tjs6Cu04ALb21k6d53DkxLzzvh8ZyP8NBPlA+5Yy+tftnridi+Gq0Yhb7scQAcRgjHD4qwNfLT
	Xk46eQfrYVa4f1IPhV/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW57j-00073M-NF; Sun, 09 Dec 2018 19:52:19 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW56i-00064A-On; Sun, 09 Dec 2018 19:51:18 +0000
Received: by mail-wr1-x441.google.com with SMTP id j10so8432018wru.4;
 Sun, 09 Dec 2018 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tNuetO7o6p2z/PS/M/PqymLq8KTy/5E9grHzBPHloU4=;
 b=vV8BDERd+zfS708DoZc7iQzaGuZMaNqMiwh/Gx5nk0w/MreETlLUcucH7ZASrjrjE3
 ukuMJCmz43mUomVPmsv4rDQo81MSXoM4kSxy4ulxFfFnUQa40yjGscOK855GUiZzKlj9
 k3J0vlMf2rNqIRWd36cxGTu6nzrWYdOlncs7CThp0Z9DeoAEe5LXA0vREbk8XFGiV5+F
 QjSNgtowMlh0gIdJBjY59qq9Bs5f4pxQ0ZJj6WykgvQ6Fu140zH2VaGgzUjH4s7RWN2L
 5/K48vWl1xZvvFtRTS2yviobIcy4kj9LbUXR+YL2mRsPvBaaYMpYxedvVaeCSsjJy5G9
 DoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tNuetO7o6p2z/PS/M/PqymLq8KTy/5E9grHzBPHloU4=;
 b=EaMx7qiw35AQoHJD5bhP+JwFbiy8O5EaKOkosWvFJqE2C/H7aA/vws4jCZddoTQU1m
 +JnqThTe4y6MV0nlQNz6kIScfLaYw/duKE9VpRDrrdBaBC0kLEKb90ufYL1HoxUPHub5
 tmeBGjX5azFuvc17BSgxjpdRQ/zf9I62i59gB2ts48jRkym8nrCYZlFNI7du/SiKqZEr
 71dOWeu/V2kYDQHfPVMNlC+yfORpO2tQ5Xn4ntvRH2UOzKg0m+F/V2PlHn9o0WHemmMt
 QPD4m9nc6czxPHDtN/CX1nPq0k2Zzud5Ta7Xdnb3W80RrRHoprAcA8amZDzkMBzexnjp
 CPrw==
X-Gm-Message-State: AA+aEWbG+EGCGAz20N8yiolGvutlATfKQjtT7Y3aquhjFhNVBc/amEyx
 zcn9nrXdQ8YxdpxuauLZbO33XcCY
X-Google-Smtp-Source: AFSGD/U1KCYgZTtKIpkMT4NcDbUXMVhp2mp8fR5eDSRBzZ+pMl4j7G8EICcN4xTaxjKunk6dekpH9w==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr7640014wru.14.1544385064732;
 Sun, 09 Dec 2018 11:51:04 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 11:51:04 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
 linus.walleij@linaro.org
Subject: [PATCH 2/6] pinctrl: meson: meson8b: fix the GPIO function for the
 GPIOAO pins
Date: Sun,  9 Dec 2018 20:50:51 +0100
Message-Id: <20181209195055.26813-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_115116_831745_4091539B 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: carlo@caione.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GPIOAO pins (as well as the two exotic GPIO_BSD_EN and GPIO_TEST_N)
only belong to the pin controller in the AO domain. With the current
definition these pins cannot be referred to in .dts files as group
(which is possible on GXBB and GXL for example).

Add a separate "gpio_aobus" function to fix the mapping between the pin
controller and the GPIO pins in the AO domain. This is similar to how
the GXBB and GXL drivers implement this functionality.

Fixes: 9dab1868ec0db4 ("pinctrl: amlogic: Make driver independent from two-domain configuration")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 647ad15d5c3c..91cffc051055 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -646,16 +646,18 @@ static const char * const gpio_groups[] = {
 	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
 	"BOOT_15", "BOOT_16", "BOOT_17", "BOOT_18",
 
-	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
-	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
-	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
-	"GPIOAO_12", "GPIOAO_13", "GPIO_BSD_EN", "GPIO_TEST_N",
-
 	"DIF_0_P", "DIF_0_N", "DIF_1_P", "DIF_1_N",
 	"DIF_2_P", "DIF_2_N", "DIF_3_P", "DIF_3_N",
 	"DIF_4_P", "DIF_4_N"
 };
 
+static const char * const gpio_aobus_groups[] = {
+	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
+	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
+	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
+	"GPIOAO_12", "GPIOAO_13", "GPIO_BSD_EN", "GPIO_TEST_N"
+};
+
 static const char * const sd_a_groups[] = {
 	"sd_d0_a", "sd_d1_a", "sd_d2_a", "sd_d3_a", "sd_clk_a",
 	"sd_cmd_a"
@@ -871,6 +873,7 @@ static struct meson_pmx_func meson8b_cbus_functions[] = {
 };
 
 static struct meson_pmx_func meson8b_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(uart_ao_b),
 	FUNCTION(i2c_slave_ao),
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
