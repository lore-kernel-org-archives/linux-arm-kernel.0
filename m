Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852E1C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:47:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FCD21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q9N0DLw/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkLaW5tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FCD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dVXuYQ0XVsxKRe8pOKsdtro1fhJxnVjfByjsLUxf9JA=; b=Q9N0DLw/zfkJIj
	82M8XmSmIhCbMESqaMRtaeMDP6CJQuo4lbp3NF8QpgogHhHi4YgbAVRE6g4EGmtPsZKFW42mLLLJJ
	+IXy9CaA5DgWR8NiYo0pfQQZ/9vF72+aDFm2WJFTiMDXDL54AbqEGmokR8kSAj43dtiSdb63w/QmY
	yX32YNdzuciJ4Y01MKOnpAUrHXEQ7/MNASkxXhTtN3yeqlvIjjyUPaId12hkZXV2Q6pNgjBkSR3iB
	xFmratrBfA0XP1N5iAzasbqcWsFPi3vo643sAhovocbL28R365BrfwuhcE7jyuOV2AS/z5GhH5NZi
	d0eaK/Wuj7oLLGTWVHpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmECS-0000oA-97; Wed, 23 Jan 2019 08:47:56 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmECO-0000nb-49
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:47:53 +0000
Received: by mail-lf1-x141.google.com with SMTP id c16so957368lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bTEtgwaiyHu2MLgfJnZmLldyBLicnnBLYJnche4YZA0=;
 b=bkLaW5tqsIgXaxIC03Zxu/9Vn/xAwaOVO61UADVVBEmt1njGH6hUpok0yg0CFIf3q3
 2h2XOXK32MAwAn+qAY9TJO3zou9eIh3zoFn/ShxPMWuTBwnQKgMxCGBGOf0e232Y75uI
 XF0XSW+AVOgpllE8CRsuFhOSfjNifdW3g+Mis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bTEtgwaiyHu2MLgfJnZmLldyBLicnnBLYJnche4YZA0=;
 b=FNwqVafa3cxdTKJKaj2gT0xCQ9DCBZF4Fw911UdZQK+FAiQJdGehOCkSg6nJpuQfVB
 DAS0mmrn4FnaDQXqHp3bTJb6rt4QxVWzge4S256Vr8WxvJk56dSyECqFGWHDPeA5h/Kg
 dpgzkJaU4QjpJmcW61fWibrVmhEhgfw7nEeRLn0nn5U4p1UqyeO27pyEfDema6CrCxHx
 s5neNaM/UBS8Ts8ZqYRGK45UYAc369Jj5iBpYFkSJe3WIprEDUnkYh8BNu+3BI3p4Fde
 LfMYtYORyd/onnbHFU2GLS8XWjzj1UoxWFFcURMvI70dh7vfRkNwwMq/d6ebOsZCHxjd
 SBWg==
X-Gm-Message-State: AJcUukcAhbUL6YWk2VqRk0WdiqzEiV+Nnph/UNTuTWse7cSxG9cxVt38
 /RTp9IJfBrC2NKpT3OlvwjaGJg==
X-Google-Smtp-Source: ALg8bN5mONvw+G+qkuOVUlSCEecDuJgxf4t9f9cnADpvVIJXVo846Z7j0lR54Li9J8X6ixM8KS9VPQ==
X-Received: by 2002:a19:5402:: with SMTP id i2mr1078927lfb.128.1548233269938; 
 Wed, 23 Jan 2019 00:47:49 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id s62sm377067lfg.34.2019.01.23.00.47.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 00:47:48 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH] arm64: defconfig: Switch to PL11x DRM driver
Date: Wed, 23 Jan 2019 09:47:45 +0100
Message-Id: <20190123084745.29905-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_004752_190298_96494D7C 
X-CRM114-Status: GOOD (  11.32  )
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

This switches out the old fbdev PL11x driver to the new
DRM driver in the Aarch64/ARM64 defconfig. Some ARM
reference designs use this IP with the Silicon Image
SII902x HDMI bridge so activate both.

The required DTS changes are already in-tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for v5.1
where applicable in the ARM SoC tree.
---
 arch/arm64/configs/defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ef443cfbab6..139aae646456 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -485,13 +485,16 @@ CONFIG_DRM_SUN8I_DW_HDMI=m
 CONFIG_DRM_SUN8I_MIXER=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
+CONFIG_DRM_SII902X=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MESON=m
+CONFIG_DRM_PL111=m
 CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_GENERIC=m
 CONFIG_BACKLIGHT_PWM=m
 CONFIG_BACKLIGHT_LP855X=m
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
