Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A20C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:16:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B589E20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBYpA0bL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWRscp55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B589E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LXkrejFHjwSMjnyU/lT+HuagjYz0/2eD8ZFUPC9KYYk=; b=VBYpA0bLQttKO3
	CX6rGaHrALnjk9mGlPV46IhuIFd9cdR+Lli6a8a9KuEK2oCcmnF9AxPh2wPcBInwN3dBVbr8s/biU
	cmePhduqzMJVvpkFD1j1+V2berxEu2219U2J9z0ZcpDgkV6RNLeFXISkVY5OwXTNLrDaubBP0lYv9
	D91gRBPKri3a56Rxj3bvqbJn6tN7yUuAdDGHt0Gu3S8Beq8IvYw0b3YMd+ZCdvlbsOuMZ7FKIknvv
	/Hho5WwnGvF/8BePQdSsqmLGadv7xCEtGu7Eq28DmXRFimHf6vEzjZ4hzRYBMClAfgGtJuxodOAVw
	yzcdeD1hPHTTYZdnCjgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIcE-0007nB-Ev; Mon, 10 Dec 2018 10:16:42 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIcA-0007mC-OQ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:16:40 +0000
Received: by mail-lf1-x144.google.com with SMTP id a16so7562975lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WhFS1Q0qLqJ9lsZmpkHwNaKR7ec8kuFBOv1l8Mywt2g=;
 b=eWRscp556UG+9D4VUleYc7aapX8aPMz284FTv7Go1qmgHI/xILu92CKKB9nuPh5DDV
 i61Vipg4oSRbrt6ZoZchzRdnVzKUv15Y04fZ3KrwMcMHCxmziVEg0T1IQoJE95Pm/eXA
 Kk8e02wliBefMlhmHuAetd3jAwDBQ08FE7BPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WhFS1Q0qLqJ9lsZmpkHwNaKR7ec8kuFBOv1l8Mywt2g=;
 b=DVypBa9qvjGlOOSDjnF8/X6kqLs869/habHINTIKW/wv0mLw2q7NOD5P5Qx/ZJSand
 P5JVKnEJ0olH0NpgkiQHDs0I0V5VT644nEVw5nn6UE9+w86uB/lxwwyJEWtMWOF0p+8E
 BXq7dXPRlmlJEdi6/t+NCQ1x1iMCrelBpUHTht6cKeGLix9jmTG0PnaxV/tl22K5A242
 aqVg3Z88KIMWMDMVwTg7wTZu7tOdSdZBo6JxAjQwfn/FsW/cyvwzHCCD4UqnxcuJYbS9
 Ah9tm76PXZl26+ZSZYBio8iZe1S0CIbIuSenkAtAwbRkJT3MEtXBBx35hOEhdiTHNPEW
 fu+w==
X-Gm-Message-State: AA+aEWY36loFG3wB+JtX2i4p/awbPs8N+yWcjVUtrRQ8CWZhCicWKVaV
 dcUK5zH5VLuwZwRluXONGWl4wjDvGJmbow==
X-Google-Smtp-Source: AFSGD/XgU792kgK+jEkOjrAeSwk2wRa3WuYGzumF06HJOBgyCLHA0dVwMMcs2eUS4dfAR4h4xrqImw==
X-Received: by 2002:a19:982:: with SMTP id 124mr6239043lfj.138.1544436985976; 
 Mon, 10 Dec 2018 02:16:25 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id w9sm2032939lfc.66.2018.12.10.02.16.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 02:16:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 1/2] ARM: defconfig: Update LPC18xx defconfig
Date: Mon, 10 Dec 2018 11:16:19 +0100
Message-Id: <20181210101620.418-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_021638_789353_2723AE1B 
X-CRM114-Status: GOOD (  12.09  )
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
 arch/arm/configs/lpc18xx_defconfig | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 23df2518203d..3627495b3dd0 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -1,5 +1,6 @@
 CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
@@ -17,22 +18,20 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
-CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_LPC18XX=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x28000000
 CONFIG_DRAM_SIZE=0x02000000
 CONFIG_FLASH_MEM_BASE=0x1b000000
 CONFIG_FLASH_SIZE=0x00080000
-CONFIG_PREEMPT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
 CONFIG_BINFMT_SHARED_FLAT=y
@@ -69,7 +68,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
@@ -90,7 +88,6 @@ CONFIG_STMMAC_ETH=y
 CONFIG_SMSC_PHY=y
 # CONFIG_USB_NET_DRIVERS is not set
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -101,7 +98,6 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_NONSTANDARD=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -144,15 +140,14 @@ CONFIG_AMBA_PL08X=y
 CONFIG_LPC18XX_DMAMUX=y
 CONFIG_MEMORY=y
 CONFIG_ARM_PL172_MPMC=y
-CONFIG_PWM=y
-CONFIG_PWM_LPC18XX_SCT=y
 CONFIG_IIO=y
 CONFIG_MMA7455_I2C=y
 CONFIG_LPC18XX_ADC=y
 CONFIG_LPC18XX_DAC=y
 CONFIG_IIO_SYSFS_TRIGGER=y
+CONFIG_PWM=y
+CONFIG_PWM_LPC18XX_SCT=y
 CONFIG_PHY_LPC18XX_USB_OTG=y
-CONFIG_NVMEM=y
 CONFIG_NVMEM_LPC18XX_EEPROM=y
 CONFIG_EXT2_FS=y
 # CONFIG_FILE_LOCKING is not set
@@ -160,9 +155,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_INOTIFY_USER is not set
 CONFIG_JFFS2_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
@@ -170,5 +166,3 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-CONFIG_CRC_ITU_T=y
-CONFIG_CRC7=y
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
