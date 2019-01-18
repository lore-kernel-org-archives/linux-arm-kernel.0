Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC05C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACA220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F+kOVrb0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xiHVx6rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACA220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NVGBmPkb5omxD1gjZaSVKlkIMQxx7beJB9MhhZNVuQg=; b=F+kOVrb0VnfLga
	5R1R3HIfkvvWVwYZVFFWJWdRILT2gwTSm1Ra8Bk3SLXR7/CgL1Ka1s6lg89png6bOyms9eK3X3XTP
	Eb8phvd/WCxA1kJtTPoyxAa8D8MxuCYq2tqgCQxt1VlhzRT1QQnhX4SgMv6U6DD5GBQDf4WXzw3IW
	C7CvL9i3LNYfAMGmVz7zc7QjkftfxPFp4TZcKF6IYuIvtsB0hPaZIWrut/lA9O1kfWdvvKOlP47cn
	tjOlQGR+4bzaGhb62kpqNJFeFvhDp3SYkdDFSuG3DSBQTga8deYlWuXkpXhQgF/OVvdSQNtogQ1dv
	gSh61q5zf+LftvdXRfDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVxg-0008FF-5q; Fri, 18 Jan 2019 15:21:36 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVnE-0003Qe-42
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 15:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x/MdzDmJK94LVEDi4LG5jePD5pzgvmGhsY3jjsLB6Sw=; b=xiHVx6rp8u4zS5zVsklA44xdAC
 OIcCOSeAP7bYdSGX5gNqBZxLQmKzHv5Ty8mEYwFmxEom2Z/hrmkmMD8Jp+mNElp1jTxXVVPxaCA7/
 AmR2ki0KBjS9U6soVGMSaMiGXq8Qr2EC5reP0p1KmKgdf8j6cT+Cr8Se6bMsw4pWsb6vK9OkoO6wV
 Z1kUink9/USgkZJBhTy0+q0PjkaeaNdDvUtalY1CnUcoPMXXHSteoaJIdrmziEKDYuum5v4nZ6LZO
 VIbwfIXxZjPbg9Fus6IOtsH49YaseVkdNCYuCD/YYH6NAFeclzTTkv85qqEthLcIVMwf/ZAzKiqHs
 WipffLsw==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVV5-0003OX-Cj
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:52:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 29AD222491; Fri, 18 Jan 2019 15:51:56 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id C2AB620BAD;
 Fri, 18 Jan 2019 15:51:44 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 15/23] drm/sun4i: layer: Add tiled modifier support
 and helper
Date: Fri, 18 Jan 2019 15:51:25 +0100
Message-Id: <20190118145133.21281-16-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_095203_540689_ABF6BF33 
X-CRM114-Status: GOOD (  12.81  )
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

This introduces a list of supported modifiers for the driver, that
includes the Allwinner tiled modifier, as well as a format_mod_supported
callback.

The callback uses both the backend and frontend helpers to indicate
per-format modifier support (including for the linear modifier).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 8cf8ca997b1d..c5a999ca1d72 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -114,6 +114,13 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
+static bool sun4i_layer_format_mod_supported(struct drm_plane *plane,
+					     uint32_t format, uint64_t modifier)
+{
+	return sun4i_backend_format_is_supported(format, modifier) ||
+	       sun4i_frontend_format_is_supported(format, modifier);
+}
+
 static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
 	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_disable	= sun4i_backend_layer_atomic_disable,
@@ -127,6 +134,7 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= sun4i_backend_layer_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
+	.format_mod_supported	= sun4i_layer_format_mod_supported,
 };
 
 static const uint32_t sun4i_layer_formats[] = {
@@ -157,6 +165,12 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
+static const uint64_t sun4i_layer_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_ALLWINNER_TILED,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						struct sun4i_backend *backend,
 						enum drm_plane_type type)
@@ -173,7 +187,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 				       &sun4i_backend_layer_funcs,
 				       sun4i_layer_formats,
 				       ARRAY_SIZE(sun4i_layer_formats),
-				       NULL, type, NULL);
+				       sun4i_layer_modifiers, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
