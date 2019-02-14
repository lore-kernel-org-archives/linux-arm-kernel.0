Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F035C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFA1222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L+PWjasH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K9+zw67u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFA1222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eRYl8ZhD0z8Qr90sLGatsZtnxi9n7JCfZ7uIuz/92v0=; b=L+PWjasHpabueu
	4tkrgyGa2OXJKdMr722gTkw8aO+qs72KYO9d36+YzPH8tcWbaliEwZTWQ8qQGeA7yf9mzQAaAmTQ1
	h+oRhtL5hAypx50tu4s5/I7E7Inc267pSP2iBaGrL7AhTUmzeM7ezqWIXqboYpfrS0oX5RSoQX8AG
	8c1nWv+EHg9ryYcgEy4rvUFgqMRhsLj//P3mj8dDljpSWKZiOcHf0lXCDFWHSl1bOvp20jH93T0sW
	+d0Hz4ipjzR1Z2lIZtfjpfae3rmJBH9BkhfA+yyCWNR011oaoCdO0o4KJ1CQ2+rG5bYgBWnhnCye5
	wdd5RiCHKCKzJIReYxBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMfp-0003Hd-AE; Thu, 14 Feb 2019 19:27:53 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMeY-0001ij-1M
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:53 +0000
Received: by mail-pf1-x444.google.com with SMTP id g6so3567508pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NCL7zOvAf1NWF05m63CPXM37pS/d93C5nu4kd6BUq+I=;
 b=K9+zw67ufc8DaaJo+tTQydkpSrx5nlGraeqeSAo3n+X5ceMeAcFS+s+lCDqXhZbCAH
 KEudWGAC2KiR8BjB8qkOw9YxkdTUyNd0mkTg2gtgWQKt/1hifbYXJ10L1t6qBPOXFbE1
 W67Bp3DP6NAW4Nt8HFiWxkEnuqEFYqaGYV2bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NCL7zOvAf1NWF05m63CPXM37pS/d93C5nu4kd6BUq+I=;
 b=SKATz6lsFbdUaU5u7O7xw7LnE5cKDqPS8/J61+OT3hNm4OZLU03A7YLneIzmGc69wJ
 GJsMiqPAbat2Z0dwaz3YpyTWXceobjM+q181wnKRduVH8wFOix4KKMkfoXhG6qmqDfth
 5U5LSPN0rimrgHmretgcEZQ+dbv8VppdjJGVXsJXx49nQmeK3fhNl//qLv2zLacYbzlE
 gwZGGXFNjxBqgVif84jhA76MuztFKWlTR4jT1/5c8MUWyn/CICflPI5MbedDAXu9PErU
 3Zw6Ug0yyZJKCeXT2JGg8qyAzlLkRiyiuSxIRkTNYgtZQPqKqu1PDFxYsnDy6XRuY2lf
 yzbA==
X-Gm-Message-State: AHQUAuar2l/AKxN3vZQLdAiaSv8tG6xVWHo5Sz6ifSDjAKAkFmmcTzu+
 0Wg/MgzEY272/+wbecwSl/EQ6Q==
X-Google-Smtp-Source: AHgI3IbMiL/gS1qmVCENxTGERlXMbdvyTc5nPHlKAL3EzoaLl3D4CI3+JAB3CJNEUS0DDrPFt54fxg==
X-Received: by 2002:a63:fa48:: with SMTP id g8mr1447618pgk.203.1550172393490; 
 Thu, 14 Feb 2019 11:26:33 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:32 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 8/8] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write
 2 param transfer
Date: Fri, 15 Feb 2019 00:55:44 +0530
Message-Id: <20190214192544.7314-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112634_785863_C45CA37E 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Short transfer write support for DCS and Generic transfer types
share similar way to process command sequence in DSI block so
add generic write 2 param transfer type macro so-that the panels
which are requesting similar transfer type may process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 31cf9c58e98d..3a28d70dbdc1 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -918,6 +918,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
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
