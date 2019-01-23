Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A5C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:42:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA88B2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sNP/4X96";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iL1Umhbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA88B2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=a7N3c6rSXxAy36XBz7KZthz5KYKEM62yLauMQPMX2lg=; b=sNP/4X96QMK5K0
	wVQPOXf5F16A1D3w5WRreyZPI8bby9dL7vdJpudRuGTY58lNqb0vTZJ3bMgFEVpIWN12aOHfm18B3
	tDW8SF7MflvSASmZgUkZBhD7FX7Cq6Ct22YkZOcylzQdvFh8Q6+If1YcLxi/lUieXZnVXYQTSE11u
	YTB0l+SYUK5mya4LN2QJuEs1lnCwr2M3p7il09DXWaPZckesEuMGHF5UqjKAAUagmg//EMkF9NGxv
	groBHmBWU2f+i8r4Ohzc/gt/EjZB4ozLJrYarJAjL8Fz1cpN8KU0w7nNK4KBVcrVcln7wXYbGk2KA
	M/eqDUFRFDKJGgcGP0Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmInW-0001w2-EX; Wed, 23 Jan 2019 13:42:30 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmInS-0001vd-Bp
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 13:42:27 +0000
Received: by mail-lj1-x244.google.com with SMTP id n18-v6so1959116lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YV5/MPpL3qHWdzQFTty5pTlYLB2BG/E/V7eHwOIe1xM=;
 b=iL1UmhbwQKoi+KdhKPnZvUQ+sMxrWISvo7UKQjvNr7YjI3AseVRtghMNPtNqBIitvH
 11cQy23vOIv21jk7O0oRZKjvIwFbCt4lOO+QAkPL5vHigom59Pee8/42SnQfEEnvizux
 xH3sjIm+EODeo4g992ndUIDH51l20H/vE9ZSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YV5/MPpL3qHWdzQFTty5pTlYLB2BG/E/V7eHwOIe1xM=;
 b=BkqlNoR7G6gvVuP4ga88yJR2xwsrSu/AcqzIU+gNwM4eE/gvdi0ghBd4omidok/S2r
 rfcYx6uNhi/4N0W78gKkEvbZJH9PyolcwuwVC5d8nD4hLTwmfff09ZuU9uUdc57K6gkz
 xq8BEPkYNwiFKRePtDNtOJCIgzK5pG2CtgsvenF6II+LVbPaWsI6jx/3Gx7FZDS+Rbfc
 oTHN5sJ3fRsmsqFC2p1zB54nOfrSHzKVAv351v8AJpyy9CSoaUhq61Gh0rd66rfpJ8jR
 h7fDn3waePUTEFSGiim3OgmhUsWTiR/DqDbnn3LAZVa8X1jk862i1cbKnJFdn+y/74EI
 VdIA==
X-Gm-Message-State: AJcUukfx9dFPQZddBF7oBUYek9/CR+iGIjc62PGEITZb4RgDATQiwzlE
 FFBXEj1+9xSYt8GEwQToaf/3ocS7830=
X-Google-Smtp-Source: ALg8bN6RqNiQAXNZbaYRbQOhhvFhiCvZwahpa7ti5LOxHXMRWktFYyB72Dt+/S80+F3e5lV8jXAStQ==
X-Received: by 2002:a2e:9256:: with SMTP id
 v22-v6mr1855817ljg.178.1548250942315; 
 Wed, 23 Jan 2019 05:42:22 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id e97-v6sm522613lji.51.2019.01.23.05.42.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 05:42:21 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: defconfig: axm55xx: Drop PL11x graphics driver
Date: Wed, 23 Jan 2019 14:42:19 +0100
Message-Id: <20190123134219.15336-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_054226_415571_43E82125 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Krzysztof Adamski <krzysztof.adamski@nokia.com>,
 John Logan <john.logan@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The defconfig for the AXM55xx includes the ARM CLCD
(PL11x) PrimeCell framebuffer driver, but the device tree
for this platform does not include this hardware, nor do I
find it likely that this chip has graphics.

Drop these config items.

Cc: John Logan <john.logan@intel.com>
Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I don't know who's collecting patches for Axxia these days,
shall I send this to ARM SoC myself?
---
 arch/arm/configs/axm55xx_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 8e17e7ed1f02..53864316bee1 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -155,10 +155,6 @@ CONFIG_PMBUS=y
 CONFIG_SENSORS_LTC2978=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_HID_A4TECH=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
