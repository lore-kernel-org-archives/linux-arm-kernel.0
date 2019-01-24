Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0705C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B0A21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sbz0kAqw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MzCBl01/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B0A21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EWv1cfnGmHhHtd+EKoy1UFedFm7RGcIOu1nUA8krRc4=; b=Sbz0kAqwJYn0lU
	oxnJZ/jw0+Xr0X7wUFMfg2Ge2QGHOO3I4/IULCnZB6m12+GZ7iToAW5dT83H61MTnhWvnRc67D5Hx
	hI0hztiPsY3Ez0OTmZwYgRNpAdINol5wmzq2Thy+b3vCO6EoLGS7jAPE433u05PiUX3a2TlPaWXW5
	C2PZzlnmJ77WITovFFKccAklpkJzr0D6QQtfjmYMxFVxpA7AqnNIuNu5Tz+iYVhTRFSNV1r64zf15
	cpr0cGVNR73QD15jgTumzuxP5e46Iz9zR6rVtptNEJ9CIA6dt4vpcNDT2mmjwryPTPCS8klyNihDg
	MEu2dQbYrw4tPK9YdLiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlEu-0004Ki-Hg; Thu, 24 Jan 2019 20:04:40 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlBK-0001DD-Ql
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:01:07 +0000
Received: by mail-pl1-x641.google.com with SMTP id e5so3384999plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NM8sVvN3Te6g1rqXOdAqs2KSOeU1frtX72ddxyLNR30=;
 b=MzCBl01/KEWGjIvWEHBS8QjD6yS7sBjuX8vMC1wntVcgcKGdBBB6xfLjy62P7oXNGc
 ClR+2tbn6U1g2/wbTV4rignbYp91Q6e4q+1SEBY05XnGZfzPc1ZQdgQytM+d/B/78ZII
 v2R66+PdrttXkbBTjj9YJ5wHCZPspEmS8pdlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NM8sVvN3Te6g1rqXOdAqs2KSOeU1frtX72ddxyLNR30=;
 b=Y4uQaeV9i7kvOLeZNS5G6JE96Y6PYlUe0x8BbfDfbGMBOCdFg1WVyo8suXbs9ELdAj
 6kJ6E68ih/w0I/73fB3LAeVFUaaecW3Q7xu+sV7Hvlvmhslv1Y+mIQ8M5fvjmPVaMSqJ
 fTEs8qtPmmZM14s98GIk6uhVYZpPlD3AmloyKB4oftBt9lBAotZUCygwspiCET0IcGFY
 3Vg40QrdkU8ZWVcM52IINnoEMViS5X+6WUgCj4qJiRoAJ/kV1aJWT0e2KLQcCb4ghSVm
 r6+7ifh0MNMWOpcoeL7M42W9sB8WVB0o3qoysCRhzmncsurjkQpmtkidgkZO8Hn7ZGER
 DjmQ==
X-Gm-Message-State: AJcUukdE0N/FEbdG1ZnJDgTyIhphlCQmyYMEDLwQ2GY4HR4JgPEHi8P2
 bkw+obUGyUdGi0w4zJymhPc3wg==
X-Google-Smtp-Source: ALg8bN4qeWnLZUxwNxKPUT5z6WnCfVKyW3VbHKtNjoOBm1gRK3mCVUtBVWmtP016p/gOy0jyHQd6dA==
X-Received: by 2002:a17:902:2969:: with SMTP id
 g96mr7811174plb.295.1548360058106; 
 Thu, 24 Jan 2019 12:00:58 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:57 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 18/22] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
Date: Fri, 25 Jan 2019 01:28:56 +0530
Message-Id: <20190124195900.22620-19-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_120059_803448_86BFB66E 
X-CRM114-Status: GOOD (  11.41  )
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
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 9be414131460..58bda0928aef 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -983,6 +983,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
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
