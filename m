Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F86C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EED5218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CrWKZzA4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JobGz/n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EED5218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Od9rSg5or1j4qkXqJPVrLYOuM9JcNFxXbsmHJ9uwRPs=; b=CrWKZzA4zrIpGz
	nIJvDdIPYcEKjEv7/XG+qeOZpUvAs5NWT9eAxZkeobOdOZZNn6B3ZRld6BTklm0XySFf00xLY11Vm
	nodK1t8tjmlDJ5roCjV0beBGYZtt56npXP2Il8ZON8i3o5xECzrgFtzjL3uZl4/Bku25NWWS85b/k
	Bs5m/FLxXdZGxmEvOYZJM6s+BzbZ/kRdsSp5GE6yN5NZHylZA0b/ZVVedjtOzlkxvJeFd9R4Ly3e5
	H0/o2sfcDy5gY9q0fCaG1As0tHtH/ZcIkCXF+GEdpUPsBM8nOWc/JLypLJkwEAUhCQobJox6+IiJg
	7H3PamsJLlJ6hOCODeww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb3L-0000Gz-OS; Fri, 01 Feb 2019 15:48:27 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayN-0002YD-9d
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:51 +0000
Received: by mail-lj1-x241.google.com with SMTP id n18-v6so6168803lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SlZdSxfBuDHFfxIddevdjQVhgEUV7gSx1dHVPI1InaA=;
 b=JobGz/n5O2PIfNMLcOY4LXUWKgthtj/6/kt6rgaBt7ceZJuH1doHiSi8Sxlx1qkAxE
 eYatjXNsn6RYSGBG3tqbyHdDNGAqu0rz8nJbY7elVAG5xYFBmu2LXYF1KQFX/XRjaocd
 CjgCFQmwmUxiDlbMNg2S8He1oShBKfyaKYKNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SlZdSxfBuDHFfxIddevdjQVhgEUV7gSx1dHVPI1InaA=;
 b=SGn8cQ2Omu+s/+rMebREZtcyH5MFVzgl8zanxrV2AH5QNSqgSEYrNXVsBRdTSDeKRo
 Ssw5PgRKFSERBSZebcypL55PkpRflNkQYHRZZ9X7Ap5rlTSDvWaGMHgQy0IBEz9FZKW3
 0Cv6Gc19QHw/GkjExK8gEexpHvMQhbXxXpNFVQ9TvuAw/LBfVbupuF2/6TLUEpe8Ss9i
 ySP8k9KHFtCAOGrLj0o0wVs7IUqiu2B+xwQyXm62mOIknJpAVTwQy+D+uEWRjhW7v6/G
 UChwel8Fhj7FdwY9YZX32zccqM3B8+qczkLcCRII5NcBWZithEZ08VAJ0wqr5Wb/WLoN
 PNzQ==
X-Gm-Message-State: AJcUukdmyeTqYZ2+fRTiT7g1GO9zcGcR7cmaX8Eqi7XAaIPEwfOoC9Xf
 PP/P9q0qbFERVDe19gPJEqaL9Q==
X-Google-Smtp-Source: ALg8bN7mYsorlikrfb8l+3cpdMLiswSisF1oFLlmJ0ydWjBcb4QtmAd6YG6o2C4/DXjHq4rlRbe7cw==
X-Received: by 2002:a2e:4299:: with SMTP id
 h25-v6mr32297109ljf.5.1549035797544; 
 Fri, 01 Feb 2019 07:43:17 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:16 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 19/23] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
Date: Fri,  1 Feb 2019 21:12:28 +0530
Message-Id: <20190201154232.10505-20-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074320_189270_11146C81 
X-CRM114-Status: GOOD (  11.87  )
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

Short transfer write support for DCS and Generic transfer types
share similar way to process command sequence in DSI block so
add generic write 2 param transfer type macro so-that the panels
which are requesting similar transfer type may process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a0697d78b915..09569938c20d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -984,6 +984,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
