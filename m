Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D40C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:56:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175102086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rzFBg3IM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bdX9sXiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175102086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Pr55dtx+Fo00d/IZWzLmmQRPH04KkIiVvGFwQ3XzSg=; b=rzFBg3IMx952IB
	ifgjAy1kzDog7tVWnNiNFeEItUlTjX0XYbxRKyUpRiDYcP6pHBdyYI4da3sKWHuGIk5L8yRe5yOzq
	BbfdxS1LQGQ1pHnNirXTUPPnCl5xOEre5MW7+S0lGuHsH9eVZnLULIwI4+3s5wN7A/gQMd282fwpO
	oOV967t9tEo+DSOGp9l7gyhgfIq8JLqEAV1OhKyW8/3QOwzuCt+C6f8bek8CHzoa3+bZSZrqy0P2S
	E4EA6lNMCiguncb9PHPvdZ5xLa/fC0jtLcPBOTkZawMQ0MdAcsNzn2EPEy3oIqoqDRmJK9XNx8LxT
	udX6TxCR3gwgA4xYG2DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbAg-0006xD-8y; Fri, 01 Feb 2019 15:56:02 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpay6-0002FR-AF
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:06 +0000
Received: by mail-lj1-x244.google.com with SMTP id u89-v6so6229222lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rS6sGbJP+zjY5kJm8iT11B1WuOcwYEUOTtJGe88GIrs=;
 b=bdX9sXiywy0BGPdJwc5OTztIqQo0WTncpb/ZlqVFxOTBr0j9Hc/hOb3la6YN6Krgxq
 BJY376aZ5qf4y4aNLn3kGIXsqow0XD6fQnpCsjs++yoDdrMR77yh8ZJThJo0lBUp+5ID
 EdgNlkBPPGibaIaBvITW1dJxiVrNqSlL1Fpy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rS6sGbJP+zjY5kJm8iT11B1WuOcwYEUOTtJGe88GIrs=;
 b=Ukk8EsYMTaXhh5llSjeoUxC/VyaxH9aueqzUA5OHN9o8hvrA5PevLNnj7BFxKeZYbZ
 aP2/4y4LPOy+1FBMGU4bI+LZmoy+ZdjwSZGWT1dBsERM9ZIT1zStPNg8lXz6x1yPe4SX
 dTiUeK0b/lLf/VTVYcDjLMfmuKe0EuI4hb+ZgM+Ewv3rXoeSNa7C0wzL7FUy7ab8h+UM
 0cO28o5nDf8yuUuGdfwE2Ysd3oBVqAAluzP9M6nGw58PojJBrpwpkmnH1008RZCXdSQr
 /YjI5hcdK0droMuajB16HeqCGNombr+J7UaP/ynZksSTp1dqglVK34QhWX9A3NNXFhnB
 9Uag==
X-Gm-Message-State: AJcUukfBBIdbcEQ3cGhw/nQai+B8/bBkWWqqBwDOCTqk0XjCziJfBkxb
 D9y3qcIYiyK7c+Lgkx8iP0+TcQ==
X-Google-Smtp-Source: ALg8bN6wZLRx3APZR1H/AYjNK+cdvIN3IPrZAwkaLn+hv3CJ4/x48AjmcKpGiIL9oGehk6sBp0t6Dg==
X-Received: by 2002:a2e:4218:: with SMTP id
 p24-v6mr31408690lja.58.1549035780689; 
 Fri, 01 Feb 2019 07:43:00 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:00 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 09/23] drm/sun4i: sun6i_mipi_dsi: Enable HBP,
 HSA_HSE for burst mode
Date: Fri,  1 Feb 2019 21:12:18 +0530
Message-Id: <20190201154232.10505-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074302_858700_3F3D7F6D 
X-CRM114-Status: GOOD (  13.19  )
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
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
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
