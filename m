Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE00C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:09:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5262070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kusnVaD9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP2TGzay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5262070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=r2JNADTXiunosVIH8xzUzf8AVMkQu281aUICW/GOVSw=; b=kusnVaD94xM67r
	0XLVSH1fUtZeTAF6bs97x2BK/STPPNTXRC7SdcZnomq00/CuzYrEXUxSFJAj26FGRa/1Sa5+kYCB6
	H5HwM4WcA8bfj5m4tIPG3UAGUQytZuA+uT//g6m6KOXhRMFQw7i/qRiZfLDfFSH7hP15Squ5xvmQK
	hYh7K9Bv6j2H5oVCo7zDd36Q1zof7NtBp5COWPJmA1jF8aE4wcylkFbPVJ0YsPUT3uPkTBudaVVSW
	ZvSQ1QMDrIZXgyvnrKjcvpj7Y/vNoIDom03/wfUUjJ97/muWe0GWuCWKKYzW9a2otSGv40bAK97Rt
	8uhuDbzffpDpIDsabeaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCSP-00027f-Br; Fri, 22 Feb 2019 15:09:45 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCSN-000277-3j
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:09:44 +0000
Received: by mail-lj1-x242.google.com with SMTP id z7so1776884lji.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V29wVUbfgh+kAvDZKu/TDz78TjDybZMCxRaK+TOqkLc=;
 b=GP2TGzayD9TLMW62dPNRQpbe4C+ZYtJJ8OqAP7mTb6yT6K/7RT7wt63EmtnBySIzx7
 P2EZLXw4VdYWuerqFoS+W9ma1H55FxSn9+b2/mWuOgm+OLtmM9/jtuXj1YT28o7bYBPJ
 BtnZdRY/6Lne4yZRPmB0SvlZjHEouFM8TVMGGQ1pZXdn5u59zbhUIgi3lsh4JnOqp5b3
 hWZfyHVNww7JpgDpwkcwA0luZSJouSMllOlkoG6R0GlPwLD5r8xHZEvTU0ERBV/0ZSiI
 YJh76McksAhzOVZnO/2WvmYtTtuZ6IYAINW+5/6Ap9ewXhvKHANjzNlLE36qOZiBMvlK
 0YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V29wVUbfgh+kAvDZKu/TDz78TjDybZMCxRaK+TOqkLc=;
 b=EoEfmiYRiquZ0DrvXE30Y3jXnexM7ACyHZQoeeEvYPgEIgi5HH1kQc2Z1UqiWfBRHv
 JqLv1MeM1dtWjKlMOi5Vv7+1ogodCRS9+mrUtPXBZj4PV5XnGioKOLrNm1IUreWzZ9cb
 Gy0jwbwcQmLInOYlDFF4td0bnT9AhGaYQKDB1YBiOQucrn97xS5Ig6fCZG4bqdYoCkNT
 PS+8Ke0Nd5zZZTaGvOg/nXwlMLixvJqh1++nJvQv+6vq8FTO7wbR/ezxi2/x6JP2x6Q+
 MK1rUcem804GfhfxY79ePUma4Pz6UTd8xNsugBAuZSGjAm9IFg6KJUTLYQGBFkmaVQbH
 yiTA==
X-Gm-Message-State: AHQUAubpMb+1SwziFG70GXssEXJVJ6fxrRgeI82RUK8BXD4+Xg4Wp/hW
 HlC1bc3sX8NsIhShGRLLwuuWma8hmkY=
X-Google-Smtp-Source: AHgI3IaU7Abt1RkyiIAx4k6fQGSgAgXy+G6fyaS/nQDwXWGFserVcm3d5sKxzKQLC9XGB5vNxhmV8Q==
X-Received: by 2002:a2e:995a:: with SMTP id r26mr2658386ljj.3.1550848179790;
 Fri, 22 Feb 2019 07:09:39 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id h26sm591819ljf.5.2019.02.22.07.09.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:09:38 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH] ARM: defconfig: integrator: Switch to DRM
Date: Fri, 22 Feb 2019 16:09:31 +0100
Message-Id: <20190222150931.12317-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070943_176897_91A1C344 
X-CRM114-Status: GOOD (  12.11  )
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

This switches the ARM Integrator to use the new PL11x DRM
driver. We need CMA enabled to get coherent allocations
at all times. The dumb VGA DAC bridge is needed for
the VGA output on the reference designs, and backlight
is needed when using an external display.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please queue this for v5.1 so that
we can delete the old driver for v5.2.
---
 arch/arm/configs/integrator_defconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 69cb8f1efcea..747550c7af2f 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -27,6 +27,7 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -53,13 +54,17 @@ CONFIG_E100=y
 CONFIG_SMC91X=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_FB=y
+CONFIG_DRM=y
+CONFIG_DRM_DUMB_VGA_DAC=y
+CONFIG_DRM_PL111=y
 CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_ARMCLCD=y
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
