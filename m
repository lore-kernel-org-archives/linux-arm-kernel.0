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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E22BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFF420834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lyA9OHpR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFTO4KWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFF420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Ykz7MszUT9h/f6U4QlwfNLS56sGnA3IMUBcluOVk2tw=; b=lyA9OHpRTLo8JhxLGBvO0Bevjq
	aHS9Nbl+rG60nRnxyLrye5lA9sNsHTg3tafp+RmCC2zssnuNhuuNjgEdboHv7HekxN9gAWa8S3kQn
	8wHTwBrPkC5vuVg7iNpTLK7CzAzRMkIL98irD2Y6NJtZO0WJ3HdLL8GH4B2dH5qxPT44SmG4HfA5P
	xebvvK+H4FHfG0a4ZdjJLklaaCnX40mNAQagdaMH7YG/B3aeFzS9D5h4WKEKKMOPYRPceqt1I4HET
	aKfV6OJ8vQiOvCY50+Tn+HvdPt8ERPoA5MNXI+arNzJfVSFPgskrqaFZZDVLc3vTWH13o/O5yb+/t
	Nl9/PPhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZDn-0002P4-40; Sun, 02 Dec 2018 21:24:11 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDP-0001tw-96
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:23:52 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so5570420wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aCJ1z19r/p/cSDddgTolGHUMO2TTDXswzYQqVhNA790=;
 b=lFTO4KWPi9FiaUr9oLQPf9b29u/miq1SdnbmOvssdCKfwBKe6jP5VZUKt6DZHtE5O0
 g0AEQ+DEo17d9kt9sLmE53AApa8n9zRZXC72/QbA3i0+B4duGgsE8begYpV0I0xI7Q7H
 xzasHza3UlZTgppnNk4TtJv0bIRyXMSTV9ry6/5uUcCWTHIi4NZdgKTHBK1FyCC1zAC/
 lZi11nmbF5OGnKw5nJ6j1CF0jECZoL1TO1Yafcrq3kW7ymYMkxRjCzllDa+Bt3QOES88
 9BwLmVK4clUiQYSzMl+cXooxFGfCBwoiBlyOtL/VtKf+u2njTPBR8rWh55/xT8nroZs0
 OP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aCJ1z19r/p/cSDddgTolGHUMO2TTDXswzYQqVhNA790=;
 b=ooy06xaHEShzf4oJyTRH/fn50e6F7qfcqHXRzfjw1PbGEmYjr9KqUTQ+izJMARAufj
 XlkOr35L/smJQeaT9vzHoDERfyD2glgHI1M6aCqfZF4fQGtUmJggai1SpbRsVy33cxfh
 cWP81E761lVW8ugcMHuncIhJuS6IX29QqlmuvAUWievm24+k0pqXoNGf3zl09DMFeEHF
 6ZciO3Ei0VPs53Qvu/WEmdrky954lf9CRQc2MINIYJxrxg2LI5QuBA0C8wp8XHwZKRx+
 sWSilikF/8cXFdBBNNE0PGSV/4B40nl1DC/5ji42+SgQQcwg/fsvnzSHtoeM7ktB7dfc
 vHWg==
X-Gm-Message-State: AA+aEWZKszquLG3PbTE9W8tYLsB3aeRKeYeOAqJuegwGXmnqUF+uIcdu
 LultcNkY4Q/Qk/BhETuLeaU=
X-Google-Smtp-Source: AFSGD/URYtpwGQQ1e0uaq+sdvPfANESyrrrgCsmkZgfNFOHi/ctrQE4YdaN8VQqTCX71llmaosEXTQ==
X-Received: by 2002:a1c:8fc2:: with SMTP id r185mr5876417wmd.54.1543785815775; 
 Sun, 02 Dec 2018 13:23:35 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:35 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 03/10] dt-bindings: dmaengine: Add Allwinner suniv F1C100s
 DMA
Date: Mon,  3 Dec 2018 00:23:10 +0300
Message-Id: <7322bdfcd38cdcd8ccec56fea25492e4945d498f.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132347_880102_BB2F612D 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add compatible string for Allwinner suniv F1C100s DMA.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/dma/sun4i-dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
index 8ad556a..ceeb41e 100644
--- a/Documentation/devicetree/bindings/dma/sun4i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
@@ -4,7 +4,9 @@ This driver follows the generic DMA bindings defined in dma.txt.
 
 Required properties:
 
-- compatible:	Must be "allwinner,sun4i-a10-dma"
+- compatible:	Should be one of the following:
+		"allwinner,sun4i-a10-dma"
+		"allwinner,suniv-f1c100s-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
