Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DCBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536D32082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsdHAFNs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iUDo70yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536D32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vk6L6VQmD5zwMgjkk5q4SMqcHydiZtlTz0oVxXuwaKo=; b=lsdHAFNsY4F39n
	KFETEzTz5gNoR47Wwb+0Rx29Uu8F+xCUJ+SVDvCAGyVhDjG+294Ag31DoortlRYcgzePU3UmCvFkP
	X0IindKml+9vYtLv/npXzYr1QL6ZSPYIqnelSoUU8ixQzIGPKHX0xccXPvSgahLVf3P6hzR9ilTM7
	gq12pSOMidpKN5B2X3tpLWQG8KowmGAtnPEWU45MWRYjzO5JMZPtnC4BKV47xoyqRbJEf8NXFhvEV
	BGTPlA1fMwDsgEfMtpMQ3wAyGEa18ZClV3ivDB1rGTaD3q/JAW1p+Lf9TGk6/jONGeflBltfbp6vb
	JSCRrrbhOZI5jPUfYhoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOGm-0000Kd-EM; Mon, 10 Dec 2018 16:18:56 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOFw-0007cp-Am
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id s14so11599359wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0G2Cm6yl0hA4By0n3opJjvWD4CEYft0z/6JnEL+u5rs=;
 b=iUDo70ylsxbw31KSTQNl5zLd47rgtT8gzDjZUFM2Uytf7J7H3BEaghRCvwtYg0Smek
 91cLB4+6QeyZXk1lRnruo/ODwDJBb2HRJEunozV+R27S0bDcVNJurGw/myGHdHQbF7iM
 g+c6gYO4UxF2sNQUpTrLdQLx1vYxqOd5Rc01M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0G2Cm6yl0hA4By0n3opJjvWD4CEYft0z/6JnEL+u5rs=;
 b=ErWi6e/8wuy4qmC4GE/PU/6CuU6a5YMDxinVmOdjwh8BMYejzW+tCfjYPukccDaH9f
 iD+T3DaPf/kfMqvE8ddcOeZ4ISt3lrVleTJpCzIol5s27vyM9OuoWUXKao+pp+umZUt8
 Vf+d6YgFjkZLxjFvyuwP77Gr8CEh4YY4S6t7QWFSri64yxkCD28rTbxcukwKRCMuGjg7
 90LHRCPJjoeKrwaje8dnhxiSifdGcH/95wY7UdJKB39zKagpyKzidbVajLG8RofTvtwt
 H6ojXwkDDhSpkpBfKNBUx5S2lhOIMogTSTIeG9xdZ7ddf2BgDutaCocHs/94XGsZoS7r
 TJOw==
X-Gm-Message-State: AA+aEWaV2kArG2MD8Rb+E95I9yUJo0fEF0Xx8nzAkyO6fE90xf+Lz8d5
 R5kEXrLTXUwI3dVYMERIZol/vg==
X-Google-Smtp-Source: AFSGD/VgVCcVXfXR6IgQH8Ctvc2lTvygISQ8DSmGKfU4RYD/M85sJu1tV6MPzTuEmSwpAC8ZIb3/IQ==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr11709720wme.106.1544458673231; 
 Mon, 10 Dec 2018 08:17:53 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:17:52 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 05/17] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
Date: Mon, 10 Dec 2018 21:47:17 +0530
Message-Id: <20181210161729.29720-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081805_049303_0348B34A 
X-CRM114-Status: GOOD (  11.98  )
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
 linux-sunxi <linux-sunxi@googlegroups.com>,
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
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 50f535ae57e9..cdd44a1307b3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -871,6 +871,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
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
