Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD23C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:52:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA292146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rsyn6b3K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lb1VSkmg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yI2trusg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA292146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ev7UY7Xa3TUY7yBYpJr8w2M7bKydBJhKzKPB2S87xl4=; b=Rsyn6b3KtDGg+6
	xsXI/+3WrWHej5RjGPXex3FyuDuDzL0zaCUq2e/ITA4M06sJ/gQbgbyHJhDeNLunJcqLVJ9ABRJ6B
	TU+2Wo3ham+K2oHjrV5ghi6FKdvBVPD2eSvGwGo4OCjYUYQ4qTSJdE1TL9PIe3k98VDZ6htp956FE
	X/UKB4UVQD5IvSnBuTCCZ9mqUSkNvqqHcALJZMXzgFsf9aTHbYoN9juR9CN8AOGh1U7FQHENcZV/E
	yuzB3jbb13+gsrjdgUzBeQtAgP5ow00gEumWFpanFnxSbkIAqTfMEnctdJVE3hmCd124LkRsQ+ats
	ry53c5VBwAXk6K9O5eaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAKK-0005VH-4u; Fri, 08 Feb 2019 17:52:36 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3r-0007RH-Qb
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=; b=Lb1VSkmg67UZZrMnffDeEQqWw9
 9VQAxi/G5YvCBpn/CDK+9CV92hpxmfEDTozoA2SAGpjDPwBQVgRjHLeamNnR3dZ7A4/+yk5nlCeLF
 cihjGw8f0c+Y/y+Zua4OQuA36jNvsJHRw5tyoawAeGCrXcd8STKY69eop0wLCmVUw0hySR0plwTjQ
 hRicLITJbGgB7nRI9In38nnGnhiDIDULYD/Xtg20YRpD4fcE8sKGM1qHh+qoFeCXun47sLsrBaBKl
 oZrNKEUVgKEKRSE+GdOg4EDeED8zF98UsKY8yvfYk2/hfAplMuN0ILjOC1RVYon13mEYXvp2eEin1
 8wCmt+KQ==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3p-0005qf-I9
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:34 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so4361767wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
 b=yI2trusg39CqSSY1w5JVHaY8GJ2lA76s7TIlaufRNc+1O5UkB4tm3/3kJ1ebzOUJcl
 x7B+uRTt5tCoXT6wqScf+AU2LiyjQ5vAsWaotGEC8u3Tj+0DNlTsh4/JhvC1l/oSqsJc
 MGcNS2NcN9/axrZsnJuKojz5WwGdcqcWuFvSx0GGkgsvX7HTSNWAjFOnfpM41bervt1l
 RFa9Orv8b51MUA9XTFaey6S+GJRlQtUA7V6dyhsWaLT+TCTfS/1LOO7MjhWMaN4Cbopf
 MgCf/G6QxDyKHIuLos8WPItjzhV13bPCczU/M5m5EeTbwyc3TO+6XI6jueecJl8m6S8f
 wPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
 b=UnuNfYT9RbQZhRjy8ZpZ/x/z8tmuTOZtCSZ7e69Y5Oyc5HfBODgEcv4wN7yh2ERjFt
 GjnRlmJbNhH5k4LXHXbNuocuInMUlqGk4lJi7qdBwKJxFfY41wk9bBYpJa3p1WbJSqv1
 R+j62gIHvdaT6do07TSgG1FDOUCK68XAc/BsqqvGfiFOjxSCwSJ62sJoAv1IL/O3bagQ
 d4jgi/zmgSKBWU7kXn0mwwP5QpUuTjxE/l4J/Hdpz0ICWj6LDjrO7I4rvtnKgxUzjWje
 ALqVmTRlh4LZXeThwO5HieP1FMu+e6cAOu8BJuKGlCSBhw86r2OI1PYDx2ydrxC9UGpn
 WsYw==
X-Gm-Message-State: AHQUAuZ13amJeF77uovP0ugQY98btdzP4dvJxoICep1ICnDIDFg4Xpxv
 xpz4HTA+GpHOS8oUzLzxFDb++Q==
X-Google-Smtp-Source: AHgI3Ibae8GrffpMyzyML+a18ZhuluLag5gpbKjmTe+Iy3mLyhDZ1k1djQPSqMi4BX+CLHfZt3TvcQ==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr13151890wmg.42.1549647331524; 
 Fri, 08 Feb 2019 09:35:31 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:30 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 21/33] ARM: davinci: cp-intc: add a wrapper around
 cp_intc_init()
Date: Fri,  8 Feb 2019 18:34:46 +0100
Message-Id: <20190208173458.4801-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_123533_634757_4AD1182B 
X-CRM114-Status: GOOD (  16.06  )
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

We're going to extend the cp_intc_init() function with a config
structure so we can drop the intc-related fields from davinci_soc_info.

Once we do it, we won't be able to use this routine directly as the
init_irq callback. Wrap the calls in additional helpers that don't
take parameters and can be assigned to init_irq.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c     | 2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 +-
 arch/arm/mach-davinci/da830.c               | 5 +++++
 arch/arm/mach-davinci/da850.c               | 5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  | 2 ++
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index f81c92b9cf07..1ae7dcb8f59d 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -694,7 +694,7 @@ static void __init da830_evm_map_io(void)
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da830_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da830_init_irq,
 	.init_time	= da830_init_time,
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1cc49e7bf128..8022ca8ac4ef 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1522,7 +1522,7 @@ static void __init da850_evm_map_io(void)
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da850_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index eb6a9465f229..815f155eb349 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -623,7 +623,7 @@ static void __init mityomapl138_map_io(void)
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
 	.map_io		= mityomapl138_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 7f852722ff08..673d890c2e3e 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -461,7 +461,7 @@ static void __init omapl138_hawk_map_io(void)
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
 	.map_io		= omapl138_hawk_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ca903c9105e4..5cfd30c57429 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -821,6 +821,11 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+void __init da830_init_irq(void)
+{
+	cp_intc_init();
+}
+
 void __init da830_init_time(void)
 {
 	void __iomem *pll;
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 486d53481636..6df6994c0f26 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -759,6 +759,11 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+void __init da850_init_irq(void)
+{
+	cp_intc_init();
+}
+
 void __init da850_init_time(void)
 {
 	void __iomem *pll0;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ab4a57f433f4..1618b30661a9 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -88,10 +88,12 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_init(void);
+void da830_init_irq(void);
 void da830_init_time(void);
 void da830_register_clocks(void);
 
 void da850_init(void);
+void da850_init_irq(void);
 void da850_init_time(void);
 void da850_register_clocks(void);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
