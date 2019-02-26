Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33048C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:11:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10A120651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ju+cSBu/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wgn6xr98";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bFCjH8/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10A120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h+JXLkjO5hVP2XrKuHq3k6LQzj6NyUVZNL3L5md+Vds=; b=Ju+cSBu/t6luV0
	mYaEWtBdXbR/1EAZTiwLD8NQ0FdNwucJ716+fNJEi1FH5H7W/GjTFrBMk7xj1YmE1WwX3NVNZx+A5
	BnqgKUXnzE3H/N5SV74nfLbUQTLQ68Lz253+iww9ZwyLsdP6j2047IpDpO6XSuhJ9A/385288/pIk
	8Ai5d6G4XVO/AiK0ZznshybUgJeIgAhKulc4M6iihsCuN4ckyX95sfMDt1GN2xf6uaH16uxl4+A1P
	CQ5VGx17UK0dkloA+nnZLkrSQyF65CrvRLiIvWgRS6+LCxuJmVdfbQgkJd2lDQhA9A+qONIsZf3XE
	npYzkOusZdQi+C5PkF2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycVs-0003j8-Jq; Tue, 26 Feb 2019 13:11:12 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycVR-00037g-Fl
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 13:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgtIZySSgfZ+/sbHqf6H3YX/qq8lGhPHEAZWv6CiHLI=; b=Wgn6xr98IbHM6T+jKSSgLmVmA1
 SBt6KT+psAoilEB1mUNlaUtb9m+qn3VOn3Y1Loj4XaT1UqvslLU4ABpIbGU1fliaDjwUOkWEEN1VT
 zXHZXmejd8iErKNfVus3McUPqN11h5xIoqV2KuvOIQPGBYOhPfIhnaSuVb0ess4x+IZP7wMBDVAcQ
 tUqspDN8D8mEVrYMghkBvzXpkzIG9UBgvrC6L4T2DYLdCSEvK2uBWQWFvcgf1BEuoreKJoruSGmyN
 2b5jUU24Feq19OF8Pz6i1962y2g1Dr/oZRlI/jed8ZeVIF8pDVbDRQK8wFl21EDj41+1lErhbRZd5
 wcYA5EPQ==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWN-0005Kw-0T
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:07:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id r5so13650092wrg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cgtIZySSgfZ+/sbHqf6H3YX/qq8lGhPHEAZWv6CiHLI=;
 b=bFCjH8/G2/Y9gTTpN78bBfX80XNlNONWAheGl4EzNSi2CewFeCN3HMBG53/EZB9Ids
 IOctgcHOANWHFiPIH163gCETHcJuMLDIsvFAFolRhAfCFxNFSUOHU1Tf7zn3xvwR2PWm
 pkiQ4CIjV3x+6i/T6BhhWlT/HL67YR/HlHQ36FXIDPhaYJziYaXTeRXxL6+Hq6AIEvo6
 WbFfqSYFPsKFGC4WOlod3wk1/94NI6qSv8ekW+tnkTJ8JYC6K4bTW7JZW909oc8EWvSX
 AiSUhepIsDCFE8hFHXXXsp1gZQkk9JjNpl6Ua3R68z1QcaQRmYOo5nmD6i1MPUvP2e/O
 wB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cgtIZySSgfZ+/sbHqf6H3YX/qq8lGhPHEAZWv6CiHLI=;
 b=VRJ7L0qmVyKM9YG4yKiP2AcgrIpQRmWF2hbtWtIiun+ySMZy1WJRY4CBTuKdWpBS+x
 64rOl6lfw+iIvwdHrX35FapSN5EQR3dufimHS7kFH3K3hHFmTDG70GnzJIhcrGdp7HRA
 Dq8HkDnDAcqlKODLi62wtd4qHD/hMOYyA4ajDQgUX8SiR6HPY28TuZ8VR3P+1Y98viek
 EnNlAhS6jJUhnUaY/S1f1/phxxe4tV5flcJ5sSDqioBz14thbeINRmFg8ZTPaPn0x4QK
 bIyGwL/bLG5vjsEVa0Afd/BMEdiUE3oBVeJESjWgfAxVO39qM3CL5ldOH1g+7ZSzSstn
 HmZg==
X-Gm-Message-State: AHQUAuZQIYlfC0kFbaIIKxqWnEWv9646YfRIJos7IzxqRgpogWjPNXTi
 QW3iP0ZDXtRbC7VPbrooW/T/ZA==
X-Google-Smtp-Source: AHgI3IYTyeIxj1hlOuHawesccQBHZBDIC9FzYUcs32pZ6/e262nL7awl/UxSMmLbeSPYHeMTWH9fxA==
X-Received: by 2002:a5d:6592:: with SMTP id q18mr11442293wru.230.1551182854871; 
 Tue, 26 Feb 2019 04:07:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:34 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 04/11] ARM: davinci: da850: switch to using the clocksource
 driver
Date: Tue, 26 Feb 2019 13:06:26 +0100
Message-Id: <20190226120633.18200-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_070739_196108_EC68CEFE 
X-CRM114-Status: GOOD (  17.22  )
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

We now have a proper clocksource driver for davinci. Switch the da850
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 41 ++++++++++-------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 72d64d39d42a..5ce58ae0d764 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -34,7 +34,8 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/pm.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -332,38 +333,17 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-static struct davinci_timer_instance da850_timer_instance[4] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-	},
-	{
-		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_2),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_2),
-	},
-	{
-		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_3),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_3),
-	},
-};
-
 /*
  * T0_BOT: Timer 0, bottom		: Used for clock_event
  * T0_TOP: Timer 0, top			: Used for clocksource
  * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
  */
-static struct davinci_timer_info da850_timer_info = {
-	.timers		= da850_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg da850_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0)),
+	},
 };
 
 #ifdef CONFIG_CPU_FREQ
@@ -634,7 +614,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
@@ -671,6 +650,7 @@ void __init da850_init_time(void)
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
 
@@ -685,7 +665,8 @@ void __init da850_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da850_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da850_pll1_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
