Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C61DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0684C20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZOLShIM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V52neNJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0684C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RAXtcgt433kvZP8Zh6kNLzh0ikUDTJjFoW0QbTyf9mg=; b=cZOLShIML71q3/
	sgVj6Qk1T6Etp138O4hWMMYJSXcDOpSYsq3laQrJPNGvlC2COowBHbw+X/ohM2V2D/t7T9eHfsXAq
	ARkmS57pscObBRNt+KIomaFrbMFMyCcEXueh07VkT9NgCD/H7SVD8JMzpkGBCTPigRMNbgaaTF1dW
	9gRYG/1tEw3SPgxVlYrCkSW7Y0gm1GbLMSgQou8UHH+026WITJMatnVUT+s9CKQVM6xuigUf+X3+Y
	XmIL/pDxO8eLBCdNyvUsCXZCNy9zynoGIcCkziwMI8p6doUXeT9RvbGUes4EKt1OyM0eu3pVUZmJb
	k08RMYKzWZ5eRGdycO1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX51-0006KO-OH; Fri, 18 Jan 2019 16:33:15 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX4A-0004wd-Iz
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:32:25 +0000
Received: by mail-pg1-x544.google.com with SMTP id v28so6279949pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AcTNJoiSIr2UvGcIYC+6yeK1JimQepwB20Vv9L6yJsk=;
 b=V52neNJr+5s5Ws7YreKtc2b0uXnFaD/GlUykSFfQFbUBiHU1Y5clMVBSrpHzW39P4d
 r1Dkduqwp8D1wV6rlNp4bKfRDblmhN302+64PH4JhlZ2akOt82XQgeIfQ6wDBq3SG9Na
 6pB6Gm0FeqPnXFlvl9K0nySUPInlzSdgm7q88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AcTNJoiSIr2UvGcIYC+6yeK1JimQepwB20Vv9L6yJsk=;
 b=syIBbmhhG3DJd0tWpTcthXoJ08sQVNFxkFG60g5LqhD44DxxOU8cDdwsKhz4nXuMp7
 GnLmRAaC+6jysZPd4lxZZkNyFlPFAp+uwBG5ygM09qpxhkF+wuDhwiAR4XQ+jGqhBDC6
 SCSrekHllH3KobZTGhjiaOT67ovTBmRQKuwkD+rHS5VaWLG0jFl431lu6fLfTuiRSHXe
 OIRx+bqpiQNAQbPOAiOnvt6uD2Ux2X8ObWj7XMDRDWNsbK8qp055x3zviSp4VZt+VcCI
 cTBBp4Bk0dFGHh5oLcFdgFt+7xhLhK320sjdiTGi5RA5k0sWPu8E0bpYcqzxdWZPDfU+
 8H3w==
X-Gm-Message-State: AJcUukdf7T11LRqFsbDsSIsqHcIK6VlwUENcJOn4j/G2bzrNgkdiR30n
 NIGWuwGNqkq+XAyFJPCrEZNHzQ==
X-Google-Smtp-Source: ALg8bN4o3QTXvzSyHghbovl3uuhczhuTH4f7BPtE96v9dSt5mHU0Qhbh1OmAJLTa98g0kwf0LPl6AA==
X-Received: by 2002:a62:8985:: with SMTP id n5mr20180814pfk.255.1547829141742; 
 Fri, 18 Jan 2019 08:32:21 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 08:32:21 -0800 (PST)
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
Subject: [PATCH v6 3/6] media: sun6i: Add A64 CSI block support
Date: Fri, 18 Jan 2019 22:01:55 +0530
Message-Id: <20190118163158.21418-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083222_891993_362A404F 
X-CRM114-Status: GOOD (  10.97  )
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

CSI block in Allwinner A64 has similar features as like in H3,
but default mod clock rate in BSP along with latest mainline testing
require to operate it at 300MHz.

So, add A64 CSI compatibe along with mod_rate quirk.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index a9aef630c3b4..d03559d27066 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -909,10 +909,15 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 static const struct sun6i_csi_variant sun6i_a31_csi = {
 };
 
+static const struct sun6i_csi_variant sun50i_a64_csi = {
+	.mod_rate	= 300000000,
+};
+
 static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", .data = &sun6i_a31_csi, },
 	{ .compatible = "allwinner,sun8i-h3-csi", .data = &sun6i_a31_csi, },
 	{ .compatible = "allwinner,sun8i-v3s-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun50i-a64-csi", .data = &sun50i_a64_csi, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
