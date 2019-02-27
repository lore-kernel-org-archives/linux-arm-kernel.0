Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58042C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3E320C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KBwZXbqt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/qqLFMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3E320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ytvJ69LAJoX6FPVmq4khyiW9jumcdML9s/rv6TRoKc8=; b=KBwZXbqtcB/a4V
	rTbNaI9rF2tG3mc8f93uf01WQwVOOjfEcK841oSyTCZFgE5TCFfqKL4p+B0BrdtnkkNqQq/iTVzae
	KWi8FZ9VyBWfvabcDEKtTPHocyVXwvegs63YN2ZcBytHX7Ey48l7VQuGQFSxAUf7eE/DlEtoM800v
	PkdUDusr8AI5nSJQe5kKKuC4l+E6pNLX7If1HWMKsmqgmuAKgZ65VbmksqsSWFmuM8W2GV8zL6PtW
	qWN/Kt+H9VRq0bikR/pBNe6EmKHBF3lVyHIir3UHWqqwSr476w/6QZtgjTsN7odBLGzqK2pogNDbI
	4zs/282VvARqG9egbbTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyza5-0005YM-1l; Wed, 27 Feb 2019 13:49:05 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyza1-0005Xh-TZ
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:49:03 +0000
Received: by mail-lj1-x241.google.com with SMTP id a17so14012413ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 05:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aGd/eRkEKo8K8sOS4aAql97RDlGnlJjaP00qPIqkWyM=;
 b=m/qqLFMR5rQIqXc36aR9NTPoPgt33D1ynfzitkaegN19m7jR5LbidiNczLNRAAVTtL
 CvO+2o8Gs2jtG1L9PUVKjRZLsWZ/hMtcB0Es8W3RpcgH4vLtZGtnoIRD2gK68WAAcJAZ
 IFX6AZB8m0+5meTS7sHNuEFvVsLHcVIr6Quzw7IQI31dg0gBpZSHtGJORvF8YOB78bfH
 K45eE2HDHy207l6UjtrM+LggadXDgjxu7BMcCg5ElRuvTe7zZUM69Npd9qs+Iz+slRpS
 AwL38074tEToER0zANqcJXGC9+98R0AlaEVEvGcvpWv/AMYFUM9KqdKbCWgoymMh4v2I
 B3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aGd/eRkEKo8K8sOS4aAql97RDlGnlJjaP00qPIqkWyM=;
 b=VHvu+AuthXxyy66s+eIYwDQ25Kpvzm5kr1wI4Z0OFqt/aj/0VRPUpBwOSY2EgwPd0f
 Soshs3yf44MLnLQCC+L5A9m0pSCPz+ttAViWsnbJaRb5026ka1Om4aUtebTAYjtB4XBN
 Dy8js33dGsPmFlQZelXdO2V69C4Z8pIpTxKDNjrX+pT6VjwhLWmDsH3SkFkoHqreRLak
 nONhxj6zbtx3OCIfJycIdhOR+6ZfvjMqbOkyM1QA+5NsT3pw2Bn5QaZiyTIYS1rVgj1m
 sgAb7BQwGQJJ2o4iyN8dpOC2WpSPgCcHpjZ/PC38UXKiVo01VE3Vdu8ERWCH9ge66Nvr
 5xPA==
X-Gm-Message-State: APjAAAUYeSefl7FUO7BJs4L+lokas3FH5k02uMyACV+bL+X6k/LeHMry
 BA0kXi6GW+Gdn6glkqFd6rHv/Q==
X-Google-Smtp-Source: AHgI3IbtbHCSVxoCfgirhQNQ1q1KlgWKBevivuYSiZDkdqHcoqf/sadJxn+CKTWQF02Xj5c3Kx6B7w==
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr1528599ljk.169.1551275339569; 
 Wed, 27 Feb 2019 05:48:59 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id d18sm1810258lfa.26.2019.02.27.05.48.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 05:48:55 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH 1/2] ARM: nhk8815_defconfig: Update defconfig
Date: Wed, 27 Feb 2019 14:48:15 +0100
Message-Id: <20190227134815.23430-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_054902_073044_5F504F9F 
X-CRM114-Status: GOOD (  12.32  )
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

This updates the NHK8815 defconfig to reflect the recent
structural changes in Kconfigs all over the kernel:

- PREEMPT option was moved around
- MODULES options were moved around
- MTD_NAND options were moved around
- INPUT_MOUSEDEV doesn't have to be explicitly unselected
  anymore (not on by default)
- DEBUG_GPIO should really not be in any default config
- MMC_BLOCK_BOUNCE is gone from Kconfig
- CRYPTO options were moved around

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly wherever appropriate.
---
 arch/arm/configs/nhk8815_defconfig | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 0ac44acd5bc4..db42ab32939b 100644
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
@@ -10,16 +11,15 @@ CONFIG_BLK_DEV_INITRD=y
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
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -49,12 +49,12 @@ CONFIG_MTD=y
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
@@ -75,7 +75,6 @@ CONFIG_PPP_MPPE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -88,13 +87,11 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
-CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -121,13 +118,12 @@ CONFIG_NLS_CODEPAGE_437=y
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
