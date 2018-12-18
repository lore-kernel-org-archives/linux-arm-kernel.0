Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD1AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB498217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rCxRka+6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m/xol0We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB498217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7roQ6/gHtA6sRTSm8UZtSZ4C6aHMHaK9i3ooVcMphA=; b=rCxRka+6akp4+W
	yqX5w/nkvs6krEekt+XHJl0zM4QAOpkL+qG+7UCN6xcQdkfVBubNdUZ9hFeVNFBLMX1+LbwMTn/FP
	GCyCqAdY3Yh6adloJfgGAis7oFdBG+q+mGR+SsUaG4bAdv/k/J6pQxTbRHnYv9B43T9BFLws4vonV
	eB6LLKb2aPrB8D8MLvAcmk7aqWC+Uaz2q/l1CCql4gj+Q0a5HqabsXJkT8aO2G5wBR223MtB9zlBu
	0KqlTyyk2OEBLtd7fzGmtu8cFWQdu/rqKDkvf0DndQfEiOOv82wy9rbkTNYwqPq1Rhel/292sIwas
	4l1QkLsbdJ7Ts6sre/lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDdr-0002xB-9n; Tue, 18 Dec 2018 11:34:27 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDdC-0002De-NQ
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:33:51 +0000
Received: by mail-wm1-x341.google.com with SMTP id p6so2138435wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6G+51hXPmeJR9ykNhp8vQ9iLEEAvCO5U6f8uZ2c4pz0=;
 b=m/xol0WelzUvjOb1T7gtvzM4mgci6M70ZC8FZEHkbXqT8lEvWkJHMDQ9GOpcb19fLE
 pHJ0uhmcSgSRUac7uioa0q3x2H1FlaNGLGxjFPBlDveAupR+YQkGrckjLrEPfPPy2QPP
 xUpoBfmp8Zefpkr5jcXvQ2OD1/fv0s7LMGvZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6G+51hXPmeJR9ykNhp8vQ9iLEEAvCO5U6f8uZ2c4pz0=;
 b=rmHJNE3fBI2uZykvpJlqea9AsxL+/Z9hS8qMnXUPCbiNMjoRU1LP55LZkPx0DzY19h
 Ns2ARfU8JdG/e+1GeOGhS+saNoijq/RTzk2JGrmHfKSsFM2qZgL6IvaAxH/MngjTUbnH
 YYENd7VPTjzidyzxro2AkW+fPwnaful8gYMETFiGLzacTe7mw/GQoXE6L+wC41FgXfmv
 8cGn4eV/47BM2HQ5EilGmsX/wmv7F8VUZYARJNsUH9VcgzXMvQM1s8OeP2D8xulQr/Ft
 yvK8JmWgGGkPK5nVd1fOugTOqciYn6JvwzlYOXSkn1Z/9xHg/K55fka9x6r7ANLCV8aX
 t40g==
X-Gm-Message-State: AA+aEWZXDbhF58k02w/NtNbVsOC/5B5OqvEFiPttnD+1rBrgxYssmtD7
 9VfGOgQZ5HO56lA6f5ExHVlyQw==
X-Google-Smtp-Source: AFSGD/VOWlFuoZVOKeDauoI8dplqjyg7Myu1NWvkW4rp7yL8UmE9dMhqeOQS6ejn/ZLTwjoTsx/0wg==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr3000248wms.70.1545132815033; 
 Tue, 18 Dec 2018 03:33:35 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it
 (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
 by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 03:33:34 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
Date: Tue, 18 Dec 2018 17:03:17 +0530
Message-Id: <20181218113320.4856-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_033347_341754_1D225A20 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Unfortunately A64 CSI cannot work with default CSI_SCLK rate.

A64 BSP is using 300MHz clock rate as default csi clock,
so sun6i_csi require explicit change to update CSI_SCLK
rate to 300MHZ for A64 SoC's.

So, set the clk_mod to 300MHz only for A64.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 9ff61896e4bb..91470edf7581 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 		return PTR_ERR(sdev->clk_mod);
 	}
 
+	/* A64 require 300MHz mod clock to operate properly */
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun50i-a64-csi"))
+		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
+
 	sdev->clk_ram = devm_clk_get(&pdev->dev, "ram");
 	if (IS_ERR(sdev->clk_ram)) {
 		dev_err(&pdev->dev, "Unable to acquire dram-csi clock\n");
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
