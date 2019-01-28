Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C528CC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9572148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HcnlywXC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdRV1j2D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ETuq24SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9572148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jCHrMZR0Cd/ZuHtN2rMIvsqCmxSPoCGhou7UI7Z7W38=; b=HcnlywXCLwg8mK
	IujWEXrAF6iDFKMswK4RGZETCR/N7Nu0Iu+G/ilarkc0A/M1ypgcnGhXDPyTw/8gBCMcfFaDboxjb
	QbXQsQ6GunQ8vTKXTuZpuJGJTCbXfPEGDjLqSPF9S8/het7Vpv/gjPcb6FM9TGovlX5M8eGADAbX+
	UuP9F9DrOrtPrG0jVi5HCR+tBvNtvuR3Hwhsdujfw/uQv6tVDyEMrIm9ZFge79IEcqhbamoW2o9ks
	ghtOw3J5ohwNjX3coqFgpcDDx/US7TOnW0oelpIjtyTRmHWB2rlBhvwU4/GaYdqKYX7WYkzX17c/Y
	gXnzI0m5iME4GTfpX39Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBKg-0007p6-LT; Mon, 28 Jan 2019 18:08:30 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBHV-0004PV-Nn
 for linux-arm-kernel@bombadil.infradead.org; Mon, 28 Jan 2019 18:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+5f9A0owJWTYd+3JvitHCSPw9imXDTHvj+3LfT3bYOk=; b=cdRV1j2D0B7bp9DtUPxJk17Qbp
 teNQtHRn4WrRS7mCjDQNJKyrkBhH/t6jU3hqWLl3NQHOnrfF2RFhUOZ3V9MS/7qZFq17Wxik5NRZJ
 RTzemQca5b2L/apSs60I2+bvE+huTiFwkEH37A9WHBmaMxNFQTf3kOlz0wBV/ieNyhhFoGdodktZO
 9EpN3sFk2PdE8WziWrazr77c/0tbcQGiXgyUDtLZlx+ozrqmDMuuovb3Gsuc5hjqR2Jp0mTmgiSC4
 2HPkmY0GfyIXRsERyOu+YWP6usmcWUNgPe/idIcAfwDvyfgwR+AaTqeNtV5k0e6jJpXCW6b0+WmeH
 OaX4VKxg==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBHR-0002uh-Bt
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:05:11 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so14883483wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+5f9A0owJWTYd+3JvitHCSPw9imXDTHvj+3LfT3bYOk=;
 b=ETuq24SZivIvXbXZQMQiQzMYvQn/sT+AacURDekfgymKKkFu8yGWenSI4vUAtGbe+u
 cBjG+KHy7HrDl2qhC9Bsp/0ZINUCoJ3x7GP5EXS71l14/pgaX2lwZUun9mSTyw/koB9o
 sx8UxbLWuREoOXv/Srv6L1/kVio1yCy2+K/CXDy8r0NsgE5YA+V7l9qoR9Tz0ZjZUCz5
 fE0/yN+RssTvAWizB5QRodcm5YL5lY5o2c0bwtF6XYJNO32LlVHz6WJmbQvqf/deB2Zp
 SpM6VxA8f9bIGFqneKoiba5GPTreRJP+NisVYvFF7V1LUOzVuMdc13tEpKP1WnyfWGIP
 a4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+5f9A0owJWTYd+3JvitHCSPw9imXDTHvj+3LfT3bYOk=;
 b=NrgmG/2mS+zFzz85dpijbFScqssjd39GYzdZ2WQ5nNHhmqOYIgk4DaPn359kG8TVHE
 LnyYaD7GfCtkqIxnyshpDk6CVNo11C72ac1G5jHBLcpwNAV/0FaGlbpXIq1PWVH6PYaB
 oExvbsf/4xTF1ErXnlRzd67PdtcarsVNDufH29D6IG4BQoc7mHxBsN9qNzXdmFAQiTZy
 KYGQqNv517cOK2BiGVKXeBGVRypDDSyhB5vlLHjwfKiFoI01+14pr4NkXppeVu9VhmSv
 dQfuAfr11jbsxGQGQL3TghECs/AJyDUG7myg51a409B934ICRkIrTLXQB1FUVUphGtfJ
 SFIQ==
X-Gm-Message-State: AJcUukdHahIXtswwLIeVc2jeuSU+Ep++5JpU8yamfYIgpZvyd/yxW/Ot
 6k+NFC2Z14ERWkXjvdQT7ROxcw==
X-Google-Smtp-Source: ALg8bN6k298/NJi0b7cLi+OrdmFywtfHwPwOaIFMaHfwxuqMYGiXLkd08l3a+VUxPu7kE3ta1cihPg==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr18947083wma.114.1548698705527; 
 Mon, 28 Jan 2019 10:05:05 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.05.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:05:04 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 14/14] clk: meson: rework and clean drivers dependencies
Date: Mon, 28 Jan 2019 19:04:30 +0100
Message-Id: <20190128180430.28689-15-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_130509_427166_2EB17D17 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Initially, the meson clock directory only hosted 2 controllers drivers,
for meson8 and gxbb. At the time, both used the same set of clock drivers
so managing the dependencies was not a big concern.

Since this ancient time, entropy did its job, controllers with different
requirement and specific clock drivers have been added. Unfortunately, we
did not do a great job at managing the dependencies between the
controllers and the different clock drivers. Some drivers, such as
clk-phase or vid-pll-div, are compiled even if they are useless on the
target (meson8). As we are adding new controllers, we need to be able to
pick a driver w/o pulling the whole thing.

The patch aims to clean things up by:
* providing a dedicated CONFIG_ for each clock drivers
* allowing clock drivers to be compiled as a modules, if possible
* stating explicitly which drivers are required by each controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig  | 82 +++++++++++++++++++++++++++-----------
 drivers/clk/meson/Makefile | 21 ++++++----
 2 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 2479dab09d70..f2e757aea4f1 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,27 +1,47 @@
-config COMMON_CLK_AMLOGIC
-	bool
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_REGMAP_MESON
+config COMMON_CLK_MESON_INPUT
+	tristate
 
-config COMMON_CLK_AMLOGIC_AUDIO
-	bool
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_AMLOGIC
+config COMMON_CLK_MESON_REGMAP
+	tristate
+	select REGMAP
 
-config COMMON_CLK_MESON_AO
-	bool
-	depends on OF
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_REGMAP_MESON
-	select RESET_CONTROLLER
+config COMMON_CLK_MESON_DUALDIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
 
-config COMMON_CLK_REGMAP_MESON
-	bool
-	select REGMAP
+config COMMON_CLK_MESON_MPLL
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_PHASE
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_PLL
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_SCLK_DIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_VID_PLL_DIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_AO_CLKC
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_INPUT
+	select RESET_CONTROLLER
 
 config COMMON_CLK_MESON8B
 	bool
-	select COMMON_CLK_AMLOGIC
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select MFD_SYSCON
 	select RESET_CONTROLLER
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
@@ -30,8 +50,14 @@ config COMMON_CLK_MESON8B
 
 config COMMON_CLK_GXBB
 	bool
-	select COMMON_CLK_AMLOGIC
-	select COMMON_CLK_MESON_AO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_VID_PLL_DIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -39,8 +65,13 @@ config COMMON_CLK_GXBB
 
 config COMMON_CLK_AXG
 	bool
-	select COMMON_CLK_AMLOGIC
-	select COMMON_CLK_MESON_AO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
@@ -48,8 +79,11 @@ config COMMON_CLK_AXG
 
 config COMMON_CLK_AXG_AUDIO
 	tristate "Meson AXG Audio Clock Controller Driver"
-	depends on COMMON_CLK_AXG
-	select COMMON_CLK_AMLOGIC_AUDIO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_PHASE
+	select COMMON_CLK_MESON_SCLK_DIV
 	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 2b9490dd9878..8baec10a49a1 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,12 +2,17 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= sclk-div.o
-obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
+obj-$(CONFIG_COMMON_CLK_MESON_INPUT) += clk-input.o
+obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
+obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
+obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
+obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
+obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
+obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
+
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
-obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
-obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
-obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
+obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
+obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
+obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
