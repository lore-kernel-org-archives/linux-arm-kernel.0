Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6398CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F6F20854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e0miTNKR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JtAaer6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F6F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+0o2FVqWY37R/oR7rKGFMJeltWe04UpReJRQ/Rm3yyQ=; b=e0miTNKRH5wD1Z
	TaAPAnIgJJDJNS2KOzkMgBrW5EUr7GrfqGB5UwXUuZrraqLz2Q9aa8GR8zr1i2RrRGNQsfQcS5nMy
	j78KDfsgvNu7rU8KlcztXy1qKgIMDBKEg4Ef0vPwqaTnDoSftduaRTDK4BweO4FYTypk5X+nw3icF
	DX2b4mwnp/vog9MGUuEaK6ysY/x+nThN7VEqG9lNer14N2wbgBlIDPYXEPHX+/es6WiiR222EtXF7
	399YWwOEY1zfwWtmPYceJVecHffcXP2Fb+RUjZwbu+kWgt91rQ1rXJfN/0nnspOo/4M7xkD2Rmjtl
	J1zCcNA5pT0Dm25CwxVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJ1d-0000xZ-Fh; Sat, 12 Jan 2019 13:08:33 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJ09-0007qp-LD; Sat, 12 Jan 2019 13:07:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so18060169wrb.2;
 Sat, 12 Jan 2019 05:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tvVOVw+uJ/NYlsQPCS926U6L3ZI+t9KgIAVNoiuYO3Q=;
 b=JtAaer6HEDFiWaLeOIH0/8LzIGdzppw9B1QdfxxmSQ+wBGHNKH/f/y1U7psRoR6bmK
 4eDsTGHkMQUl7L+jj5FS1zUIN17JWkFvP5Tu3qsAiBxOLxub7GESVQ3IP6IfDajUrS93
 vGiC6vvItxDzIWQCsECTFO9+ANMhYiYUMREycCELnG2ywNblWMSsapKqRfJzwmQIOuE5
 HupJHVB1mqJsmP48ey8DNhyjmfX5AhKvaiwnlQd6QrkcXJI+2YI+/oZ1XXMcOOfFQHgz
 9PWPwJkjbR/Eu5ir4RX2X1q1AQh2PkWdr8Rh1VQN1sDYCrPXAWAaWgl73Qc84sDb8iED
 sRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvVOVw+uJ/NYlsQPCS926U6L3ZI+t9KgIAVNoiuYO3Q=;
 b=lLjPMKBKDdksfS1QzCnpuk2EL4daglv5/1PBwNvUjYXvnEy7oKFvh4zkGr651+QB46
 MNEWRSJ5GMUpyLgxMAubFGNlZtnxbZ+XkgbC69CLmmUjB302SC50SsjS+ZoKxBN8SZ3t
 QdrDrih6/gEAE8HVj3H+LA7c5r5+FwKv3Xku+eFGIW3AnfU6bfqh76QR4dJCwIz9w7JV
 /+IToFescFVcHbQFCEDaO4srgR3GI3mJKflNj3MAu9hPjXHz0ZMZ5ca4MiXYzDqmpZ+g
 b0cNiONI4FWpm8lE+DaefZfi2To0wwijZMzYX9pJ2xMGp+hQzLNozGJkSUrTujMQfh8a
 n2bw==
X-Gm-Message-State: AJcUukcQP/KD+DWH/5rX2B62WV53d2sZoqZIGPIES2ce/EURip9B603Y
 6MnJ1amM5UG2euOXqhOiZjIkDbNl
X-Google-Smtp-Source: ALg8bN4+1n9EJa6KyREXsijp+byyuXSYwf5FBrOHQvmPSU3bVcW8xDYR/SFpgYajq7HzAoZGO3lzcA==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr17100664wro.35.1547298418976; 
 Sat, 12 Jan 2019 05:06:58 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id o5sm37804630wmg.25.2019.01.12.05.06.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 05:06:58 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 4/6] ARM: dts: meson8b: ec100: add iio-hwmon for the chip
 temperature
Date: Sat, 12 Jan 2019 14:06:47 +0100
Message-Id: <20190112130649.23838-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
References: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_050702_028311_9387A366 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SAR ADC enabled channel 8 can be used to measure the chip temperature.
This can be made available to the hwmon subsystem by using iio-hwmon.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index d50fc2f60fa3..cba0006e2de0 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -64,6 +64,11 @@
 		timeout-ms = <20000>;
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
