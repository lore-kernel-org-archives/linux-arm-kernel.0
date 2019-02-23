Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61637C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F93B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hReEGyrf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAc5B7k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F93B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5wYD8RApOAhb+oPaNg40rtZf8UOaMp2dKThtwNdjsUY=; b=hReEGyrfceVKYeHVIJDw1tkmE3
	52RKmIW07yAq9btZpkud1mMWh/+AgkAod7/OuKhs+7HAmwjNx6iDMn7PFpEgppSlaioIv8yeViXrZ
	wU9z9yOIokBh9MCJUtklnhECTOFzOPRIwNbguwsF9f6rvO2WfrSHPOo5wvunK60E/09kSyhJOYt8G
	FLiNSrSFQ+kPPML3zhXL4ocK5U7cIdXBGLHhaMWxXpjdumC9ySAuwpZHTyRtlhebMDkiS1M1Zzuxt
	H2cHIyTlWpJqQXFHA6YK9VEE90wcd89FyXC+ogGN/e5Z97Co0XoAdJpxfS775PdpMi/35J4Stjm2I
	1TMZxvTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX2i-0001qm-LE; Sat, 23 Feb 2019 13:08:36 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX28-0001G8-0B
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:02 +0000
Received: by mail-wm1-x343.google.com with SMTP id y15so4279590wma.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e7WizLNdunmkgpvUZcueZ9x7MQ1ttRLHdGjFtWenvEw=;
 b=XAc5B7k3LFdets0XOM7Vv1NwuvRTyprMF4KE1poem0QeAOBRSZaEkvXLvvMElE88UJ
 wZ+mJwCm0WJSRKSMlAzUeCt4HxQjin9Mf8yftyPSOlDVUpX0ZUO/hKWwuvDAJ/U9A9+f
 WWchtkd39iAka+FjXizc+PLkcA+mRkDq5yqzYSGIooAPzGssecRFkemdCPG1atmPDguZ
 OlanMP5QjHDkVZagrbFRyPHGXCv+KL7wHinLBt3X+x95Qut8Qa4QOdoKjFWgFyetK70t
 0xBUBYJZidOCdUfWFIbu+Dfx83Py97vk6qCDFJ4FEgtDKMwxpseVVy4m80hQ5ZS9uLMy
 9afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e7WizLNdunmkgpvUZcueZ9x7MQ1ttRLHdGjFtWenvEw=;
 b=Mrh5uNOauzPpk7GyW+yZHqp513tW673HdlT2cIa66T3Wfjy9cEk61LVTXR9T97kVb5
 5nAVzexB/+R5wRfqwnrbdLHaWXxgVQO/9SRyQfAxetXucYWtN0IxV25NR9Cx3M1w3izb
 P69z3aC+GGfCZB2Y70GAoINMsLIjnbWN8GX7Cu8gb0K5G4Y2C0YBwOdkAEv/v50rbewF
 NkNbpwm3FGRzGE6WPgRTsmXTKBxNtwi2X9KtGf1ipFhkfFxPvzFZvD4YsyA01cEkpBSN
 qsOQ+hBpjJENeNZ9Th5mKRBC9RuW+s9Hkh5nytCAdswwFQYFZr/KD+IIu1bK++u3TWBE
 s+9A==
X-Gm-Message-State: AHQUAuanUT9yFcK41rpwIJqH6LK2P8qSkumnuvf+7bEdHMM/JR5T35wX
 S0r7RSJfgaboVY0GRlUw3zFVzQ==
X-Google-Smtp-Source: AHgI3IZfB+oU90sDNEEorOPR/AmE5MOzpO4tRZz02pgmczh9FCuhWNQ56ReilC8uTjWJ9aQRTwRq1Q==
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr5675795wme.93.1550927277877; 
 Sat, 23 Feb 2019 05:07:57 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.07.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:07:57 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 03/18] clocksource/drivers/exynos_mct: Move one-shot check
 from tick clear to ISR
Date: Sat, 23 Feb 2019 14:06:51 +0100
Message-Id: <20190223130707.16704-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050800_038659_A270C286 
X-CRM114-Status: GOOD (  14.98  )
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 Stuart Menefy <stuart.menefy@mathembedded.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

When a timer tick occurs and the clock is in one-shot mode, the timer
needs to be stopped to prevent it triggering subsequent interrupts.
Currently this code is in exynos4_mct_tick_clear(), but as it is
only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
leaving exynos4_mct_tick_clear() just doing what its name suggests it
should.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..1e325f89d408 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -388,6 +388,13 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
 }
 
+static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+{
+	/* Clear the MCT tick interrupt */
+	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+}
+
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
@@ -420,8 +427,11 @@ static int set_state_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
-static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 {
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = &mevt->evt;
+
 	/*
 	 * This is for supporting oneshot mode.
 	 * Mct would generate interrupt periodically
@@ -430,16 +440,6 @@ static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 	if (!clockevent_state_periodic(&mevt->evt))
 		exynos4_mct_tick_stop(mevt);
 
-	/* Clear the MCT tick interrupt */
-	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
-		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-}
-
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
-{
-	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = &mevt->evt;
-
 	exynos4_mct_tick_clear(mevt);
 
 	evt->event_handler(evt);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
