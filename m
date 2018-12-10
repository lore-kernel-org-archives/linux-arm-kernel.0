Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C379BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:05:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939D720821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ASG+aUXC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyalMmiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939D720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7aKNavb/DJdq8unYLcDWsl59r5/pSvH4TPfGtoMGkrk=; b=ASG+aUXC5Vgnsf
	vzv+5yToodGsN2PY4+gshHdWbrHcH9ZhwchXZXt9tMUG8gskRzE71uRJcRCU8RoM9P1jVIxuRNv9k
	sjtEboeRsQrdigfozte6DwD8pip/gVB1LVgdSyHqoxj2BKVObrpMLjWg5nFAwxXdyrcsueIUc0sO+
	hKGD0kgHFozyrPIgP0cDym1MUZhhDGAPj0KCNkMByDgNo44KxUctYQp3QoJVAgR6evZnJfu4MvQc4
	4YOA0yAEzIxvJY97qe9lrQWN9wvNuup39fw4lgGo6abs7Oqs8Y33XWSNCpuqZsLj8kO5u3GrtOMlb
	JpdFYzESDVx9hT+XxJ/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKJG-0007NZ-8Z; Mon, 10 Dec 2018 12:05:14 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKJC-00068c-Gv
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:05:12 +0000
Received: by mail-lf1-x141.google.com with SMTP id f23so7744592lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EVtHHEdxrELiIIM11FeviQesb7IOOsVZH+2Msbi8XTc=;
 b=QyalMmiyxZTNcoClqRQOpQfPxomoQZLGVN7BABPRaEyL1OJiqyRFFZJQwhKzl6E+ho
 UJiyvAFkNVrLe6dD85++fAd0R6U0pOf3v83cO1FpLjyrRc+g9bFnfSQhbENYliVAhXF3
 PcZIPmM5SkZo684ZPOkYrClhAskmzjBu7o6Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EVtHHEdxrELiIIM11FeviQesb7IOOsVZH+2Msbi8XTc=;
 b=LwhQq4OuAW9tHHBYcC96U+RL4gcutSv3sGuKYb4Fgnzg7pHm6IezjrXIlvT+uAUONN
 EtlogBeUFnFMwSY1TgwerT2vsPhPh8Ye+QpXtXVzxWwU18yxgQ/gXZCeyFZiK1wCUpAi
 XJQyOLAySXEegH3dKafhKSqzs4f148E5k/4B4+wrN27amMT+jOpJ8CndIWk8FH/9K38p
 dQWUGRaC3Sp+7/bWAVyCuGHcDZPEAMNHy2EoIZFQXyfyO+bYVtuWwK+YfREFlOqeH4oj
 8v5za2CbO0gslQGRwByfotl7w2D/SuA05dmzXN20nGLIhw+9d2Ad7XO7/4oyrnGQrUaZ
 OI2Q==
X-Gm-Message-State: AA+aEWb1sqUqa+q/t5l5hFRjyOMML6xZ9ss0TF5hdMRgkh2cxxmIUrjE
 7E/xt8N1qpp+jl1GXSXnreyCSH02fz4Hwg==
X-Google-Smtp-Source: AFSGD/V6zbrMUK243L9dXFPrnZNta9buEzxylLvqL1x2SBRbj5Oj1eg/2yygCwRvW0TP0f2BBkKQxA==
X-Received: by 2002:a19:660a:: with SMTP id a10mr7285498lfc.146.1544443498356; 
 Mon, 10 Dec 2018 04:04:58 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id p138sm2085090lfp.22.2018.12.10.04.04.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 04:04:57 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 1/2] ARM: defconfig: Update LPC32xx defconfig
Date: Mon, 10 Dec 2018 13:04:53 +0100
Message-Id: <20181210120454.9099-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_040510_567379_18920562 
X-CRM114-Status: GOOD (  12.07  )
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

This simply updates the LPC18xx defconfig against the current
Kconfig structure in the kernel so we can make changed to the
defconfig without disturbing noise.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/lpc32xx_defconfig | 34 +++++++++++-------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 0b54b4024e51..120d6b18df9a 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -1,6 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
@@ -11,13 +12,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
-CONFIG_JUMP_LABEL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_LPC32XX=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -26,6 +21,11 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200n81 root=/dev/ram0"
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -75,9 +75,6 @@ CONFIG_LPC_ENET=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_SMSC_PHY=y
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=240
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=320
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -99,7 +96,6 @@ CONFIG_I2C_PNX=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_EM=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_ADP5588=y
@@ -111,8 +107,6 @@ CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_74X164=y
 CONFIG_GPIO_MAX7301=y
 CONFIG_GPIO_MC33880=y
-CONFIG_PINCTRL_MCP23S08=y
-CONFIG_PINCTRL_SX150X=y
 CONFIG_SENSORS_DS620=y
 CONFIG_SENSORS_MAX6639=y
 CONFIG_WATCHDOG=y
@@ -126,14 +120,11 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=y
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
-CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 # CONFIG_SND_VERBOSE_PROCFS is not set
 CONFIG_SND_DEBUG=y
 CONFIG_SND_DEBUG_VERBOSE=y
+CONFIG_SND_SEQUENCER=y
 # CONFIG_SND_DRIVERS is not set
 # CONFIG_SND_ARM is not set
 # CONFIG_SND_SPI is not set
@@ -146,7 +137,6 @@ CONFIG_USB_LPC32XX=y
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SPI=y
 CONFIG_NEW_LEDS=y
@@ -169,10 +159,10 @@ CONFIG_RTC_DRV_LPC32XX=y
 CONFIG_DMADEVICES=y
 CONFIG_AMBA_PL08X=y
 CONFIG_STAGING=y
-CONFIG_LPC32XX_ADC=y
 CONFIG_MEMORY=y
 CONFIG_ARM_PL172_MPMC=y
 CONFIG_IIO=y
+CONFIG_LPC32XX_ADC=y
 CONFIG_MAX517=y
 CONFIG_PWM=y
 CONFIG_PWM_LPC32XX=y
@@ -191,13 +181,13 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_ANSI_CPRNG=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
-# CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-CONFIG_CRYPTO_ANSI_CPRNG=y
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_CCITT=y
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
