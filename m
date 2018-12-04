Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF30EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3E72081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A6RoHZDD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3l4F2o3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3E72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0tsaZ7EFAMMlQtvpzuRDhH9tbu2nPFS15nPVq0o3h/k=; b=A6RoHZDDba3FoY
	ZMPlLZcpYeknm9QHsmJlAof7KceGi5kN9XSQGjNHzLVt68HnfqlnBSTyABgOE32gLfzh3E/T4DPM6
	2LUtoe8pWpkbODCPlcpezcGlPuP+dEa9Pa+ogQUgXj/pMHBs2t9shh+/GOt5dD5ysDRnuJAUs95My
	+uEe6Y3ySZgBng31YUc4XSFV68NTVF2vNh/QC86iZQDZg3kqfdwMPhp1PL2Xoqb3EXEzK92gxSJyd
	+ajf1mveU7+0oLCnL0WiSSQE+pStFLxd9W45D9wtDLYSSItQpkp/+G9uZTrc8w7ESCtj1+1/Stn4b
	KUeyvXSwLKvWfCAZiCHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCfr-0002ds-UW; Tue, 04 Dec 2018 15:31:47 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCfX-0002E3-By
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 15:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bth6g72J4PLdKrGOx47zqDJMLc5ZOdTd7BPv8ljYQRs=; b=M3l4F2o3QaxnkgpDIGtdwMozE/
 NE1Tf8PyUyZAKgKN28kB40BQInaiEmQ+fFuKe14mZ6Cj+s3CaN7pRDCQ7jRbUKAHTvfsAFqiTdGYd
 87yECWiv8mmqLE4SdL2GsQKIxpA3NVc4cdOaVFFE0cbYrMP47NH/CMw11EoJqQIOYgChXMJe1FTii
 utSSxHnG6qvFsR2y1Dax7B2fe2Rz3Y5SJirsPHKdVLPJkLgaKb0DPlM4KvJDMeFuRmv3JvbiZGlb9
 KHFH8vEVL3o/QjUQH43lOx2P6ttyzTkT0wTKTDCHE11tjXM05RoNY36KkYpoW5OLKVoZxAWKAjZmp
 EjKDvNwQ==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBc0-00021u-DZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:46 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8559720E8B; Tue,  4 Dec 2018 15:23:18 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 09D6020E1D;
 Tue,  4 Dec 2018 15:22:42 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/21] drm/sun4i: frontend: Add and use helper for checking
 tiling support
Date: Tue,  4 Dec 2018 15:22:10 +0100
Message-Id: <20181204142218.16284-14-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092344_593045_C4881259 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This introduces a helper to check whether a frontend input format
supports tiling mode. This helper is used when tiling is requested in
the frontend format support helper.

Only semiplanar and planar YUV formats are supported by the hardware.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 151b78d3c02e..d69d426c3014 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -120,6 +120,26 @@ static bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt)
 	}
 }
 
+static bool sun4i_frontend_format_supports_tiling(uint32_t fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV21:
+	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_YUV411:
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU411:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane)
 {
@@ -365,7 +385,9 @@ bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	unsigned int i;
 
-	if (modifier != DRM_FORMAT_MOD_LINEAR)
+	if (modifier == DRM_FORMAT_MOD_ALLWINNER_TILED)
+		return sun4i_frontend_format_supports_tiling(fmt);
+	else if (modifier != DRM_FORMAT_MOD_LINEAR)
 		return false;
 
 	for (i = 0; i < ARRAY_SIZE(sun4i_frontend_formats); i++)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
