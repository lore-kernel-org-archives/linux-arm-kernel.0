Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D78AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:24:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2535F2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h741qidG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iTIK/UK4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mvjl8N0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2535F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jXtJQOTmuB/+afq+ZY1r0EtzRiaZx80stK4pC1tyFHE=; b=h741qidGaSBKrL
	96bJ7UPZ406y/WaaI1roQAtnTNH6ZGx8mfVD9Gk9N1uxghfgiF3pBTcH9dEdilhHQGh3kz9iZoD6+
	LhYsBSVl8oxpGPl9LMKv2TQhc5GV2k1GHOd1YipebTne5bmyEler7rc5JmVnc2JjQ54Aa0lxLiLxA
	3yOmv5XNvbRDkPeDt1oluF2NhDylxWwXkSfQH4VfVujzHizDrdnrv4RgBGTcbIsunifWDK0RhyEze
	b9rBL4DcM7OGLce7ERkNmsjztoomFVHLUo+Y28Ylbw8Cjyoi4MZKYkNNClqH5IG7eV7oLm33O9jOZ
	ywxUNWd15Qa5F6G028zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybmh-0005EC-83; Tue, 26 Feb 2019 12:24:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybmJ-0004gC-Eh
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 12:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+q3jcIBA8iA3WrvXvXlUfFJ74Yle0NYMm3Gt46HxYFU=; b=iTIK/UK4+SvlZcD8TIYedrrvIj
 xYOUz4ITVtizlfEkJUadrn5i1gjaT98+C7cBS98k3HeQjhxH2B/Z/LTsXXMBhBshQ1tYuABX0kdVh
 MOFYLK07qBRhfE99EgmIelqSyb8ToGZAOK7/yO4TtuaMN0ofkzPH8atQeFSHuTWEc8E3D7d98/UmM
 xan/wC+Jb0Opsc9zNvF5iwjBQ5LpmhOeBOwTJQdFOqpaC+W0Y1ro8r5m6f08370goT9j9Ksp8JsYj
 xeNVK0vbcKPIztvwI2e8iuGLl0tMi1VG6HTe9AuS+HF7J45NmAxV9+VkWeLdiZ+VWf6/RaJWPer6G
 7cO0djRQ==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWP-0002mY-Bj
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:07:44 +0000
Received: by mail-wm1-x341.google.com with SMTP id y15so2037834wma.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+q3jcIBA8iA3WrvXvXlUfFJ74Yle0NYMm3Gt46HxYFU=;
 b=mvjl8N0+g+hn4opFddnHse8SksgrmWpS/elTMcdYj0HUEIx7AT34boE2axVsukHKxT
 hLyqaDhb3y/1qp6j5WnRzbjC//UUpQrZDg/ilmekFsejf403p8nCQDaiwm0aAxeRh3PK
 DqYAcGdODPF9V3uF4F1ke8wgBKYbyFyNlBMq4QrNBhKz/lGv+HzjQhINA9/+mWEj5wIO
 mmzn2seL55dL20c9PMcQ+2xAbwEIPEXDzkL4aOVW3Nxw2+VOtTUklwjHVwRm3GU0u3+h
 7FlkMpfEAORfQq6sOKYsawMsr/7ltoEmrfRGOqiq2gUk8hbJ0bWBZeUX2Am4xavSCJzw
 pBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+q3jcIBA8iA3WrvXvXlUfFJ74Yle0NYMm3Gt46HxYFU=;
 b=eMEzsT9ipEZ5yzjSDbATE2h+rKp3mxhQ2DDsqjAneBncGzVBXxjs3c8rmHbjadMnnO
 ehDf1Uc60NkYEcxP9W3zS+Pm6wPv+N7/B+Nd/G33LKKW9zs8vCWJ8cJdrt2wHNqUg027
 lkduCpIWjJtyvV0qGeNPh7OEaZQakDYnqFCYc7JNTny6qzdsDwsaNyaxgY73ppTDRPTr
 WLtZsR1ePxI80UeOGlPYYob3+6R7KWmIxVwh6brs5hk9SfN7uoifvV+FT4Fji9w9Qk07
 VzhB9ra3QX3u/F50pbQoUrAQLkteY0efFfqYiyIBNep+znmxUEeWUpItECWnqLQZanYT
 03wA==
X-Gm-Message-State: AHQUAuYSsRcJehSaWI356WWwdIkFY2wveCS0GSUSrBkZR74aJjCvhuw4
 YAe+0paseCcSbTLyX4OZiSVm0g==
X-Google-Smtp-Source: AHgI3Iaqo7s1CkrlKogYqngAGfKIzByX6AWdQJ48Pw2NviUKDV062rtGRzO7ZFJWv2cA2qCTnRHnrQ==
X-Received: by 2002:a7b:c929:: with SMTP id h9mr2442456wml.106.1551182860031; 
 Tue, 26 Feb 2019 04:07:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 08/11] ARM: davinci: dm365: switch to using the clocksource
 driver
Date: Tue, 26 Feb 2019 13:06:30 +0100
Message-Id: <20190226120633.18200-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_120741_648896_DAE58EAF 
X-CRM114-Status: GOOD (  16.87  )
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

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm365.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1d82bb630d11..84f5d04abf31 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -34,7 +34,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -659,10 +660,12 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static struct davinci_timer_info dm365_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm365_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
@@ -722,7 +725,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -770,6 +772,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -788,7 +791,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
