Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A51C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7236A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VV1bqna9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v0mpWBv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7236A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2yGKIL1n/LRGQ+TKLp89J5zIWQfk4np/rjyh9DQRttY=; b=VV1bqna9ddNiYM
	7QNF8etgEZx9wThbJFfF+gTdJRLO/z2Y+bE10mZi4aLKDJzOSR174KPAKu9x8ffEoxqWpo61SAYH8
	iNST8mHvtJoRUHJff6NSIviBFq7t99aF8o8AR3+TPdOVEYG2UHMSbWAFhYuvxnwmcTFfHJC3xZytd
	8+aFsFIdhuC1b7TLE3JrIxMutwV8UZaH6rsWico1tmb2aT4eda0ijxaBegZJOnhWyqsBEqHTv4W5m
	8rXKaUWQ1SdbWnuXANcbJUKUkkBjve4dJm/d+lqyRg8MmTEpclKdPgk40yBOCb5et2b+xPOWTh+8j
	ZWOkYjKHhjq7TWlL0wrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0Vq-0000vt-1Z; Fri, 11 Jan 2019 17:22:30 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VH-0000JJ-FX
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:21:56 +0000
Received: by mail-wr1-x444.google.com with SMTP id t6so15958148wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2Gcim/fCIWXhuVX+s1fGkV+jOQ/IrIz2z47zga20lwo=;
 b=v0mpWBv6XnmUKe2KJf6RtmYvLh6zssMGo/7Ed3ozpbGOTYRh1yFOwAQChb078mvqPX
 OZaSfcTpR1T6yUy1cSjzISI40aI/EGfgn1eE+r4vs3mfScbfe22tG8J8bTdtOQn6xu0l
 WUw2ZmDgZuD7hLnWys90B/oxOBRqK9tMJMgO0Sg2kIZJ2/0AiwkIwa+qIYNyxQ9qtPy+
 n8AJMtZT4yJA2EM/y8KkUqRUtd244OVFhORDzCbxt79Dw/NHcQjdsosyVjErxNLJwZdy
 Xa9F7CNTfxz2+8PnXYrK2UoyYMME+CAKl29gW7M8Sw2/yCPaPG7lJ6Q1zSx3UTHUbd7I
 fp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Gcim/fCIWXhuVX+s1fGkV+jOQ/IrIz2z47zga20lwo=;
 b=KV0uNhWbgrP+t8NcBP8Pm0mk5juIp60X3esw4mX/wcAsSM27qzQ8z0AQRrSbDphhp+
 23wcWEyUq5lIhEcLSUsbTecWiiZgee9anoHW0JJkxYAWB9NuqmSPiU62AzUcaE46KvRo
 QDMXEvY+XLz2QgqFT/fByi/OCMDE47NJ2a8z9CqZ1rkq7USn8P4YrLgGsb7noLrMlxhx
 O2Zwug0mrvVEEIA9Js50pSTJCE1M96/2JUmfjI6YW29LQmx3KRaRQzgB/8n9wA+rd5s6
 TPb3wJ8QDf4MmdaMxCO6YdYekbVcVnYwf9zcf+ehI92jraK+rjxKmbqNSdQcgxJm9Tnk
 N7jQ==
X-Gm-Message-State: AJcUukeGfZMCNwDvCPaxHLMrsze0toX53q+AxQey1qV6tHvqSKT3HmeX
 N6ByF0u43yo5hWNTK/D8AdSumA==
X-Google-Smtp-Source: ALg8bN7+2jcKNRUdShkaj1KvtoUk8sph9ypjcGAX3tEGOZy2GuzEnYt1/hN+5muPJtVP0f2EK9Exlg==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr13869371wrg.325.1547227313793; 
 Fri, 11 Jan 2019 09:21:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/17] ARM: davinci: enable the clocksource driver for DT mode
Date: Fri, 11 Jan 2019 18:21:20 +0100
Message-Id: <20190111172134.30147-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092155_518292_65A46F33 
X-CRM114-Status: GOOD (  13.53  )
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
