Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:15:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4142087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ttsRMShg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZfMn0eux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4142087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wW5sG9uoDkzYflD5o3FbkyJpNcHm7PNySQOazYlvj0=; b=ttsRMShg9kJrdx
	9awmHJJQ0XKWUYWNiAsZ1VgyBWyok2Z8bpAuP9gt3/NsBGZv0UxkCO4L5KsSp8FX6sBiwpEkVtCss
	YeX+QD7zaVByDS2NzBz0PhiLbcCODnGpiZ3bv0HjyjVJbdcmp5MfhaQJti6KZTS8povNsHdmIdpSm
	frczhutWjFIensJL0OOKF6gRuHLAb1nomdbA6Snvq+mkaCRmhFZcD+1amZwOzPR5fmTnauioul59F
	WGui84k++6RXZ1QOsl0F2bre2DoWP5U/UyDIh2h3FLOQIL6iJ+9azsUEHXcGaNCMXlkKUqWn420Gu
	UEmqZnbxzBigaTJQSvsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybdX-0000dS-8y; Tue, 26 Feb 2019 12:15:03 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybcb-00081H-JY
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:14:12 +0000
Received: by mail-wr1-x443.google.com with SMTP id w6so10430694wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W8SlkkWNbz8a6Pc/LUbBX1rm7FrHNXiQoSoIVyFdUZw=;
 b=ZfMn0eux0oXgg9c8VhkoRGJQxArXR9Kdj9tv6dJIE7ZZS5Il7bmZR8+TDVifji3w0l
 ICQ2uiCbf6uGlUiLlwPX8AA34vOvJFHKqVRoNmWG93XzN3PBCKHPOkikVep0KCt3xTxR
 e3Qc7D4tZkOn4KUBFPXUPsOtpYmlqaWyiMJBcvxPxSOv+8bUVGJW5PXrZzXZWSNf+dYE
 FfZem/PClK0U5Rjqxl/ucQf9mZ1dEsw87Zh/lEASi4L80vRmFbvSXnVnlfMmbdZBdL2W
 Rm5f32c0Xso/KSgZM/+lAsBiMY+cYm0eWenYBiOICk/DdZkgq2E2FIQGdm0ekzysT5Y1
 wNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W8SlkkWNbz8a6Pc/LUbBX1rm7FrHNXiQoSoIVyFdUZw=;
 b=fdHqpvIOmEMw8CLeOJI+UWIBGhjgMh4QQA7WN/PoO/WTHMNqIPLq3DXd8jIsdex6++
 28D2ixCERn/+Ta75oTiyZGXAK71xqdIWkHPiRAp6BXKxm5A5KpURVGi50G0Qvmg/P8Nr
 isalk+m5HWzAjwhBsKjxc+fUkorzWM8549JFOR25opaqSrAQF4U4NKOOu9+k1ITuuY2i
 NA46/5ruZUsI8L1Ww9uUeQLS+VZxO3SVTZa85uCrQV95lQgaugOAJZNxFM6crRZuqsMt
 RCO4MRSmrTDpdIOS3YnfgdNwQZfxctzJ71HNOFPJ8/ooVNtiF6ScYITs/iN+NbRrmZ5o
 BbcQ==
X-Gm-Message-State: AHQUAubM//dfUyI8eJVUqWvM/EPMTGylRMvrQLKbQOFf20kawI+pBgxb
 8ZC96D6FhXiGHDL9MbR44Uz1kQ==
X-Google-Smtp-Source: AHgI3IZtG3oFydmOm+FOSwFoHfcKMng7v0mNlYX1bEI5qpae3OWdODXh3TFE0a2NxnpW7e/7bBGYpw==
X-Received: by 2002:adf:e3cb:: with SMTP id k11mr16635882wrm.263.1551183244174; 
 Tue, 26 Feb 2019 04:14:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p1sm11401877wrx.50.2019.02.26.04.14.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:14:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>
Subject: [PATCH 2/2] ARM: multi_v5_defconfig: make DaVinci part of the ARM v5
 multiplatform build
Date: Tue, 26 Feb 2019 13:13:53 +0100
Message-Id: <20190226121353.19413-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226121353.19413-1-brgl@bgdev.pl>
References: <20190226121353.19413-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041405_759591_9C1B43DE 
X-CRM114-Status: GOOD (  10.18  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add all DaVinci boards to multi_v5_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/multi_v5_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76fa26d1..d7b2dfe11b05 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -14,6 +14,18 @@ CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91SAM9=y
+CONFIG_ARCH_DAVINCI=y
+CONFIG_ARCH_DAVINCI_DM644x=y
+CONFIG_ARCH_DAVINCI_DM355=y
+CONFIG_ARCH_DAVINCI_DM646x=y
+CONFIG_ARCH_DAVINCI_DA830=y
+CONFIG_ARCH_DAVINCI_DA850=y
+CONFIG_ARCH_DAVINCI_DM365=y
+CONFIG_MACH_SFFSDR=y
+CONFIG_MACH_NEUROS_OSD2=y
+CONFIG_MACH_DM355_LEOPARD=y
+CONFIG_MACH_MITYOMAPL138=y
+CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
