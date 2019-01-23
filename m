Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:59:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B1E21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e/A5Kw5f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnKK/Is7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B1E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3keXgG4BwmEZ/QhUnlllFUxL4/j4whcIRlC8g6rp1Qw=; b=e/A5Kw5fCdLOw7
	8HqNzcXscrvMKe6/ylsNAhXUspljf+kFCx70Z7KRJjXUSV8AkzgSIrUoKcgNGVgPB3pUL260oRgiV
	V/r8HxGUpQzF10oDRcblrRYaVlBaFhEyDdYzUM0jMzVQn/cTl4uoh0p5DzbSy4mBzA+2IdwkoopZY
	//sKvrmzlh3CBqCiLLmluNQXuHqFzaI4iXDIHEAWjGyWiB0FLWWu+4c1usPcqlxq1/hj3C8WN/cY8
	LFBisixOJ8CxH953arluUxl1kolMlIyt5HYbFiwxcoCSZvZvw7dnmK19YiEPyVrtHBvQ5pr2aGSu/
	l/R8B3llFdxk0t5mgD1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDRq-00057f-EM; Wed, 23 Jan 2019 07:59:46 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDRc-0004uE-HZ
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 07:59:36 +0000
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so1072260ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 23:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=urVEb7qopas5Vbn9NQXDStsleihrLFS6XygLB/UPVDg=;
 b=AnKK/Is7rYKYJkgffNSra08n5FhYnV6Xhi17k3EkhPEzzZKUqZrtSMlEIXe4CrHFSB
 rEVmUEMFcNL8Vta5VgdHl+He8EubfsjlZmrDxTibvDugwQ3s9Uw554e7ddGPsSf8haTu
 nOQtjAJJRD707ZAY0fUX4HjLcYnhH0GzBSXkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=urVEb7qopas5Vbn9NQXDStsleihrLFS6XygLB/UPVDg=;
 b=tABIbgpRUjiFgvagj+pMdg8QOa9+OiqhwJuhtbJKM0cQHlcBrzJCK3EPcBbO6cMyb6
 iYdJP08lnFskhVtNtS1EL6hZwWwKGnukADwG44EmDdSIwEQACUReC5U/HJZukLrmBul2
 jopQmnznwR8a8X+/f1+QUergZa7/pv/01YUByRc84aXcSnyz3ePmvnCRAvX2SaZ1d8wT
 B86tWPgeEOrQYxfuUvLCcY/PyroBrD5wbPwqvzrLFpIkQT5mCjOCu1VElqsxRq1PF1bo
 IWDTTEW2GujfYrN6JSePiWgzTfDyd/Hv7McxjyA2p1I3j9pr9eHmyYIMyVA+ONKLHsZh
 5MhA==
X-Gm-Message-State: AJcUukeiHwrEtpFejW0Ki1rrlnNQR7LWKGpk/uvUKsqZbOdbIdVhAsHP
 YRxk1HRQdtWm+w+HHpWuXRyKeySUMzs=
X-Google-Smtp-Source: ALg8bN6IKG7hj91rugiIuqpDdMJJVq2JvArlylngSWSCFT6BFuC7zLIDZSux8jxB8SM6xqsflhJV1w==
X-Received: by 2002:a2e:5816:: with SMTP id
 m22-v6mr963913ljb.177.1548230370124; 
 Tue, 22 Jan 2019 23:59:30 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id r29-v6sm366123ljd.44.2019.01.22.23.59.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 23:59:29 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: defconfig: integrator: Enable DRM
Date: Wed, 23 Jan 2019 08:59:27 +0100
Message-Id: <20190123075927.6713-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_235932_978636_C2274ED8 
X-CRM114-Status: GOOD (  11.30  )
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

This enables the PL11x DRM driver on the Integrator and
thus transitions the last of the ARM reference designs
to DRM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 266ea8fb06a8..a6b36f8e1b8e 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -26,6 +26,7 @@ CONFIG_CPUFREQ_DT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -53,12 +54,17 @@ CONFIG_E100=y
 CONFIG_SMC91X=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
+CONFIG_DRM=y
+CONFIG_DRM_DUMB_VGA_DAC=y
+CONFIG_DRM_PL111=y
+CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
 CONFIG_FB_MATROX_MYSTIQUE=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_LOGO=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
