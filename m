Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:53:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB47220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IbBydEUe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rjV46Cuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB47220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K2m3qO40FvyfCRXCAd67k/al+c7oJWXobPsezsxSZeU=; b=IbBydEUeE/H1fP
	LPs1zJ9P+hYC+p87oROc/3pRTUnO4hgRTVn56/tgyu/Ak+FLSUxbsz5EPYlPK4GK17IBzD2mi167N
	qyU3jsQtEF2z3l2rydnJ5dbpsrc9Q1oTPtF8fNf/euQBLHCSvovBuv54g49VzGj9OS54ggZyg6LP+
	/z3nl7NGUuu0S9wU8L+BUnzNC2+8Q3tNyaZpXGG8CV11QZCl1s2rPWPOzvB77OYYNCFI0eCE1lks9
	Sc4xEGt9QKoDysghtPuY6mMfZPF9uklhQ9Fi5ZbUpPNnMlLWYTmABe4jcrZjP0lTS6r26YiwZUKmb
	HVop+3b00ncrM1/gFIEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW58d-0007op-AS; Sun, 09 Dec 2018 19:53:15 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW56l-00064K-G8; Sun, 09 Dec 2018 19:51:23 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so8402655wrs.10;
 Sun, 09 Dec 2018 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=73UkkgA13PS5wgqSSg53HYdLX82FskY2VGqT47R/Ls8=;
 b=rjV46CuohTjDWjmOlylN0PPJ4QoyI0TphLd0mYyVgxiOk9CkdZiCuDJ9WkXfmZhcA0
 dgiI0INUsNYU5oxmi25WlwEXpLerXMXzJpqMIbhUK+RhP/1K5vkw7Navj7iUYJgB3Npy
 EkQso7Xf5kogTb0IPOI2m4e8uylsv/UQ1i9LDFCT/haTRJedKi9CBA+A++IqAy5b4B74
 hrXDcqu5GLugag4xXcNfO3fT/voKaCpH/m0OuuFy2fANcMOsGxuVMHeE0lZAb7Xc3Et8
 Lb2FY3DF4+FfRA6lis0ek4RncEVv8tECgzwuUmtfM0wXGhUryeKF9UGByRvp0ZDN1tYv
 QfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=73UkkgA13PS5wgqSSg53HYdLX82FskY2VGqT47R/Ls8=;
 b=Yn6UuWUv5+op/5G1G74GPEzl92NRCf/dOU6QRg4rPMYB17akE3t4T3WElRB5+9te0K
 SSmJBkk0fRLIGxKeW/towQj61ouSJhgxt9aEyDs3v93jjcwIc/72X4nu1KoDZUICGYqk
 WXMEf/gNhW5/FrzvJwtV3TRje247ZFTrU/VRvabCqLpZX8uBBlO+F7AaKVIO5xKN7aYD
 FRGBYVJ3rJExOSSkP3HB2A9OxB6DVWx00hxh7gQ2hR0kkbVLLos26fFm3nsIzXokgu3+
 VHY/TiDz6qGvKt3gRcbokpCAdb3upwjIGKk3YWR6qaJf50bufWlYFE17zp8jMCEfCX5t
 WXIg==
X-Gm-Message-State: AA+aEWaEYjRqRepXXixLOwY0p9InjbEZHzAFmjR/xhKz4sVMjgjKl+e/
 gyc59QgOfXrZwHi07zO9ufA70oAn
X-Google-Smtp-Source: AFSGD/WpDg8nYCDo+bcLfGzSW/+YQAqSKzR/ZupWv1uc5LyOCMp9VZZPsHKhN5JdEYkipi3BwpSeug==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr154720wrw.311.1544385067544; 
 Sun, 09 Dec 2018 11:51:07 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 11:51:07 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
 linus.walleij@linaro.org
Subject: [PATCH 5/6] pinctrl: meson: meson8: add the missing GPIO_GROUPs for
 BOOT and CARD
Date: Sun,  9 Dec 2018 20:50:54 +0100
Message-Id: <20181209195055.26813-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_115119_807905_13DD2E54 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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

Add the BOOT and CARD pins as GROUP_GROUPs as well so they can be
configured in devicetree using groups = BOOTx or groups = CARDx. This
makes the behavior consistent with other pins inside the same driver as
well as with the BOOT and CARD pins of the GXBB and GXL pinctrl drivers.

Fixes: 6ac730951104a4 ("pinctrl: add driver for Amlogic Meson SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 5f4935a81295..785e29e74a56 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -506,6 +506,32 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 	GPIO_GROUP(GPIOZ_12),
 	GPIO_GROUP(GPIOZ_13),
 	GPIO_GROUP(GPIOZ_14),
+	GPIO_GROUP(CARD_0),
+	GPIO_GROUP(CARD_1),
+	GPIO_GROUP(CARD_2),
+	GPIO_GROUP(CARD_3),
+	GPIO_GROUP(CARD_4),
+	GPIO_GROUP(CARD_5),
+	GPIO_GROUP(CARD_6),
+	GPIO_GROUP(BOOT_0),
+	GPIO_GROUP(BOOT_1),
+	GPIO_GROUP(BOOT_2),
+	GPIO_GROUP(BOOT_3),
+	GPIO_GROUP(BOOT_4),
+	GPIO_GROUP(BOOT_5),
+	GPIO_GROUP(BOOT_6),
+	GPIO_GROUP(BOOT_7),
+	GPIO_GROUP(BOOT_8),
+	GPIO_GROUP(BOOT_9),
+	GPIO_GROUP(BOOT_10),
+	GPIO_GROUP(BOOT_11),
+	GPIO_GROUP(BOOT_12),
+	GPIO_GROUP(BOOT_13),
+	GPIO_GROUP(BOOT_14),
+	GPIO_GROUP(BOOT_15),
+	GPIO_GROUP(BOOT_16),
+	GPIO_GROUP(BOOT_17),
+	GPIO_GROUP(BOOT_18),
 
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
