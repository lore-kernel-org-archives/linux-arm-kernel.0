Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134CB2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/uclyMz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WpetVQL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134CB2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pPW/3e3TAiExgpnZpWFEi4TGRHxJv8tuWZr6DLfORAU=; b=X/uclyMziS6Ktk
	nvGlimMUbJPkTNwKfssklpUx5RPw3YautZ/MTWS0xslcAadjR6WpZCLMXvEmeySW6ns0U4mmgkVZu
	tG+c4/yaIWK5alAx3BQ3+dTlSR/+QIGmv1m0x/qiBv5/Qf5H2ibu4y0gNVfBskTb/gFJAYVZhgUE3
	/saJRuG0Dug3UrEJBMZKIB2Y7Ldwuxapw2mj+l0kWZNaN2qU+CVj3sKGA3+YkuecisRqBTlbpZs+o
	h9mgO/Dz+jRMGXuSdU2VrvWt6dSh9sSMl8+scsot3eO6fJgl+5JFanCQoUzinbNiryFyU10VfArlh
	hjYrIp/l5/RWURNU8yUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhtL-0000Vq-BP; Mon, 04 Feb 2019 17:18:43 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsp-0008Sl-Nu
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:14 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so668661wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vqxdWQN8UOwRccvQcL/hEimhgA05XyRuysVUHnsgGlE=;
 b=WpetVQL+Y39MOmc0TFXx3nwd5DqaB7TBISMMXEGnBJS44XqFfJs1sMz9qm6yKoirqV
 YUUU7SvxxgDershi/qrEzz8b339FBa9/sl0yedYMSKBm4DZuxrSSoiYAGx+M1nzV9qah
 KVI1Ot/2TarQaYfFq5xi4hE6fBnFJI0qpTHER1McU+GhMMkGN0j3V/8AUQSL7FnV2ZR9
 rAgTo+lucQZLcTN3QmXEH8vQtape3Vvv/YpXxzMeBOnjxSQCmX8RDHNwlOTyp02Od9Qk
 tZnRs1Wbbfrz0vR+4aQXYSJpBB/yx0WMU7Pg++NbJPJy3hV4tt5Gf/w0CddB98gsZhnV
 dmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vqxdWQN8UOwRccvQcL/hEimhgA05XyRuysVUHnsgGlE=;
 b=et2L6CUVP3cgrP1KgMP/x+SsyB4cGjx9UeWktQyXRJJwZ/NsZPpCXnYJrvh80ugKD8
 zCenKEp/ezZkO4+T95Jwb/jr7W3COn3qZS0SMtKeYe9G82NefeAMxy5TZuut+7Rni9r3
 ud8tgp3mNS4WD1Q5g4LUGKdzQCZtC0OqsmYV9lt2zGziRK93pcNQuty2itgiwLYq6548
 qfTnvwpNatpyTGt1WCLztb2wWGWngxNCtLh818+tJk4agh/MgOsQ/I261DtbVFsy9PCz
 0Gog2GGAQVtzGCUV/fDGQFdSCVNHDn9mBsP6gG3pMUTxz/gdWWxKZ9y4/UpLWZ+NbMlC
 IByQ==
X-Gm-Message-State: AHQUAubAINArPh7z71/0gKRF/oQFTUu3kQb5FFK1sHAcvyFSaeQniwB4
 LLZ0RYuhDwARXEj7fRf/cc7idQ==
X-Google-Smtp-Source: AHgI3IaqpKtLUOCLvvumTaYWrnTPDl+3fjRJWz9cgc+ShD7qaSGXRUsfEwT70UesxRKyAlpsKCZeiw==
X-Received: by 2002:adf:b649:: with SMTP id i9mr370979wre.70.1549300690407;
 Mon, 04 Feb 2019 09:18:10 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 03/12] ARM: davinci: enable the clocksource driver for DT
 mode
Date: Mon,  4 Feb 2019 18:17:48 +0100
Message-Id: <20190204171757.32073-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091811_822358_A145E6CA 
X-CRM114-Status: GOOD (  14.61  )
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

Switch all davinci boards using device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer to be built for
davinci_all_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..8a09a0ab0ce2 100644
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
