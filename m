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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D5020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xx1qeqmf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt3nGvK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Fvzc0bTA+cYRXLDdYZFS9XynFu5ZELOhsDfHP2R1x6I=; b=Xx1qeqmfsmpz3yxdmMQUQU/xOr
	q4/lBBDZ0lLayzebCImqqk8Zx8mo5lEZrBiL0Q/x+19wXhsMYjzQjhGoqbqIdpeAGSJRsAoZFsxJZ
	BL2gOa70C4JNfiZN+R/o0OtGBHNoJGW1fKwwPYkBM2UL3rR1GQLWR+Cdn68oP0Dv8cwZADYk6OHFA
	kzl/n2TtlZkyg1sNcfpZHsQbdhj2L2d3TIUAnzU5PIpRJK439oK5e93BaW2/L0DxvKiEEIuyxiIY0
	MnT6GOjNcEI7G1wAE9b69UFAA4M6YVc6qrF+NJ/oFg9I9dY+FMS2k/AU/tEG6msaHD81amA+fNmYE
	dPqTZXDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYJc-0004yc-Ss; Sun, 02 Dec 2018 20:26:08 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHz-0001wL-Fr
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:37 +0000
Received: by mail-wm1-x341.google.com with SMTP id q26so3646236wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
 b=gt3nGvK8NwsEwK5RJDBj/2x+YS+lOCQ7+bXLEo/6nmmzBptA+3rt1F6H2R5NvrVncP
 sRqCYhYPTatsdgL9k+nyP2gb4031HLQB39nU5GycYJ1iYAUxqYzpYpciwT7HD0FbwccX
 kKzMlu9IRNG3UDO86/4rUE/Pf4hut1HCRw+mN99B6xE9JSvGIB/Fodd9BgscSb2aKfH7
 UHxMEXHsiy7hb68SoXruVjOLFOK9yjCwFU7MvrI+Ba9aTDs22wl+2etMeHeargImX0YC
 0lgLMj1W3dMi/ayDzUUE5zgXyW1RsWix+BF6/adDxXq/b134LX13DwfJ4xtym9maIBdL
 ZkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
 b=ehci1iMIqSmwWO9xDln+vN+9HPeOOv040FocLMO+wnifC4XxJTuqNer/hq2ffN9RcF
 JBihMLpc2OUQUXSPDAszcRAXaybdsyJSQwvmOVbzUPfuEL/zcoOrv3CiHcSgErwZeV3n
 ugJo8s5E3J1vcb23CG3JrLlIJLf7B9ygFRZrpQrFf3bYAOxy1dSXVioD1vJbZoMN4OUj
 xzzTpwlqUCmmYBnUxWsBfgveOGblxETLRD+qLHOfJMvC9+ml6RJVJTPpa4in60ob1ect
 bjy1w4KNcNgcbxByXy7jr00sf6n0glIwYrFFnyOMhWuqN9g4FPpiQ8ujnA9KMmbn5jvI
 6BzQ==
X-Gm-Message-State: AA+aEWY1sUCUutclX+8MJq+AHSNSuHwR1f24ONbguYlFdoa7Rl0BQcbn
 4b/tAsuxickN92sWo6V9J4I=
X-Google-Smtp-Source: AFSGD/UN6jAOjEyAnAksPMWBNNew+GSzwYbOdZr/pbVEbOevS6G+zY9Ict6vDwwjDsLG75dyNEg4iQ==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr5918334wmh.0.1543782255665;
 Sun, 02 Dec 2018 12:24:15 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:15 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 03/17] ARM: sunxi: add Allwinner ARMv5 SoCs
Date: Sun,  2 Dec 2018 23:23:37 +0300
Message-Id: <ea7d4f514fb002d909140854fed645ae02ef7dc2.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122427_574756_106E14FF 
X-CRM114-Status: GOOD (  14.24  )
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

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/mach-sunxi/Kconfig | 13 ++++++++++++-
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 185c573..7fa6a3d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -61,4 +61,15 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config MACH_SUNIV
+	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
+	default ARCH_SUNXI
+	help
+	  Support for Allwinner suniv ARMv5 SoCs.
+	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600)
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e9..155cd9e 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -101,3 +101,13 @@ static const char * const sun9i_board_dt_compat[] = {
 DT_MACHINE_START(SUN9I_DT, "Allwinner sun9i Family")
 	.dt_compat	= sun9i_board_dt_compat,
 MACHINE_END
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNIV_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
+
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
