Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06833C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85B120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H7daSl4V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Hnrjy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85B120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=P0XzydDXbA0Rxn/k2MVIMD6ZOdVsrfxH9WUssdKnJV4=; b=H7daSl4VWUvLmrwaabIjcnJhnm
	PvLe3VBopv1g2nz+L59YH9pprJg/VP1lTbjNwVXHpW16HeApWCpoHW0UPIWDvko7r4qngL2fZ/5y3
	JWh7kQJj/Yb9z9FbaMBs60expmz+JGJUvyGEVvI7GuHVGcygqqeoQaSirz/28w+VgpR89JpJydp9m
	UFpc6SwueflqGzayR7tpsheha++6qIhFXjQqTnkebTIfutbqcWPDmydr1b0b9sSiUd5iFq6pVqlSm
	TnKHf9LoaxZRrm08CIZjDHLHjEAe1obfXmLv9mBgsdpONbrXF9iK1hXBCGOLRkESv3CYGDNTwnaIB
	c/We+ArA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYIB-0002As-0m; Sun, 02 Dec 2018 20:24:39 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHx-0001wH-RW
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:27 +0000
Received: by mail-wm1-x342.google.com with SMTP id y1so3691335wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
 b=R5Hnrjy5AZQR/YOegp9OG5MwjGVSqr5ylRLfDC9OEFoghKwvtTwpC65Mx1lTqqvD/c
 L/9bvjQJcCAB17o1b4hoagzj75v2qeCrjzRdpwDR6wc/h8sXAFnUQgGIsOH5i0tcVDFK
 LtjYP3IzF2/FxO5KQ4c8bMq/qqJfoLI2YlRfvjlYkjOjlzYFCL39kw5SHknsCHnpc+6L
 pgyX6/1dYQcPsVOVK/d8toQafmzS2hYPftNilLVuousgGFfQ2j3wHYE5uFluuefe3RE+
 VINLNgJ5qVyui3mq/Gu25YoIzztAAIQLCYAcNZPDoDpgY1AHQmAcqSmn42PWCRdc0OXd
 roJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VF0eXPvxEQ8eg24ufuqCwYbc3OHuCombUgJA5hM0DFE=;
 b=Rkqu0MTQbl83bhsO4E2C5QsiylwNGjubPPGeXkUtKzmlZ6t23mIN7/c8YKRtyh6uN3
 63JjKdYTlggwQ4+JhhtfnYCIS4qGIgsxVwcoQXSL1MJAWyP8jpy+24TDAyhCgNb9t4el
 JUJNUZab2cg9bJoCi/pgjaI48r1IYj1IaJc/91TTFvMOodxdBu4P2N3EDsmck0c3EzvJ
 uLyjK9b4XbHobECD3VTjK/Cowtq9xAEVwuuMV7uc8RBpU3o9YtMtAioCPM/KdnL45dkk
 zU655P2WA+m6uc2z6n8QEi/8ohbcz5hBjAAhbWxhqd4rHpIDWu8SYOOCagoET1MtBCc1
 zVYw==
X-Gm-Message-State: AA+aEWbT6wlU3nBU/FUgnSSJjk6L/rb+y0oAUfTtVT4ItLQLNzdKfmlI
 aIwrQF5OzIeUDI4oiZGm43MZDwp3X1E=
X-Google-Smtp-Source: AFSGD/X8J8uBvA+Atj2GldMyKoLN9X1VZyIrPrn5AEDmQeZ8PFIAwb3OctXByDSlmb+MmGKQBXN9Dg==
X-Received: by 2002:a1c:f0e:: with SMTP id 14mr5742096wmp.37.1543782252226;
 Sun, 02 Dec 2018 12:24:12 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:11 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 01/17] ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7
 Allwinner SoCs
Date: Sun,  2 Dec 2018 23:23:35 +0300
Message-Id: <1a4e6f2b1d6aa5a079e2afb5d1ddf39f830eb8be.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122425_884423_09B5B547 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, check ARM_MULTI_V7 before enabling
ARMv7 SoC's. Add help text for ARCH_SUNXI menuconfig.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..185c573 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -9,9 +9,13 @@ menuconfig ARCH_SUNXI
 	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
 	default ARCH_SUNXI
@@ -56,3 +60,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
