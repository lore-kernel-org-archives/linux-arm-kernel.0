Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66226C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C7B21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K8xLJqyS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J28o9/Cy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ljfkEW3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7B21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gnIJIkRvru5oSc8NWwchxuuN0mcJjfx7NqBX/A0CqDA=; b=K8xLJqySt2v2Gn
	j7QY2ArhZCspl0WDCMl2Y2KwG2WiTqLmUQVRGCPw56Id+cjgDt3kcT8xXpQp/Jpv0vmh6DDQzEYe9
	brPW8CdbfOg1wO2LsYbWXZRuQt48R2RG7EVRHWNG7MdZMZVna+ubrqzsFD6kZiYJrYD3IZfg0Fn42
	+Cgo41K3Dyr+R0Q7mFj8hi12GnYcHey5X7K7Ei1sjlJoenlZKbdEJ3/zPMtnmWx14guxv1Hp19J/M
	qJww5aVOf0ACjHVfaOYsCyzq9h7rt1jeMWxN0SegKnzuipQ6P+k+ldisvg5HQGuosD4G8dtUIAy+d
	0H51vxgG2v3G9ZmV7wMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlBo-0001hG-0M; Thu, 24 Jan 2019 20:01:28 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAd-0008PC-IS
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8q97sbmpzgiJ0X8sY10lWWdB/Eo6/FNKaSHSF4bAxYo=; b=J28o9/Cy7HOWBPaQOYMXb3Byry
 vzK9ytCRQCmvv41Tr+/dsiYSeulp4QAMW+I+k+3Zwa7IKObBqqFzw0vu0H0KPS/HMQqfV41c6q+J6
 UopYFwPzFIB6N/IUtrr9IE0h9c+R8ySAMcD8MnHT7KrjVE3bPeFLaFVh/Y3hSER8ZmkStNd+xYj1w
 u8G7NoBPSL8FCI6E1NqbTDiMEZlF+dkoAcneJIZnoABMUcapl0tWTmZemZHggIzIYnfZhd0KC+srP
 HHlkYskSCxb/iZG5ix7gj/fk5HPWeEmYjhKIo7bo8RkhqVgE4FQOp0RrbFLwEu1Csl+IwuaN6319m
 5d8azlWg==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAa-000741-Hh
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:13 +0000
Received: by mail-pl1-x643.google.com with SMTP id y1so3371820plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8q97sbmpzgiJ0X8sY10lWWdB/Eo6/FNKaSHSF4bAxYo=;
 b=ljfkEW3e5CkcbpUDcCUm2KymfdIdH5kLxFLVfaeP2gMsoJoDHICvERjswSxoPmFqPM
 EFFj75rodXEVTPCimGazX3Tiiry2kz0RKcHQ5WOlhmK0fkvy2mUJ8HLT2plqiTUEDqKV
 itBRjaeY3H2t/oBCydXgFmvS6jX5rEqdIxJm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8q97sbmpzgiJ0X8sY10lWWdB/Eo6/FNKaSHSF4bAxYo=;
 b=kJjTIwZiXalfyYETbitxcLTwCPzfewPtDM4NmluHKUJJgqCxqTgkjbQzjC7M9TEX94
 opqZZbmXhs/vQU1tWDFYe471szpzPvcfi+bPAxEKETJ+1wx/4LqGJFM8iQaWww7Iwfb9
 d12hrCY7LxhqleDp9kme/nfIJEvmtO/8Z6E/IBFMhCQvhepO9iSx+sQX4jQ4uPZKlz9K
 VkH/O7Qa8mHWQHsduQMnZJ3sayZPxTVuI05EetRj2cCTv5o5LsNqKEPZzJ10iVahtcG4
 g5KDj4Orp5ffi5EP1o/RlnG9D/PtAfoG7DYqCXmEWojkp9ubIrohwON17Dd7AYl9ndX8
 cHrw==
X-Gm-Message-State: AJcUukfvuLmBa0FASNvjkwR9xOxpZTksLe+9+GCfkDf1QY5vEmslxhZt
 pyu6GNdXhMPrRzsFuoWyGVSwgw==
X-Google-Smtp-Source: ALg8bN4JB1sFbrT1QGetXTKGwn0uHo8a4Ub5bRDOtZZpisg2qwYQ4vbkWFp9Gite9nop0n4WrX0J2g==
X-Received: by 2002:a17:902:3283:: with SMTP id
 z3mr8014727plb.76.1548360007757; 
 Thu, 24 Jan 2019 12:00:07 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:07 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 09/22] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP,
 HSA_HSE
Date: Fri, 25 Jan 2019 01:28:47 +0530
Message-Id: <20190124195900.22620-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_150012_596775_34624349 
X-CRM114-Status: GOOD (  13.60  )
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
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Horizontal back porch, sync active and sync end bits are
needed to disable for burst mode panel operations.

So, disable them via dsi base control register.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a2ad9fa7f8d5..3d7c03161954 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -549,12 +549,17 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	u16 hbp, hfp, hsa, hblk, vblk;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
 		hbp = hfp = hsa = vblk = 0;
 		hblk = (mode->hdisplay * Bpp);
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
 		goto alloc_buf;
 	}
 
@@ -603,7 +608,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
