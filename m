Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A512086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJJsmLh+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CDiPyZ3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A512086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yV7Qmm7ZMG3wfTj1NDrQYJPFLn4mPQsDkSXYZwPS03w=; b=DJJsmLh+djrkcx
	8gX+yN242aOUAyM5vOzY8RPay455gxIMSYL6fVGV4mxhsynJ6xVdRWN4NFEK8uaZvpgU8k5KTBS55
	qxVDYbNpV2k1DQoVrhwVYVM4qlP1O0PX151XU9ZL+Dom9D7unG1T8tsv25z+thvEqiVmmCNPU8IKJ
	9Q8D+xyXyoM8YXMrYDFE22U3PVV0JlDe+de11J1aDQLN2ffTY1HMSt7pBpNfCon8wUkEVcEUr8FVH
	xYmxQrCpRdLlyleKMpNiio8ONrkkk1fBvIAXnZIIqhKmG7n3hUJaV4BSu2uXfCtsDVfELtrk1dt32
	I6Lg6iqpuA3CodRFAXzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVnP-0003fG-No; Fri, 18 Jan 2019 15:10:59 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVnB-0003Qe-9J
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 15:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wqdWYYzEXHPNGO0trMQbRhqUNzAiZrqEkqlBtIdZxas=; b=CDiPyZ3FzHAx3ztYRZjB5hVdM8
 OyEQ4mfV+3r+zbdD3LDtNviuPOsBEQeL9p8YousbnIZstFJIMTcrc3zb565LDtVMPjOrtrTY/vrpq
 fTY/PR79wS6IM3VR3Ylmaqq+1Rp94xmWuXWykQFwSf899S1VvJTOqeIN6j7KpLAAfkZOPHiubV+1e
 2rStlVzvObli/V1/h8IU1zR3mSqDNJOv3ct43jA1AzhQHsy1cNPnsXaGQzKlC1sBjlhyBbPlg+b1d
 hpkLvqGIh189kUsQzPwoinKX07ekiFlN7k01gGZdAUXmXXWe9CP9Mye/bYtLipi+17v4VqR6cKnZW
 5z+oC3hQ==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVVV-0003Rm-S7
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:52:30 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 72C9620DFF; Fri, 18 Jan 2019 15:52:28 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 011CC20CC8;
 Fri, 18 Jan 2019 15:51:46 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 23/23] drm/sun4i: frontend: Hook-in support for the
 A20
Date: Fri, 18 Jan 2019 15:51:33 +0100
Message-Id: <20190118145133.21281-24-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_095230_025455_007C662E 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the appropriate device-tree compatible for hooking frontend
support for the A20. Since the hardware is very similar to the A10, it
shares the same quirks (which were already introduced).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 53e4dbe466ff..e8239d4d4dd5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -715,6 +715,10 @@ const struct of_device_id sun4i_frontend_of_table[] = {
 		.compatible = "allwinner,sun4i-a10-display-frontend",
 		.data = &sun4i_a10_frontend
 	},
+	{
+		.compatible = "allwinner,sun7i-a20-display-frontend",
+		.data = &sun4i_a10_frontend
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-frontend",
 		.data = &sun8i_a33_frontend
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
