Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1565FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:50:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB63920C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q4BAyEEQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZr248dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB63920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0oiG6TohfjwU/MTkBYniIhQDn7/28EI/qdYgwTVbscc=; b=q4BAyEEQGW8Qfn
	b2GDOj+iaBC/V69BqvTxqm3k5jZV4V3auQ3faxZZxQxKX9xANru50hwjQG343i6pF6qQptxzCaoaq
	qgEy49pKHKBvo2I2twXrum/1TCzt+gqShGppheJlEYXoKRQxARY3df7q8DXITUWCQ0rNZWKgSzd3A
	a3QIfoPuyPC7IRcEvva5fM/nDSv09SAWAHHrjEGKBmxaZ/LgqIffHR6vf0c27+3SQEVFXDYRWZ+kK
	XOwr6V3AmqI8busjEv7DE+FoFFZnecRFrq/FDKtgRRIr8S+ckTDLAuyVNGSQQ5ZtzMkbnZz1a3RxF
	rhE3jAYwprgEPRsZ5fEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzb3-0006NB-Cu; Wed, 27 Feb 2019 13:50:05 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzaz-0005pu-Le
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:50:03 +0000
Received: by mail-lj1-x243.google.com with SMTP id w6so14028950ljd.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cQmVGycUt0A6e79cyRGF3gMYxyhQcQovZPvv46UaKbI=;
 b=sZr248dPcdbJ6BEXns3tZymZe3gU1sBXcUZ8RQNkiCFhJJAZZfCMUiN26ljG6nz87D
 /N6QDdofZvt7FMoF69PN9JkLADJ2vVGGmJtdhu1cKFf4gKPG4t+9l+AO59gQSuWCo14M
 aOctxxAqkP1045+bGS07y5jiH97mYHFYE9VxRTHqh271dWyuXzmC06sqASpUdNQJt2iB
 P6iiA/1/p/fdTomVKEjnoGspYUI1GOHGukwMv/H/W/m5mW9+rM8fxpqKZvg+A1CO6yLT
 cKdRHG5I3uCD9CvPo5pQsOEKOkRWZnVwoNOn1SPDz1lAgEMLsCiGEMvP69u7QXTZDo59
 11HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cQmVGycUt0A6e79cyRGF3gMYxyhQcQovZPvv46UaKbI=;
 b=Xwzd6oNLZdj+f7G9IbAnyCUoeSSp9zaMEP0f4N6u1Qnbumpk+xeLfvYGzq4KnLfI9U
 KKnhzCqPIFjpd8l79BCtlJ/5RPufvekTYrEKPwUMXVgyhpPRTdArxKkKMOvdPOZ+L6WP
 TrL5SrRr07NLXnj0B82p70kBbArnJJChkse7Rvw/qXaoWY7YH12ziZTtyq7yIFcfgKGj
 EQ51FPoqU/fb6e2y342kelsJw34rojNHEoxs+H17WKLPk/WB4VJxY33lkrIxXk7QuzAu
 WmMuEvMsm+Z7NUHfITWXcRq4CzRF1m/EGbap8EzABiwxzDUyt5eaK91p4WpX5wuc5DKJ
 EBBg==
X-Gm-Message-State: APjAAAWwExqmm0cUyIRaCRMUOy0/8wv2t4zq7T39kJaXMYAmwVkvXEjl
 rH3eVkh2cv24rMmCl8lr53lc/cHj3Qc=
X-Google-Smtp-Source: APXvYqxLZrzJStYzVx2oGkUcemQJLMmpFazbgZ4Hlllao7iRzrFaCkoAwZYFbYJnEzLaSc//Ykb14g==
X-Received: by 2002:a2e:9cda:: with SMTP id g26mr1493882ljj.48.1551275399514; 
 Wed, 27 Feb 2019 05:49:59 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id c86sm3603400ljf.28.2019.02.27.05.49.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 05:49:56 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH 2/2] ARM: nhk8815_defconfig: Add new options
Date: Wed, 27 Feb 2019 14:49:19 +0100
Message-Id: <20190227134919.23596-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_055001_715973_075FEDFA 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds some new driver options to the Nomadik NHK8815 defconfig:
- Activate IIO driver
- Enable CMA for coherent graphics allocations
- Activate DRM framebuffer driver for PL111
- Activate DRM panel driver for TPO TPG110
- Activate SPI GPIO driver (talks to the display)
- Activate STMPE PWM driver (used for display backlight)
- Activate PWM backlight
- Activate STw481x driver (PMIC)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly wherever appropriate.
Requires patch 1/2.
---
 arch/arm/configs/nhk8815_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index db42ab32939b..5f4c6aaa07f6 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -20,6 +20,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -87,10 +88,21 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
 CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
 CONFIG_MFD_STMPE=y
+CONFIG_MFD_STW481X=y
 CONFIG_REGULATOR=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_TPO_TPG110=y
+CONFIG_DRM_PL111=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
@@ -102,6 +114,11 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
 CONFIG_AMBA_PL08X=y
+CONFIG_IIO=y
+CONFIG_IIO_BUFFER=y
+CONFIG_IIO_ST_ACCEL_3AXIS=y
+CONFIG_PWM=y
+CONFIG_PWM_STMPE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_FUSE_FS=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
