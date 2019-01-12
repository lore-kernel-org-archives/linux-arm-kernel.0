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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:08:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B175420854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAyZ7Qu2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Bz418p6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=byMteWifRY6jkwHnhas/U+kwb0Oe6hM2OWgx7mTKD74=; b=UAyZ7Qu26NX1gi
	1yidi1DfYjgQZ2ADo4PGSkzfCeCPfqhTcFHmXeNVN7WrB+QEiIsC3lptFCKMCTVgvmGnpZix3NDYy
	P7H0ST926KNlLzQyP85nivss83HNslfpvbeZee2WfuJnw7XQsKoJHFnqOuL1fcFfQDCVFwG14slyi
	Wqo6gKS7l1afU+2k+tXMhsNhyhGYsbdgRhV51cy5cHAiSmlMA3WG/iU9jM/Vco2ANYsVSASG+LKwq
	XmLF/4NVsGRU2p5Kb2L+5XpaCIY7ikSSE4L/JgEAgFjpyLzXHsxXhCyOZQKg1pTzZoCb4Af7gSSiT
	k+IFPT5xdQv/iG2j0v8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJ1C-0000X1-4A; Sat, 12 Jan 2019 13:08:06 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJ0A-0007t2-V5; Sat, 12 Jan 2019 13:07:09 +0000
Received: by mail-wr1-x441.google.com with SMTP id j2so18107043wrw.1;
 Sat, 12 Jan 2019 05:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XHAyIX/toFB+9Ta7kl1IOzRCmFz0Mv8bQkAxb45dusY=;
 b=Bz418p6Jg7WkyPY9KXLFlpbta/vYzsjeaTLzeb6J4i3WYT0eNe4upQPNT76umfNpR1
 DeAwnjp/b67tJOm8qsyWeuOSB+wRAvq8hMqqdFMgMBqOLY+wTuroaHo6bqJP23efwvqB
 YrBmogdcpn4pBaM9741EWTCjAoL/oCbBkEayibpnO24u/zuENoBynQSAKnMwuJ/DAd4P
 yEGj70Yql5oO0TfqgXogAZhz/LHPaAUToMxymnV+t1dNwwIjtAjtdnJUxhGrvEBJ2MTO
 Go0u58mnT9mqosC94SQKFk1v2+srJjE9jM6OiaQhosnfZGdckZssIHVnp482ySp2mts8
 lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHAyIX/toFB+9Ta7kl1IOzRCmFz0Mv8bQkAxb45dusY=;
 b=XHSA6CLx4/25irroMxYnei3lI25yJdhPMCTyvGAqlfRC3+OsdT12aQ+Tt4bp1m67/K
 gu0YazGTSKAMvmfOecBAuiTOQM/ra+XFC+VU6EUil6Y5+aHwFxXTBw47+MxQQiqKTrsw
 rvamafgQzuSjpujC7jUWGqW2JMzpcAvqEwF6hrsLK9+Fjv0Sp3FL3GQr5bLUFnwOt8cD
 1Xbs8UCCum8FsMI0L0nK93dSvgfRNTJ8pla6PLLhijb05pSH3LtvxUd0zDnF34anh4z4
 2eKu571isNAdQWiumhm2cUQVUgHK0+Uoz3yf8Bj8sDsi0vZWbsnyfPbx/H1d8kSc+TJR
 ijOA==
X-Gm-Message-State: AJcUukc7ZqIxtwCNy6mXOd8UgGYgXActxDdidoOoHs1/KGC3ZmuvV6LY
 zhdk31NNYV7qV2SO6q570gq2cDLZ
X-Google-Smtp-Source: ALg8bN4K4jHCkjSlK5KlzD08vGrljo6QkafYS6/Nb8v4bi9vW6rau54FGsZu+5ommDt4JWW/SS5ouw==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr18780598wrn.185.1547298421224; 
 Sat, 12 Jan 2019 05:07:01 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id o5sm37804630wmg.25.2019.01.12.05.07.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 05:07:00 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 6/6] ARM: dts: meson8m2: mxiii-plus: add iio-hwmon for the
 chip temperature
Date: Sat, 12 Jan 2019 14:06:49 +0100
Message-Id: <20190112130649.23838-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
References: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_050703_476302_A165C757 
X-CRM114-Status: GOOD (  10.35  )
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
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index 6ac02beb5fa7..18528101376b 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -44,6 +44,11 @@
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&saradc 8>;
+	};
+
 	vcc_3v3: regulator-vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC3V3";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
