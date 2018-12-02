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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69487C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FDB20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqh4Svbn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Qj1ubQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FDB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zdTH/4tUYTffoaO96kM5tW0ZHysfZoN1hMtOs3nfYss=; b=aqh4SvbnmqWuk7RUST5UtC8T2b
	LveO/7TTAmXlD+KOPcKEwIKPI1cB0fzdBSBqJdaMPQOrnwAB/BcXZ1ja1GjltWa34NRIIMJDvE+MC
	OKQYhNJXDBKS0fPgLkMRWmmSc9aJy/G2dszeeV3fYaw3Hl0mqx1wN8P6l0imfFgNTkn6weLlkffgm
	oLHXrAveJwlqbVxkHrOMkApVwtyLj0MUkfw0Wuy7DddWpat42MM+LaR3KkY4JMff/rX9OLkC4Mr/7
	xJMvl8tYkgdI3SBChnubJTGTKVbGmkKq5avyQO4FrdZsFKeTGWjc2PNcNpbd12Xbmrh2zOdn4+l7A
	TnE73Jzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYKB-0005Yd-9u; Sun, 02 Dec 2018 20:26:43 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYI9-0001yt-Gi
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:44 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so3684915wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
 b=M+Qj1ubQFvaREfl4/OBN9UUta+ly3CdzpG/BcCRSAwkE/jYCGhNwzHaRZFQ/gBQQ46
 j8EGEIa1ktgegY2zOf2IHSNEK85pIFk3tuCM7zGLAlGQEoZzHZDwwpc87Aa7zgCFkzWB
 WmmFhL66zj91hyJsP4/4CTDej1Kwwz6c/i4P4ig9rn8NqDzQXD2DYW0WS53p74hoF9UQ
 oHaMoMZ+sxYXFYrDDJM8uO0MpGbVB+nvHYQY2U6rUGlSB5QwjWLF8TmFjGBCXHNuRF7D
 ahepO74vR3pMwAlcv7tIfUKK79K7pl2ByV08w35uZUCephJz1ltlDgGazoB3a6wCA2yc
 V0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
 b=N9h5gBuDi1yA2rEIyHFQGHyEgJ2L4bXkNp7UdEVb6k97DGaURndbowUaanq4TTYECE
 jrKUUwUQmTGlAbr1ElseKMJxmHuCiX7dBrHJDcV36NW+QERhq79rVjM5AFp2p8y0j84W
 h7YnbUOOIjXCFlO2GxvNsiwlphxRe2qqYOf0gr0+JGBBLcq+9W2987JEliboWQZie1Bj
 IMx+XD4ELaJK/BfG/WCiZj/KiKxSMfRuAO/cwviwjGLJpjISfsG2YnEmLdGguVmY1YiD
 sL+0VdxPB+a5OGWel8FFBjk7hSsN+t+4Py11c8OJn4t9DGiZTZc9EMllA24AoI4HrZpI
 OWHg==
X-Gm-Message-State: AA+aEWY5AfmFbmImTzOgc7kXmq3YnoWZ9TXwLrORCcLeBjLpwGBn0oCa
 oePIQlVde3wi5zjxcl7bXyE=
X-Google-Smtp-Source: AFSGD/UqjgLR3cwcry2yhqBeBLwEwmExmps8Kw8/WEGYd9+uBz+JNpuEQuiKyO1AaNIZaWgRWqvvVw==
X-Received: by 2002:a1c:c181:: with SMTP id
 r123-v6mr6011173wmf.82.1543782266161; 
 Sun, 02 Dec 2018 12:24:26 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:25 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 09/17] clocksource: sun4i: add a compatible for suniv
Date: Sun,  2 Dec 2018 23:23:43 +0300
Message-Id: <2b0e0a33b1e99f0f33d2eebd44de38bae9140bca.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122438_254988_317D2F10 
X-CRM114-Status: GOOD (  14.11  )
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

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6e0180a..65f38f6 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
