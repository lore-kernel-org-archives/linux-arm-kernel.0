Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629E3C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D1C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mXGYccad";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZE9ajIXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D1C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HoJcqfynojC6qWAmtwGYQ9Zwpv00+RBT94obLPB4Pq4=; b=mXGYccadnORHeh
	Uwymj3p4EgEtbSmDsfVPnXJrvuwfAfEzHSTHTj2WU9ocLPrPrrzaN6QurgTdOu8UWK2IEhVN1ECAj
	MXCtM510l44rufNFMKIM+RYhuIEVFyg2semsYvGN3j+NMqsrh1yH5hpYR6EE80h7dByMQx2cS/SoJ
	4HyNDOR/MRez3s9atsZYAUCtT59G6odOKLDNv+wE3aEhYQ4uwzXmqlxZ1uPHjJeqmc7fAn86BELFz
	AK7yUXW8dsmBXnSXKDwGIKe1TzQQ3173RkA0aXcL4Kj0VEwaJA2o5j9c/GqKdwEn6kgX3YNVSF4bM
	c7+9BTPrmnhiyb8BFQOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOG7-0007yC-F8; Mon, 10 Dec 2018 16:18:15 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOFp-0007cK-JT
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:17:59 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so4139974wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XHVyHtVc0G3Kpp5cjsZwGbecU0Xlg/ozATiwaeVvdoQ=;
 b=ZE9ajIXqPxmINSacZd+H8oprtTFFyxpDCOZ2azqgIZ4MrD8FGUNTWwvslD8KG0DOpi
 ilI581RXk+JktjgSE0o8KGaSlCe3pwRdpL4IRr0NIdB1tNJaUns2ocfnBSC2WqQuxR4Z
 CDACrhmZyDVqmlA1fYMQFSnKyE5geIbCOAcQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHVyHtVc0G3Kpp5cjsZwGbecU0Xlg/ozATiwaeVvdoQ=;
 b=Rq1v5e02MrVLj3Pca8muDn8CGLitBlqnFxw34qW9taHo4w7AB12RH98DZr61Tta7H6
 C9SFXvgUn8OaYRnVaBCzSlGeyUBi4St53Pz2iY6HrNgVh6JBQMnnZiHB+cCrdLQUVVs/
 wKDEAtgZdXAmMUPE/PhrgI5h79u592GEh+YzTPb/U5/xHAt/PU1lq6dm/gO2DIbNFq0z
 J7+wFG9iz+hKQcaJHUGsp6innJzKxvpuH+vOWFOgWtAESnZDy1u7UNu0ao32yW2MfREf
 7mFuUPB9NCBVOzzrZXd40TMq7fshUmAxAmJ5s7/pObOVI35f/+Jk0zwu962oJhxn3nqY
 xbPg==
X-Gm-Message-State: AA+aEWZUSUL1DkTFDEtP8xE7eh5gq47iDGQUDyfEKDopTFzQUPt5Iz+w
 S0n+PlkYGt9tAcvj0jhvWcUUnQ==
X-Google-Smtp-Source: AFSGD/VmMHUxhKg+eCn4NcXCKmMarXP8qz9Fx0lmTKt2sUbFkE9TD3lBen1AoXZTyUnuHgUca0BB7g==
X-Received: by 2002:a1c:a6d7:: with SMTP id
 p206mr10662383wme.143.1544458669864; 
 Mon, 10 Dec 2018 08:17:49 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:17:48 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 03/17] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI
 DSI support
Date: Mon, 10 Dec 2018 21:47:15 +0530
Message-Id: <20181210161729.29720-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081757_650694_86537671 
X-CRM114-Status: GOOD (  12.30  )
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

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)

So, alter has_mod_clk bool via driver data for respective
SoC's compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 561de393ea23..50f535ae57e9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1120,11 +1120,18 @@ static const struct sun6i_dsi_variant sun6i_a31_dsi = {
 	.has_mod_clk = true,
 };
 
+static const struct sun6i_dsi_variant sun50i_a64_dsi = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-mipi-dsi",
 		.data = &sun6i_a31_dsi,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_dsi,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
