Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D68C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:24:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D260E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izBddJv6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQdRNqvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D260E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1jrBWMohLSNg5FH55WNyzz1T2TU6FRHKiwpRtcY/abk=; b=izBddJv6SnY4Fl
	tPzNW07AnLXW6S/roFIoKm6FnCq7vx7bJqAXF5ajXiWubrIuZJwl4e5Aw3DY9HD9At2OaG0dvhiZ+
	z092fejyeMsr3G/j+OcOiU2Efskf0s1GHuZlaJV3PU6thn7QBlMYYXHTH7fvsrAYjWqpVzTu3+gF8
	pbWJr9A7++lq3IMwvXlPr+zk42yoEV75cgOkd4X2Nw7N5chi5cPr1JHMGRpiCYH1O1va9kShcSEhI
	Iw0Ux59knfYjLze6PbZ84miJb9BH/Rv3+7MM3dtS/EoHLxuqeY7Q7LPUZFh3Crdm73RwjPdt+xN+l
	f6C49mWITyOtUU9S+l+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVl1b-0004dK-BG; Sat, 08 Dec 2018 22:24:39 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVl0L-0003Lu-2m
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:23:24 +0000
Received: by mail-lj1-x241.google.com with SMTP id e5-v6so6492346lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PTt6n+5fqckoesxLGFZS0o7UEgZWgOK7xniDvS3NX/o=;
 b=aQdRNqvqZGGFBByZNfapUXWawYV4ddqVzbrwA+I4tOa8DcHwpo0LPJYD4kouQdGfdA
 BSHBv2i4qFufNAtOxIxWparXBTyr2qTpzrfCkot8uesYx+XQ7xkelfzDUuyPRjmEPXz4
 epdmy9DEkObjrcsWVOtUGOx/NohtV03E9BcQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PTt6n+5fqckoesxLGFZS0o7UEgZWgOK7xniDvS3NX/o=;
 b=bDSDuozGpS18UTznu6bNeu8WpUNTSZB+zKwv2ogB9v0hIgOa6KCugAamL20wleIRtM
 ZtarMJjaw4EqYgcB07tXADXqS1T7Uraa6RpfFLYPVib3VV5gTHOcIjw5jQtHWwLJTkEV
 2r8MmusOLkDCZJZNI7xiW2P4dWDRRCw9EM8H36n/LQ2Thu5bKWLhUANDtt3CJqC87mfv
 5dN5RnpcNdbhBia8NqsZZdYGOB7t8i7+3ZP9nZJtVwYdD8uiIEP/jQboc0jabmE1E4io
 P06+Sb3wdn/A8zKWONlqu9+RojMYAcY94B75HmFIZxZAvhvvcYJygZWx9erYMxQ0MswZ
 KNCg==
X-Gm-Message-State: AA+aEWY714B0JIl3E6fnOMCfJXgdEjxlRYvlm6XVfBzzVG2a2zIPx8O2
 t4EVSrK6EEkDnPawevmaDy+h8q6sD3DL5Q==
X-Google-Smtp-Source: AFSGD/VKNLRRXN5Lm1P6uY8Mkii00E48ywEcSL70Z2jEeiJfM9dMngAwj4kzOqvLsB+M3jnflxFJzQ==
X-Received: by 2002:a2e:2019:: with SMTP id
 g25-v6mr3981900ljg.20.1544307797694; 
 Sat, 08 Dec 2018 14:23:17 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id b69sm1310884lfl.28.2018.12.08.14.23.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 14:23:16 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 5/5] ARM: dts: Bump Gemini platforms to use 100ms debounce
Date: Sat,  8 Dec 2018 23:23:01 +0100
Message-Id: <20181208222301.5303-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208222301.5303-1-linus.walleij@linaro.org>
References: <20181208222301.5303-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_142321_225681_8812CE16 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
 LEDE Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The 50ms debounce is too low and give ghost bounces on some
platforms. Bump it to 100ms to make it stable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 4 ++--
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts      | 4 ++--
 arch/arm/boot/dts/gemini-rut1xx.dts        | 2 +-
 arch/arm/boot/dts/gemini-sq201.dts         | 2 +-
 arch/arm/boot/dts/gemini-wbd111.dts        | 2 +-
 arch/arm/boot/dts/gemini-wbd222.dts        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 5e8e96458903..cc0c3cf89eaa 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -28,7 +28,7 @@
 		compatible = "gpio-keys";
 
 		button-esc {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_ESC>;
 			label = "reset";
@@ -36,7 +36,7 @@
 			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
 		};
 		button-eject {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_EJECTCD>;
 			label = "unmount";
diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index d1329322b968..b12504e10f0b 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -34,7 +34,7 @@
 		compatible = "gpio-keys";
 
 		button-esc {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_ESC>;
 			label = "reset";
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 53b65ebe8454..f4535d635f3b 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -28,7 +28,7 @@
 		compatible = "gpio-keys";
 
 		button-setup {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "Backup button";
@@ -36,7 +36,7 @@
 			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 		};
 		button-restart {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_RESTART>;
 			label = "Softreset button";
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index b2354c215a84..9611ddf06792 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -28,7 +28,7 @@
 		compatible = "gpio-keys";
 
 		button-setup {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "Reset to defaults";
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index ecbc27d93b2d..239dfacaae4d 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -28,7 +28,7 @@
 		compatible = "gpio-keys";
 
 		button-setup {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "factory reset";
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index 6831d2aed17a..3a2761dd460f 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -29,7 +29,7 @@
 		compatible = "gpio-keys";
 
 		button-setup {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "reset";
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index ed38d48ef5f6..52b4dbc0c072 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -28,7 +28,7 @@
 		compatible = "gpio-keys";
 
 		button-setup {
-			debounce-interval = <50>;
+			debounce-interval = <100>;
 			wakeup-source;
 			linux,code = <KEY_SETUP>;
 			label = "reset";
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
