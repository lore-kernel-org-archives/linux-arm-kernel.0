Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:56:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79C021738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTxiOCGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79C021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gPmLTZLoYmbRVnJtgWzO3bEpBGi3HADouN8SV3QoiaU=; b=FTxiOCGFsH8tVr
	7R+bfL7EMqSVTB4Mwf7U7PfD+NkNBRpRvjt21YeuPsOKPfNZsJNUhAibs7g9KXhlnjSyEpelIrIzZ
	F5OX3GYPlen+cV4QZlqcLD7LxYaQK87dpTVTlsZKOOAj8/TrkehRgOw44yIOfG4a18vGsq34K2wzN
	s/6XbjeNAh9hpIisg75iCpHtpkPF/zBYFVRPGkoZz1uPbVcFUjTihq3u0ddD6YSx+JxXCFP9SPt9K
	heyaBixgKjhqXSsJgZkSo28Mu56dLh91wkBD2gaeXKvPWg87pTESL1UgQGfdijb3TPdnwdywdhVnU
	IibXkImXcjhXhJAY/tFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goDxA-0000pZ-7D; Mon, 28 Jan 2019 20:56:24 +0000
Received: from mailoutvs23.siol.net ([185.57.226.214] helo=mail.siol.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDwE-0008SO-LP
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:55:28 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTP id C5AE4521E2D;
 Mon, 28 Jan 2019 21:55:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id 5t8Gu2vJ5f1b; Mon, 28 Jan 2019 21:55:22 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTPS id 7E87F521CC1;
 Mon, 28 Jan 2019 21:55:22 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Zimbra) with ESMTPSA id 27402521E2D;
 Mon, 28 Jan 2019 21:55:20 +0100 (CET)
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com,
	wens@csie.org
Subject: [PATCH 3/6] media: cedrus: Add support for H6
Date: Mon, 28 Jan 2019 21:55:01 +0100
Message-Id: <20190128205504.11225-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128205504.11225-1-jernej.skrabec@siol.net>
References: <20190128205504.11225-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_125526_850724_14FB785C 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, robh+dt@kernel.org,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

H6 has improved VPU. It supports 10-bit HEVC decoding and AFBC output
format for HEVC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index ff11cbeba205..b98add3cdedd 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -396,6 +396,11 @@ static const struct cedrus_variant sun50i_h5_cedrus_variant = {
 	.capabilities	= CEDRUS_CAPABILITY_UNTILED,
 };
 
+static const struct cedrus_variant sun50i_h6_cedrus_variant = {
+	.capabilities	= CEDRUS_CAPABILITY_UNTILED,
+	.quirks		= CEDRUS_QUIRK_NO_DMA_OFFSET,
+};
+
 static const struct of_device_id cedrus_dt_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-video-engine",
@@ -425,6 +430,10 @@ static const struct of_device_id cedrus_dt_match[] = {
 		.compatible = "allwinner,sun50i-h5-video-engine",
 		.data = &sun50i_h5_cedrus_variant,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-video-engine",
+		.data = &sun50i_h6_cedrus_variant,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cedrus_dt_match);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
