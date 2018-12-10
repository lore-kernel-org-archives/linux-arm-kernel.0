Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7908AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:05:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452F52084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I5i9N6yx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8eSj+qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452F52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Way5EvdzDDbcoXVXTCuuoSlVGSgFwcsZUmYLlB4tM0w=; b=I5i9N6yxnb/lVe
	2S7ARi3F65ysxy/4q5LFH0ab2qW4WgHDjzQ0VmNPbwcbWiJRf0DW8XtkLIhMUiHObjUMbXrHgDEPi
	8ag/CbCrhH0hCLpV/eA2064mKpOrX3P8nybbwaEHRaEhUkQQGVsLC7Otv7bEpj/TQtBhP4N6Re47g
	aSmIRh7KZfWjsiFH9h2dXemADfAhWN4snibqU7qrg/tMtJadwomYm0PEqxmUTJAqvNHGlnng97rXz
	9WzJMJChJRp4YyI5M/USjG05fIUyDG1oknQZSCC8nXGBzznPRff9nl1dUpCDi6TZBLsW9ZcBVAGFZ
	Um36YRu/rl8u6+X0UZ7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKJP-0007Wo-T4; Mon, 10 Dec 2018 12:05:23 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKJE-00068e-FY
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:05:19 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so9348712ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C+2/F34lD6SoPjvnHTKQISoqTryMxljuPPpGXumkgxQ=;
 b=i8eSj+qghnplgFBfQBsISAAnEOhfLorzEhDRLRR/o7WO16cDPbqrMDMC40MmDXiaSh
 qJkQAGRLoG9KBuWiSTH4DJVZwIfPRJd49R39aLHiwkN5vr2baZetURzeVjVo2xzWJL1w
 4Ff1DcLCnvyKrdVRVBA6X2hcm2U2gKUQM2AQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C+2/F34lD6SoPjvnHTKQISoqTryMxljuPPpGXumkgxQ=;
 b=SMsvD/if8Gol8DHMFIoMccd2HaVd9bwuciip9ja+rXdR8LM0+qvkPp6jxxWl3d4AyN
 0XmrA4rB303LzJi4jMZ/xzENL6GhAg4PuFyw2zTKRLhn8+M0ro5CwRqKgDfLe4PVnpzQ
 YcVhtAI2LySYOPw06Qdeu5GaxGQyNWWf1KQuIjyEhE5UtzzsMNG/zYqiay9yY4tnlU12
 BOcvUZm/x09vACNYNl49WAC508HQBx0vfu0DCBehBpYyEoJQKT847h+QxdTz/QCk00tH
 zJriY/Z2OWCdcETAPc3C1/jVi37KvwWdUqFHmwhNIYl70Cn53bFt94ktuvSb/V8apeRm
 g9gg==
X-Gm-Message-State: AA+aEWYHBJMOZwBakZDr3qn4AU2s/8/kGCCtg+YKCqHPadcEP15QzPAS
 nk+YJscdo9bfJQCp3Wnrre8nEXFPN7LJ3A==
X-Google-Smtp-Source: AFSGD/X5aF4kJl9/wSUkilsX+t64g4cG+hqp87SmeGo7M/4KKwbSLjHwOWDETpE+CK8C9sMGOFN5mw==
X-Received: by 2002:a2e:9f56:: with SMTP id
 v22-v6mr6776344ljk.114.1544443500424; 
 Mon, 10 Dec 2018 04:05:00 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id p138sm2085090lfp.22.2018.12.10.04.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 04:04:59 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/2] ARM: defconfig: Switch LPC32xx to use PL11x DRM driver
Date: Mon, 10 Dec 2018 13:04:54 +0100
Message-Id: <20181210120454.9099-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210120454.9099-1-linus.walleij@linaro.org>
References: <20181210120454.9099-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_040512_516368_12277387 
X-CRM114-Status: GOOD (  14.46  )
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

None of the LPC32xx device trees contains any display settings,
it just defines a device tree node for the CLCD (PL11x) left
as "disabled" on lpc3250-ea3250 and "okay" on lpc3250-phy3250
but no panels are attached on any device tree, so the driver
will simply bail out.

I conclude that the hardware is dormant on existing
systems, so we can without any problems switch the defconfig
over from the old ARMCLCD frame buffer driver to the new
PL11x DRM driver.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/lpc32xx_defconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 120d6b18df9a..6273d90c420a 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -111,10 +111,12 @@ CONFIG_SENSORS_DS620=y
 CONFIG_SENSORS_MAX6639=y
 CONFIG_WATCHDOG=y
 CONFIG_PNX4008_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
+CONFIG_DRM=y
+CONFIG_DRM_PL111=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
