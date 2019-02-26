Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71861C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:10:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A022217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ueN6hZoQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FlZSLv7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A022217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Si5lPtLCo9198kZRGA3wDyZz9VSdgqTyBMqDOCZB54s=; b=ueN6hZoQ41cKiT
	gz73hqllpX2Iv72ETItuWadSykI8oW6MrwZmBCfo5p1PhVAjw40drjpjW2T+2LIBq2ohUaro1J2Qv
	BeFqmaKdn14qo8SmPin0ZBaMMSz2XdOHADuDQAvVc1gxPql7J+sujS8/zy/T6Qj6XpHbwc242kavc
	eAnpiFVMnhVkkg56uZ+CYn5bb9NpD8YE41NfnKaYhudJNMOrUjV5d8CFY/xYamgwH3+trcBILAk66
	yLHGpjfLbEl3J7WwKX3p6fnb1TmpHun7AaibSDb1Nb5k5Hcrn+9+Ha+pDn3V204+4c0xgjxZNF9Z4
	vIr6EvWu2TYp1d/9cNYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybYs-0004p8-0v; Tue, 26 Feb 2019 12:10:14 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWI-0001MK-07
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:08:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id g12so1590842wrm.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AmnSVQdTfbGKlefXWSsyV37QV8Nr2Ok7q6FkkpWXde8=;
 b=FlZSLv7otsdiPABD/OcgNwvBy8SQ2V4fgpJVxYomW3SiwbCcmmzKIzqmIxYoMdNt7o
 K6SVjvE4Nywt4+DwWGyqBM/1wwwOFLO8ZmRUYDpunaRdCHWwGYRFwlG7fbLkb+PiJUKa
 HLn8Rr0TKMzpmeBnt+Q/JTabR8Kj6h1Wv2KPJ+547Se9qVcvu0lLJY98v0clHJQyBJWu
 XXLl+I7S+9/GoMo3J+scjPw1qDLWxrzu08I5asNM3FOgKxX+Kmy0FoDzlkNftwYrJocY
 uMUvtTee5nVzNV7aGU3aHSrvWOO+rI7chfp1JLGGb3lGvNAUE97QMaAKlln4aSddX8Lf
 uX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AmnSVQdTfbGKlefXWSsyV37QV8Nr2Ok7q6FkkpWXde8=;
 b=Sg6x9DNQlNW06htS13F1vXojSBKEG/Oyt0m25npsO2j3dxScCwcmynYmtJPXlaxkJR
 LVsa/tA4SoSN17H9CezkwNVu94i+pRtOM5ik7az79N91PCaMI7v3TTLZPTjSStVdO/BE
 wZWWDEWqbr2U6QKDLOTAw6Jwyp8wB4fDNoBbEGnjSl9mS0diMxMr6tolgLDTURciBx83
 UH87QBuLCOCJqlqQLxGfbGiSQZOCUPQnXwWqaoF+uCQqYj47lsr9ETUDh6UAzR4Y+lQv
 XlS5934wG7p/IcI6VZ1xine1vOg8rc/F7J9SxWUcMYs+JmEkhJPr0Y7rDOLyjQTZLVyD
 //ZQ==
X-Gm-Message-State: AHQUAuYW7j9dTYTmGOLIrhArUX9q7mRXCgVNlgPIklvNUa+4E0q42H/9
 I4Kov5eJQCmNVhYDIxdUwSo74g==
X-Google-Smtp-Source: AHgI3IYCdNyaujemoePtKT2MpyWub+GOJHfHfPbRf8DMum6dJLYP//Zds7cN3YocizjowMtnswornA==
X-Received: by 2002:adf:81a1:: with SMTP id 30mr6488983wra.285.1551182852040; 
 Tue, 26 Feb 2019 04:07:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 02/11] ARM: davinci: enable the clocksource driver for DT
 mode
Date: Tue, 26 Feb 2019 13:06:24 +0100
Message-Id: <20190226120633.18200-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040734_676333_B1B147A9 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch all davinci boards supporting device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer for ARCH_DAVINCI.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1037f49e050f..da414692bd0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -586,6 +586,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select COMMON_CLK
 	select CPU_ARM926T
+	select DAVINCI_TIMER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 5a6de5368ab0..740410a3bb6a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -398,17 +398,3 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
-
-static int __init of_davinci_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	davinci_timer_init(clk);
-
-	return 0;
-}
-TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
