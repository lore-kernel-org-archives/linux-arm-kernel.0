Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C52C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2268A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ayd9EMf3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="FQN9DBH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2268A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XC+8GYieM5CaWCVs+SJuTZNxUNDoF8dH2AtYcu0vF6I=; b=Ayd9EMf3dsKynrXUOEZEE1LsaF
	jS7gZf6R8fcDqE+UgbYC6vfRLVQTvDXsouiYYoFgDqF/6kr1tJyiPiLLJ92rkmqR3JPz+pY1e6O2K
	zw3T2BEQmroPs6iqwDo0M33ybHy/Bo4hRlXVZCntCPICVwai6uIQi29EQJObIyfXtB6QREqWqN6Uz
	LAJpSTn+X5o/Nc+iVuEZpmKDUT/Zbr/tGR9rK8mnY45RUyGv98sjfPjWFXiwyoVwigR/Q49O30brU
	SkBSoDfnh6f8dV5IkNkbb4BNT5ndFyM8b5IrpEvgchGYkZ0SECWt9qoJe9CAVIjTvQdtMHnCXvFw5
	14IuQm1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsxwk-0000yK-8y; Sun, 10 Feb 2019 22:51:34 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsxwW-0000oK-Hu
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 22:51:22 +0000
Received: by mail-wm1-x343.google.com with SMTP id t200so13470588wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nIdxf4j3KnD7oNy9LuC6ROOVelJxc6kOF3KEKzbbZsk=;
 b=FQN9DBH3yJUGgHit/7Gs31JZ6yXI7evBdhm03ZWaTwBWiuM7qP+xUFJ3h4NCV6s70h
 Fm2Y1411mgMAf0ZyaupkxkYX+caDJWRkp605wqPXpqfoXWmZsMsJkvgGCev7w6ABkOt4
 BG0BykM9ueNXygRr5Yv/ErIG39yRQSVJWLqOcpX++zbXr3QK3XCCcZ5BQ78rmpcSoGuW
 OmgmHRw1uKGcyU/ZIu4BcSPYBtbd9wX1u+6pyKJGaAWtRRoEbEzyC3a7E3beXezqyCXc
 D3MXOP+VQpjrRt5dwbMSI35madC+42o6Ua+Jzbfv5lsrQEYKOfpA9bNbcO6t/EbZkGVn
 GnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nIdxf4j3KnD7oNy9LuC6ROOVelJxc6kOF3KEKzbbZsk=;
 b=Cy11PxploAWs4OuoyzFOdn2MIgpXTacdOvkQAi7IRH+K8B9SeZWGFTTMlDuFJiDV66
 YimIxnAG7D53HccKevZ4JXZxGO3WGX+mDi9jBdl03FxWjZNn0H4DPo0YM+qLjxrH65/r
 Ghu75bvkiid8u88AActfsibksNMWDYkqc+GmRPyiWUQjDOZkMu/A/i52tjPLh5fapKL0
 f8fz+caE/yHnbam7RjqhzIKA4iKmcH/TTBWBwqjwndAQVZImtHph7yEa9nn0GAteecO2
 TvGi2J7hmRPTd09Vns1TxX3BH5fyWfZhnYUO/RMtHrjgdPXea9xv/HiyJU/1V91bz4Yf
 4HZg==
X-Gm-Message-State: AHQUAuaLRCSdeEb7L8xn7ouxcmDyGD/jUB/81730Qg/B9UdOLglvsU9v
 cXB7CLG7TqbNVEEEvOv5c6ERAw==
X-Google-Smtp-Source: AHgI3IYF7h43g1CP/CDeb8vtCTWWwEjXO0VVxxT/wv42bMeamEthbEwi9vSE+7xxgm+u02hIU/H6cQ==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr20116413wrq.161.1549839079055; 
 Sun, 10 Feb 2019 14:51:19 -0800 (PST)
Received: from localhost.localdomain
 (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
 by smtp.gmail.com with ESMTPSA id c139sm3904325wmd.13.2019.02.10.14.51.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 14:51:18 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
To: linux-samsung-soc@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] clocksource: exynos_mct: Move one-shot check from tick
 clear to ISR
Date: Sun, 10 Feb 2019 22:51:13 +0000
Message-Id: <20190210225114.20110-2-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_145120_586454_F5DF7380 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: Stuart Menefy <stuart.menefy@mathembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When a timer tick occurs and the clock is in one-shot mode, the timer
needs to be stopped to prevent it triggering subsequent interrupts.
Currently this code is in exynos4_mct_tick_clear(), but as it is
only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
leaving exynos4_mct_tick_clear() just doing what its name suggests it
should.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
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
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
