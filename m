Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A736021019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DoEU391v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/GcFNX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A736021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NRmlYHqLWpkQSiMPrkwbxDfXuLXsRXSxnvZr7XKvh9g=; b=DoEU391vHnkGzv
	UtnwVLKriPqs0I8ZMupUYBSOKjiyX8otTM3oYb1gMSy3d4V1jVTqYYvk909Hv+HxsGWqVOFVgSEA5
	IkxhmliY8wcGXfHVZNOGJ4XwEqCk7G0nE47tImP+ZL2E/R0eMml+b12lO1KJw4cABGiyf+8P4GBRx
	VIlpQ5LhTO8BukJjjHQ7OeHzyLyRHfdBqFHur4KpUUf08tVmGY2InfoEvm1VQJx0WS3yuZFl4lq3m
	J6tjlyS+l9ovQwKIjNFgVox29rHUKcw3oCCarO4em+pxTFtjY/yMMnJfSSxYnf4Niy/JMeYcbbx2y
	+M4ab+5KMqmVGxRZ5OcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDRZ-0004sg-GX; Wed, 23 Jan 2019 07:59:29 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDRW-0004sK-8X
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 07:59:27 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so1072031ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f5y2WrXe72t13tjWhoosTpGzHKQG4p80QLPHAsCf52k=;
 b=g/GcFNX3Ku+a9v3acxN+OESqcM++I1ewGBPQ7fbkQilcLPhO55gVyPCsF0pz14WpNx
 fg9DJl1Ml95EZWObg0o5V9RKrfkeb1hzgCR6Dt+eKKOJLChLXSCyVEi9Bz3O8ARbuQ36
 V3ICGMiUWqpp+/E4GJzn2Ddp00oSSmotKetFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f5y2WrXe72t13tjWhoosTpGzHKQG4p80QLPHAsCf52k=;
 b=ekHi5Mk47Dr2l3cUhTb14DKyvsMQNPPTSGN78umewvm+YRNg2IwDyLISz0DzERpQUA
 xm0b9fPjh1e28+mwoPW39OmedTfhZboISOzaYxUT/mrnrUEw3eSGiL5h9PQq+RBj94hA
 OPtqbCZvRpRW428FZ6+p+1m7Gq7KWgnovqR3QH0fmq+XGlsPyIfAbzPDuDTzD7FkmXi+
 TY6EV46XzmOOJnDeMwXm2Kan2SKzvfbKdw/CxTwNFKOnwiJONStVDRNSmf2w/SOnOgyh
 8wsQDDpg407lb/Ipt0TlhxA4CFNRgNDUiPj9IvPrDMXNPuAdysD9Etpmb7lB671ubf5m
 HLEg==
X-Gm-Message-State: AJcUukdAH2LpVTjDWb1vmztOEGWJDf3Z8ktWCj7VfLUew6k+63ucAHaf
 nDEhBWu4cMJnM5dxpDIawt6hw7Bp+Ko=
X-Google-Smtp-Source: ALg8bN7GqHRskExdKg26j1e+T29L09auxU/Nq8slqyzU0AzaDzBU+E1ddOb5hVVqqkORkjE+2JOPBw==
X-Received: by 2002:a2e:5703:: with SMTP id
 l3-v6mr1019779ljb.106.1548230363577; 
 Tue, 22 Jan 2019 23:59:23 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id k68-v6sm376819ljb.35.2019.01.22.23.59.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 23:59:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: defconfig: integrator: Update defconfig
Date: Wed, 23 Jan 2019 08:59:19 +0100
Message-Id: <20190123075919.6640-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_235926_305874_D1BD39D2 
X-CRM114-Status: GOOD (  10.46  )
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

This updates the Integrator defconfig for the latest Kconfig
structure.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 69cb8f1efcea..266ea8fb06a8 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -1,13 +1,11 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -15,8 +13,6 @@ CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_ARCH_INTEGRATOR_CP=y
-CONFIG_PCI=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -27,6 +23,9 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -36,6 +35,7 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
+CONFIG_PCI=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_AFS_PARTS=y
@@ -54,7 +54,6 @@ CONFIG_SMC91X=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_FB=y
-CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
