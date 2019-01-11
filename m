Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D5BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A038720872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kf6jTwC/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLa+zJdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GeirmyC0mZRFIr6QOZ8sGSnh4gxaJfMywNzZ5EiJq5g=; b=Kf6jTwC/w1aoFE
	zR5P+Zg1I0t5H9LImbZgufBkbOIH8Y7SnQruBnwEp8UdOdbwYG4329lzHLju8IP4ItK7S67vS1QDY
	K/epy4pwPgvKH9XObU+GXTlIl0y2KMOPVuAg97L3X4GhFUUs10Qk+n5k//BSLU9NKstttU7ZzA1bd
	bCkkpHX5N8TQFER/XaPy9vOoDnyl84b6Nqu18oF0GJBYzkVCxfPTdSE0zyn3JmH8rrGTIOA4yQFBn
	q+elu2xem+Zv3Aaed6qo+PushjS1x6DhnhE/FOj1DkmqDh62YBUWyscjibWgpvqfMit+GgLlSOK+M
	sSJPqRO/1zVYp4MUWl+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2FW-0006HE-Bq; Fri, 11 Jan 2019 19:13:46 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2FT-0006GR-1Z
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:13:44 +0000
Received: by mail-lj1-x241.google.com with SMTP id t18-v6so13894816ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HGWT+fVX/OzAwVYlml6V/JEJZXYhqCX3FF/2fg2ntTg=;
 b=iLa+zJdk/kpExi88qxeeKEcxoktDg+36lkFbuKpKo7XtCWx3Va97gQc7En1gsMLCNO
 846cr/08zGxI2klBpIrW0/hvYCCuaANqbV3tsT5TvX2Z+1c3sr/wlhOalTcSFKXqhnvE
 UJlKD0e/O4cyjP/B2mnZmv4NRD8M8WeoBibS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HGWT+fVX/OzAwVYlml6V/JEJZXYhqCX3FF/2fg2ntTg=;
 b=TrstPrqW2la3Wt3yG2HFAcryKFfmJ8kthtFIzDcDD3PlRv5JIOeEQsO8OTCPChJJWm
 /XiB8gFrOAXTQRfk6Ti4SGxuOMwfe1ggV0B/Uc5N6cX+ZdxfwtK/ZJnGtyHIbXJMmXp+
 c71K0bQslDeNE/EEB4re3/SLngGxZqoRXZBd5I5yejohZWiw7KyZssuf76ChPACNdTxX
 ZYxmb0EnbacFLuk3Lk4AmU/7IEVcSaur8s3SUJISUdmkqVqhmch+GF6F7i+r8G7LR0Pz
 M4tbQSTHMFKkrTnkOEWO0OXKdFhOj887UmXRW21oaDF00KycC0t0xPa7j+MVe5P5voSD
 6ZLA==
X-Gm-Message-State: AJcUukexfeWs+XCxGZtFPpCth8imkKuAJ8rF/szvqd26kCN65AethU+U
 fs4haO2HsGp0wn9XqkxqoQp2Iq3kI2Gtzw==
X-Google-Smtp-Source: ALg8bN589fLEGKP5feC/qcP4b16Dh7eMwPTBuQxuVwPbmYQEHJR8Gy0fpCktamCyJ8WZdycM/keS4Q==
X-Received: by 2002:a2e:974a:: with SMTP id
 f10-v6mr10369771ljj.61.1547234020325; 
 Fri, 11 Jan 2019 11:13:40 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id p10-v6sm16024366ljg.19.2019.01.11.11.13.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:13:39 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: defconfig: Update NHK8815 defconfig
Date: Fri, 11 Jan 2019 20:13:36 +0100
Message-Id: <20190111191336.4391-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_111343_086803_5EA50F33 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This updates the Nomadik NHK8815 defconfig:
- Update the config to the lates Kconfig structure
- Activate IIO driver
- Activate DRM framebuffer driver for PL111
- Activate DRM panel driver for TPO TPG110
- Activate SPI GPIO driver (talks to the display)
- Activate STMPE PWM driver (used for display backlight)
- Activate PWM backlight
- Activate STw481x driver (PMIC)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/nhk8815_defconfig | 41 ++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 0ac44acd5bc4..5f4c6aaa07f6 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -3,6 +3,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -10,16 +11,16 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_NOMADIK=y
 CONFIG_MACH_NOMADIK_8815NHK=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -49,12 +50,12 @@ CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND_ECC_SMC=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_FSMC=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_GENERIC=y
+CONFIG_MTD_NAND_ECC_SMC=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -75,7 +76,6 @@ CONFIG_PPP_MPPE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -88,13 +88,22 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
-CONFIG_DEBUG_GPIO=y
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
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -105,6 +114,11 @@ CONFIG_RTC_CLASS=y
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
@@ -121,13 +135,12 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_DES=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
