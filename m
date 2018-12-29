Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:58:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038BF20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBl9mGsI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YWvhDm0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038BF20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5S43vt/HOLhylFSFUcEGs72wbI5/opsVBvHpPeYzPmA=; b=VBl9mGsILFOBab
	vfVjcMS1gOaYpoEh9oZjY5ay/2Qi+qloXBC2twVzuojFnK2nhFgOa70KXv/ycqaJwM9Jz2YNoa9il
	cJi5Fq/QQan0+oGPik0lCgu2p+UYrbnMsBLzfkxO/yM/Siqj6Gc4wPlk7FspAHE0tLvUvHm8iQIk5
	PqF+UOcmOWXjeRwwFy/xHWo+L9qxHw7e2nWLUVsblK9JEH2cmqjNmJsMcNSeGTl0RBHbPcCIISRPI
	S+iCUqulmpAucof7kG1PqG6GqNQN8Xs0Rpm1ZrSVbqaB7yOLKYRqrWK5aq8JdXsNfe5ssr4vtOyb/
	hkot8Hepi3aNfTGYXedw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdECE-0003dV-Jr; Sat, 29 Dec 2018 12:58:30 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEBX-0002wl-Nw; Sat, 29 Dec 2018 12:57:49 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so23030967wrs.8;
 Sat, 29 Dec 2018 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VlAqZUJKjhpDiruDFrlNjds26NWgcPdIHOc9gfNOZDw=;
 b=YWvhDm0AIwD9W5CR4hxwB9wQM2KP/7L0i9j7aD1eEFABQNrP8Svf0auI8t44vA4Aj7
 u76e+fiMzYUvNuMG0Fb0p5GOm354hoN4/zjkDLwxQSkn+3zJXi3jgCFmPRhuG6fiDAtW
 IfEAQANGeMa5jWqjUTH7DhnF0Illwl6a0um15uy7ZmnuFZNFv0EepJPqfZroo5P23dYs
 UfUBbuqEfNSLLGAzqTdb2FOMOHOHGPtG/v1jiAyJ6t1+Bh/p1aq6q9EvcJkGSWJQqXyM
 bEkUfKYbiKB19Syc1Ppueb1YgnG6A0k36hgg4cN3fWbeKl4IGkv/jCiCell9LQqEHFzc
 aEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VlAqZUJKjhpDiruDFrlNjds26NWgcPdIHOc9gfNOZDw=;
 b=V7TBBI6C4JPkXCElG9RnUYdsFjF4kdBA5XJCMe/2F77ER1uDuwCZvvdczejf1Npc0x
 nZln8tBsTl21rhAmf0ZWUcaqQzPl1TM9RNPw8KB6tgZX+3LvDGCXnwWc0ucrIyOM++1I
 4Qr0MQV1Z9oqBtKyHA8AJJI7aFcEMSQoZeZfkQjNZp0ifM/idSMPG/b0i/NqRUDCOJOP
 +R611ifkNScO90CAyGS5SHy+wSVtV4UEIEN/TNZW1sDwcT9Lt3bZj/JSWs2qiKCa+QWs
 Oes6ezlAsRKnb5D52joam0t8zfTLfmtxXp6RPolHlbNoa9JiQj7CR1kmR77bDQi2NgJV
 ytGg==
X-Gm-Message-State: AJcUukcWuZUHtdcuRUQ13SNLR7mrKTQpEcqKsa8tgxa+k5tHh4BdBdFj
 nblWM61ow4cxsAWkraR83QDYyqen
X-Google-Smtp-Source: ALg8bN7xzdiR3LRxK+u6K8d/bbdwUQJ88L0TyNFqvdygQEPhOt8U5L8VvlqqHSd8UJjMYifFUIQMSA==
X-Received: by 2002:adf:a743:: with SMTP id e3mr27143292wrd.56.1546088255653; 
 Sat, 29 Dec 2018 04:57:35 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600914F24DE1716D3FC.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:914f:24de:1716:d3fc])
 by smtp.googlemail.com with ESMTPSA id h17sm31987059wrt.59.2018.12.29.04.57.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 04:57:34 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com,
 linus.walleij@linaro.org
Subject: [PATCH 2/3] ARM: dts: meson8b: ec100: mark the SD card detection GPIO
 active-low
Date: Sat, 29 Dec 2018 13:57:10 +0100
Message-Id: <20181229125711.5205-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_045747_777055_1585DC03 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: linus.luessing@c0d3.blue, bgolaszewski@baylibre.com, balbes-150@yandex.ru,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
tree") SD cards are not detected anymore.

The CD GPIO is "active low" on the EC-100. The MMC dt-bindings specify:
"[...] using the "cd-inverted" property means, that the CD line is active
high, i.e. it is high, when a card is inserted".

Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
drop the "cd-inverted" property. This makes the definition consistent
with the existing dt-bindings and fixes the check whether an SD card is
inserted.

Fixes: bbedc1f1d90e33 ("ARM: dts: meson8b: Add support for the Endless Mini (EC-100)")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 0872f6e3abf5..d50fc2f60fa3 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -205,8 +205,7 @@
 		cap-sd-highspeed;
 		disable-wp;
 
-		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-		cd-inverted;
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 		vmmc-supply = <&vcc_3v3>;
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
