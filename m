Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C3EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C557720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RwuUgUn3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JDwATJVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C557720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1uzVpGQ4IDYk+gUOgE6toPhUYihb4TfFbWv2CGRIzf4=; b=RwuUgUn38tpVce
	X+NPLZIobGDH3y4Q12w/lXduAHMSO2RGA2LhivbajmxQ1j3zmqR+kzaQ/Ua7Ne5grlLikTmvX5Ret
	0zgAAAPlTaxY49CMRIId5ObadLf4cYOAvMkYjCv8ct7ht/oEicARXEtIK6x12QACZyxQsy0ZobYBS
	XeaZr+/iO9gR24r2PjKRANrdlsxUWuc1vxFd6JAFJ+Efx8dfJdPNo+bSj6kB9IUm4f9+NPi+yO4nB
	Dz6JAQRXbutEVsEN5BmoMqAjpmQhi2sqejatjL1NiA3bj3JcEBAlAsqX7dDoXi8OUIOslaEDgYnwz
	+rvTElg1QrvBzW71RBYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb2D-0007bO-Lx; Fri, 01 Feb 2019 15:47:17 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayI-0002SN-Bq
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:36 +0000
Received: by mail-lf1-x143.google.com with SMTP id a8so5389352lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4aZjzTCb7nb2tKftkTHdgQPoUpPvat/+j26yjBhx4a4=;
 b=JDwATJVLIRANYmNxWOY+tdnl8MBY99Uv8xzUB/mvnm/ixBPg0Yk9K6Bw/tuhzo1Rfy
 GIE9GIxYaNphC0QqB4EFcBGfNndjUo975r01z4SrCbqxrdacbAn50p0+CyHl5lnvjPp1
 7R5p90d5SoFMOPTyGw3Z0ELtMH39BCZTt/Z/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4aZjzTCb7nb2tKftkTHdgQPoUpPvat/+j26yjBhx4a4=;
 b=R5Zy9w8PrRAcrboWchJ/Zk8nqUY2e/2n0OfIF7ubxnQDRUDpm0KJjyeSYunND5PvmD
 jmPxom/yJQa8wabeR1krUd9cm7aARFIMn+c5Mltt1UD3oXYJgxuVlDKc2TwbNFbm3ka5
 IGnvSHRjfSDFYPvQ0R0w5bE2lTqeY+7f+czuw5LpMp87Omcke7cEQHpDTtbZRCKEdYLF
 Sq6mi+lm+xR0pHRvfBXIDi8BfL+I70WYky1YrIvx56zDX05kefcLQgBWGjw/S++GYK99
 fvBVAjon195BoZ0o0bsQB6kTCLD+T9QKqSlbwG0EJMqBadrS9TlJMw35b6Uk9SGb0Scn
 AsFg==
X-Gm-Message-State: AJcUukefjoGgpn4XTN3SHJmjkRuAIOTp1/nxtCvdbYeaKHoJ5lSpSl7S
 xPEavN9ZDZs9wDIGhqnStA456w==
X-Google-Smtp-Source: ALg8bN48XbZpc/7XwnNE112fo8VcA1h2Tot+eMsP4TZ3TubNUgilRPPeFrZUr5WpmZiFVxYgbc+Knw==
X-Received: by 2002:a19:7919:: with SMTP id u25mr32430275lfc.18.1549035792565; 
 Fri, 01 Feb 2019 07:43:12 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:11 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 16/23] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI
 DSI support
Date: Fri,  1 Feb 2019 21:12:25 +0530
Message-Id: <20190201154232.10505-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074315_206515_A985A079 
X-CRM114-Status: GOOD (  12.13  )
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

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so add compatible
for Allwinner A64 with uninitialized has_mod_clk driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index de7d9dcb049f..a0697d78b915 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1252,11 +1252,18 @@ static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi = {
 	.has_mod_clk = true,
 };
 
+static const struct sun6i_dsi_variant sun50i_a64_mipi_dsi = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-mipi-dsi",
 		.data = &sun6i_a31_mipi_dsi,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_mipi_dsi,
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
