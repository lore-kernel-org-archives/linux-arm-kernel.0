Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E33C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB882086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EW6dd9F6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YjpI9uyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB882086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y+4vTHHOs+7HGDYuzCuOS8msfYoaGiDo5KNR6megVww=; b=EW6dd9F6VIdbPl
	TF5wnxdq+MVBlbLK54catN56xfPIhrk3MI6C8pDQ2Pj4MawyEgASoHWcwuCn2wwpsGr4TY7rCawJt
	dedo0BglPVTRM5Nur1A89PCzocZQCVgaNiJYxp2FbbwETvzgBRS/owsfU4iOtJcaCpd13VsBvyJf9
	keFxSKiD/wv7/+xptIEZ9bEOYuBTy6X6zgJRgkDl3vlsr4aFNTPs23bluqyBhQjaRXZF2tArP+4NJ
	JYCpm3/QckSML33T6tVHg0BbuP6Jedj6TwhsF8tBGj1sVbhtJvSHA8Wq+6IxHRKI+B1XEgn8JFbPz
	JdCt9MgByDbmuElHg0+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK8k-0001Qm-Nh; Mon, 10 Dec 2018 11:54:22 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK89-0000f5-ER
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:53:49 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so3192862wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Bcn7Nsev8NGAHdGxA2CyTs91LsMBI3kRpXrLo25w3c=;
 b=YjpI9uyvVGMO6LS5MdUtlDjNGajW/FxA6Mjmxj1N7ULm0sxFRRnvPJwI+Da0lyCCuh
 0emA8jKtCTc3w14tUfuYj0DaorNBATkK+WEDslNItPHrlDC8DHcoery6lyYKzUgcxgDw
 72oUss0aiUtgGOdirmzlx8LGQ4/4v1CNXMjyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Bcn7Nsev8NGAHdGxA2CyTs91LsMBI3kRpXrLo25w3c=;
 b=GGHfUZKc20Hqdxvq81fXqfTMs1r4r/fUybvsflAT9aSOMwcQRxLaRMN2/RNK5gs+wt
 2FfSS3f242kFiDE9RsEURogDkxBSjtnqdOsJUFxHf2htJK6BthL3ySwLsqwzEMImVr0a
 9JMKyXogIbyB9E8kNW3bYdMdcDIRKD2xXAn9C3o4ODYmTqmp2x4yV3UGJbMrANbH67FM
 2b2nq71LxS4tZZDOkVwubYJXfIms78iYdXn8qda2lGMYUMntltCZCVPhWZn9f5RprAhZ
 jeHMb8sgV0LHeeCJzBj7iHD0OVdvaLobTUD0iUBNodBCF5kgCVii9SsE59OetclcWMQ4
 GvOw==
X-Gm-Message-State: AA+aEWbk2npStenk9fg6BKp+SL7ECdVU7Ftr/Ca1B8DWC9c3NaQs55ng
 JnXL2w+vkmuLgBEhHI6paUFaLA==
X-Google-Smtp-Source: AFSGD/WneMvv8yoBR7/U/wN5Xra1d6NpoFupLgw9CXDW+dAJHlajBAGIBUqpgVAnXY/wCmr+DuSI6g==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr9183651wme.62.1544442813661; 
 Mon, 10 Dec 2018 03:53:33 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:53:33 -0800 (PST)
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
Subject: [PATCH v3 3/6] media: sun6i: Set 300MHz mod clock for A64
Date: Mon, 10 Dec 2018 17:22:43 +0530
Message-Id: <20181210115246.8188-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035345_750767_C6B02946 
X-CRM114-Status: GOOD (  13.15  )
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

The default CSI_SCLK seems unable to drive the sensor to capture
the image, so update it to working clock rate 300MHz for A64.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index bbe45e893722..4b872800b244 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 		return PTR_ERR(sdev->clk_mod);
 	}
 
+	/* A64 need 300MHz mod clock to operate properly */
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
