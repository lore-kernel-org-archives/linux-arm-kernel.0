Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFBD2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tgb2lkE2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDebkwXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFBD2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wOauZ1JwV+UOdqftn/pDDPeLHFG48Vkg+vWEyE4EPao=; b=tgb2lkE2VhII6b
	AGVm6zPjhZ5EY5Csu1gQaCPnFlY2kErYvk2aIOmDLFCjDSjH6jKGnoSPB5nza44JCh4w76Wozu2s7
	gyp17gwR2k10IRYsFzj/OgOfYdb96UswmVOXMbHDQq1lJC9xaZHJ2a1x9ItplLyrC+qdtqnFKvmYT
	QUxnK1vE7PRIRbjm8XW2p/lK9z01S/yRPK6RDEBd9unyVQdialrF0XHmpVleoIh+OEYdoes+D/4NR
	0hqj4mgkC/LwgPbfomQ3qK4NX3KBuIGon4sRGAI/ReyIapXstbhvx8jQZwWoqDSwhcRAQ8T7QCG9w
	vpqyj3S8EXlcKLC4PhpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHIQ-00042D-Ru; Mon, 25 Feb 2019 14:31:54 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHIN-00041s-Pa
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:31:53 +0000
Received: by mail-lf1-x143.google.com with SMTP id j1so7009470lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 06:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RFCzWSDTNRNLjLBBQ6t/AMTA6M0ys/WSsLX0pIyt7n0=;
 b=KDebkwXCOF/CB3dhGADP76u+dBScwvINKqjiWi3afXvGzn+rDXz5ZeXgEeON0G8RHj
 Kq9/D/ZP7cMKCIuDRp6dtO0v5Eo1q6GhXaAVi2pqod3I1j+qTjsSjA0lAU7n0tEb8YjQ
 v/AOVz04FwIqLh19EyJj3YsADjwkZ6Gbu54rF9gSUksw/8OJpcIazj9gB+WZj+KJk1Li
 +UhUubuB7QXQhP1FOzkbaJuKZZ0M+KURETcW4MvlbIFFMsMboJ4tLbvDxqzv1mGbAYuW
 DKseqL7bOwcPmgvmc/a4QDnOaDH5f2j6aVhZ3q0pXo6xFrZ4oumTdrrf8b5QtB2kTB25
 6JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RFCzWSDTNRNLjLBBQ6t/AMTA6M0ys/WSsLX0pIyt7n0=;
 b=QT8Rv8OTN4UMQ4V2qM2jVSJfcmkUaeihcWI/jOriF2nSFi7R2IAZ+qU8reIeO3Xho2
 lt1bIYm0I8DIlqVjJM/XooHs+2qPnPGUFh5Rc4ekorb2inn3ogUwf8+tD1RfgKEpY+5T
 7UJQNXuZ4+hl5uLttLGetew7qi2nsrrpyg/x1CI1aPBQy5XAb9FLx6GSd2TBzUSbDump
 77T58P3eYbFNPoY7JXf+t/KSFlVAvxJHYs4QKbi+Qbk00vnEfFKCKTzGV6Upb8jts62a
 iL1O4MIW5IdIO7vbz6azrrVingl7CFh21RgtqnVjAcsE9/HwT+nZMDQeGLdpvAVQwtjH
 2tDg==
X-Gm-Message-State: AHQUAuZholOF2qObZ6WewNQMcTlcy321RqG+aD71Aqzl57q1RvspwEfW
 s1jtaOfwqXljMUVP8kjZMRW8Tg==
X-Google-Smtp-Source: AHgI3IZS/y4OiV63jdqnGtDcswTWA0HTVskKn/NNx6NjPNqpXnQ7gNy4GfPELAcvrF/SMvBRGB6JbA==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr9369502lfl.129.1551105109391; 
 Mon, 25 Feb 2019 06:31:49 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id 4sm1701037lfz.94.2019.02.25.06.31.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 06:31:46 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH] ARM: spear3xx_defconfig: Activate PL111 DRM driver
Date: Mon, 25 Feb 2019 15:31:41 +0100
Message-Id: <20190225143141.2611-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_063151_831604_1C0928A3 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This disables the old FBDEV driver and enables the PL111
DRM driver on the SPEAr3xx.

There are some device trees in the kernel that switches
the DT node for the PL110 to "okay" but none of these
have any display defined, so we can safely switch to this
driver before we get any users starting to define
displays. Let them do it on top of the new driver
infrastructure instead.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for wherever
defconfigs go so I can cut all ties to the old FBDEV
driver.
---
 arch/arm/configs/spear3xx_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 2c5e8df33191..f1b52fb3461b 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -52,8 +52,10 @@ CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
+CONFIG_DRM=y
+CONFIG_DRM_PL111=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
