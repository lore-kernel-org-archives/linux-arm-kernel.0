Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0504C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F55C217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bbW2/jfI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FGm3u9DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F55C217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QVCuSy16ArfWMvJIfhpzcWZzpCgeWhqOCSqH7dT1UEc=; b=bbW2/jfIQjvn7a
	kFpdTW84IO/dE8gOIXss4DM8Q9CP2KM4xcwQ2sX/AlEH6w4Nf3+534oHc/yM1XqyqMVrQxcs3O5aN
	vGwj/EnDeTjDblW+aHmfMvDWqK/qjxo4IdwiMq7hUdma+sq0KyprIaKyAG7RauUTGBbxrQrtKGgR7
	wbjh57BMS/PVidKOJImai9Az2He/EdpgTWSCBZUPI7cXs2tL9ysO6Lvt3YmYMfpgqkQCttPsSQ4DD
	4xbObIqV4sRz3zmPu0HtLVLbTKOhz4jq3PekNqTwZqA5RAGVcoTL9TQ5BqUA7bTRM3XQlKiq9ZWbB
	oGUQhMrYYDHXaqga5jhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybYF-0003Tw-9B; Tue, 26 Feb 2019 12:09:35 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWP-0001aN-1b
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:08:06 +0000
Received: by mail-wm1-f66.google.com with SMTP id j125so2022137wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VE2IVgiudVj0ad0e2GVjY3m8TiyaIXTiBa0oo3vwdL0=;
 b=FGm3u9DCsaI/NPz58hR4bTrFZT8EG73EVZNTqUyHb4ICRME92KfhoXJxtrAp0lvuV4
 qOfiOYdYKGFHduQfUdLXbG/y8q0JSJH9HoqZMLa9meTpxVp8ekxGLXxYB+8BA9a7IYYo
 iueYICu+CnKy233T2N4Qw8joDDnmd/PeMXpfabT8jvmJq8dt1PxrVAdNJ4xZBO/T71rk
 WN/LqyV2eglnDSWE2Lsk9XX1es+HKt851KXqnbiqE9lB8mj2k8X08pEoPypzJ6Ls/iUv
 3GzW3wqvS4wQlUR1IeTxUbX6hOxR71mTMPnw9z7QoEawI2ugeEAr8oqyt594OBrKCoJ+
 PYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VE2IVgiudVj0ad0e2GVjY3m8TiyaIXTiBa0oo3vwdL0=;
 b=Sdt50SzkAdurmJ2Xe1jWZN6O8bAsX3pwNvw1yv9uMx41koVCAiOgjX5BCEnS/FtxLm
 TyNjgCtyaOZwKsPW4f9RIuqLUgl2rErchDP9G0+MrmBRg260+8pGCEcU3X22a7yHusyl
 xotOJ2v28mt/lxSF37y7gPpgKsYQByFhIhQmD9IECT5NhuR+APqIdSg3HlUjjAlrZYMQ
 OpvsnCJ7TbrrenbKIPma6ZLjsmz1df40JKEJY6iSpkjVGTxWxORdmMGqOLGoxaRLGXo6
 70+Dr5twcfl0OGxBCzAlnpS4Rx8W2K18FavgeJYc3YdE1sN0nzSZJ3BLbnWoGx2WuTbC
 5gjA==
X-Gm-Message-State: AHQUAuZfpi5URqdtNJNFMgBzI/6BXepgUVeHgGiQ4FtWEWb7U9FYzfUG
 3OqB4nPmc7lbU3m4stL56TljnA==
X-Google-Smtp-Source: AHgI3IbKMBOtb+y4PCJ0kZslqk2FwUYMcPtUFcglJEru0xSUvzn+T+R+LByZ4XHw7ei/qDrGg3HB1A==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr2434851wmj.152.1551182858798; 
 Tue, 26 Feb 2019 04:07:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 07/11] ARM: davinci: dm355: switch to using the clocksource
 driver
Date: Tue, 26 Feb 2019 13:06:29 +0100
Message-Id: <20190226120633.18200-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040741_558597_83B0CD42 
X-CRM114-Status: GOOD (  14.89  )
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

We now have a proper clocksource driver for davinci. Switch the dm355
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 57c5a660758e..c51a574c1b4c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -29,7 +29,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -624,10 +625,12 @@ static struct davinci_id dm355_ids[] = {
  * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
  * T1_TOP: Timer 1, top   :  <unused>
  */
-static struct davinci_timer_info dm355_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm355_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
@@ -705,7 +708,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
@@ -732,6 +734,7 @@ void __init dm355_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
 
@@ -747,7 +750,8 @@ void __init dm355_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
