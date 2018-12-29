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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:58:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB6B20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WdbehSSe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uwIjXHkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB6B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OV+mOvTGoUy6fZ8dPankBjokaxMxoJYRU0lYWMwP6fQ=; b=WdbehSSeqlBpXH
	AGR7NVtipPRyRlKOrYc08kA8L4JiGjF95G5JXMhxU5C+nbe/Y+t803N4UDK3CXht238/0oEYNSevs
	uZkmHlwp9QF31Am/ER0Ol7ghYAC0GWOYQEh4k71FCXIuXIEbBrkerkb5lYNCVv1CMSqpoGGuZTxXM
	T2PbJ84ojJAUGyZBeeUaIUHi5vZcaRtnzfZrM9NBsyfWmQd3a3qLqZ7nZ1zXeNfQmcTh0ShxYsw9t
	O624rzg0PeooZF4czKUl7teyijvME3t/AL7IxsMv0bNjCghMJN195c6gZ2SAuW7q32FleAOJFpjDA
	FdEo+Y1Kj3sbR8XB8ehg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdECP-0003m1-37; Sat, 29 Dec 2018 12:58:41 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEBY-0002wn-U6; Sat, 29 Dec 2018 12:57:51 +0000
Received: by mail-wm1-x342.google.com with SMTP id t200so9547115wmt.0;
 Sat, 29 Dec 2018 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0GgHqqxZVFXgmfbHJtxlutcHlK9nbAzoBbUIQBCbANI=;
 b=uwIjXHkDkkPZPetAQRlQ8Dx0nMlgoymY6ulxb1HBCaPhu8NTZtSOApAgBwpRh19a/1
 bJbenQV6tpB8P8pR6L9vBsubpz0wWKquymP9F3fi7i7ljO4b3qjd/Gj/PjCPao5HNaH8
 DYKyhBrVS7m5m9egGQZWVop04jtTnopuEsKIJpJLRgtvUoK7FmHfu1Thk7FodE1b/6f8
 1AOVC6YL/0GSrugej4VjDM4F7gTdQseqG1gRXPEs1cUOWQyjGDokJJy/fPDrMVLaaGFS
 jSegRpMHu3+5vF7o2irUWR4wxk25ZbhoH5O86aobJsYfQdVsqLPB72wudis5HEm3RXWg
 cHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0GgHqqxZVFXgmfbHJtxlutcHlK9nbAzoBbUIQBCbANI=;
 b=UyGAu9hmD/2w8b+FLHr9VdbKJrweQnaXsW0ZelU/ebpNhcZqLz9FbZhqvn6oJ1flHV
 s3t+HDO2YtEp43AR/45Bw2p9R2hHQcrjmTb+qLJ2LUnnc1l+PL3R4pcAwh2b8I45uIgk
 FIz1LA5nzAypBpgRH1IUzLn+3VPteG8IHmr/up9utYBc2Vku6etEV/JE3syWkdhIOkMI
 gMS+MBKY9OEn+ID4CxgKvWiVvl5XIVthSckoDTV2GfdX+K7m5Kr/ZsZH9E5PkXu7bVQR
 AS1XZthfsLXJcjChmL953OPqCtPEesoBFZwV6TlAeNFkOlwt5Hy5aJwsJhz0m7HW50vl
 mTCg==
X-Gm-Message-State: AJcUukc35Wu0Tfq0LQe4JD6eC6aJNo/7eszwQkaT3DtnMikWM/HIK1KU
 whLy4gGlFbU0lWLFIfMM3HYdjmoe
X-Google-Smtp-Source: AFSGD/Xq2dNuPD5B9Jyeeixk2jL9dKx4017uH/Ni5DQpYTDxU0ptgJE384Bv+wvOFtev/8VZrZfeOg==
X-Received: by 2002:a1c:5fd7:: with SMTP id
 t206mr28045169wmb.145.1546088256856; 
 Sat, 29 Dec 2018 04:57:36 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600914F24DE1716D3FC.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:914f:24de:1716:d3fc])
 by smtp.googlemail.com with ESMTPSA id h17sm31987059wrt.59.2018.12.29.04.57.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 04:57:36 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com,
 linus.walleij@linaro.org
Subject: [PATCH 3/3] ARM: dts: meson8m2: mxiii-plus: mark the SD card
 detection GPIO active-low
Date: Sat, 29 Dec 2018 13:57:11 +0100
Message-Id: <20181229125711.5205-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_045749_163482_90765B70 
X-CRM114-Status: GOOD (  14.48  )
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

The CD GPIO is "active low" on the MXIII-Plus. The MMC dt-bindings
specify: "[...] using the "cd-inverted" property means, that the CD line
is active high, i.e. it is high, when a card is inserted".

Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
drop the "cd-inverted" property. This makes the definition consistent
with the existing dt-bindings and fixes the check whether an SD card is
inserted.

Fixes: 35ee52bea66c74 ("ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index f5853610b20b..6ac02beb5fa7 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -206,8 +206,7 @@
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
