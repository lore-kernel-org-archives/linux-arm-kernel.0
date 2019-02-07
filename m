Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FA0C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943CD2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dfBkK6Nd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nrih6dDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943CD2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3E2kzCyruMCNCGQfV6BMWiOzqcUwWsGdrAS+fYKp1tY=; b=dfBkK6Nd7+5lXn
	HyrBuC9NoMjPVzyM0v8hxFO4bzCD3PUdIVPbOfWX3U/XNKGzjdQDOQp2lu65ngXiPteWP7rU4PNy7
	L11hPUe55w5Exg0p+6VCwsHAaHqFdGOANw/e3f2tV8aZBgintEybe3suxwKe5Fm24bKU1KtPYWJxn
	pIBsq/TxA2k+YGwg5nj1A78cqZWcWMsWKoirS+t4E1hGubXQxUrT/J5+E+uxMgbW7oOsUDPfinF4m
	TS08q4p3n34R9EZdzLWGqBqB6ngLEE6GY6lKM9IG5Q8j/g1QWE50r2KPkxDP9/Xt4wuUB7sQdNdTh
	8v06ktik8NvryXuS8hUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfBS-0004eK-3s; Thu, 07 Feb 2019 08:37:22 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfBB-0004PK-H4
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 08:37:06 +0000
Received: by mail-lj1-x242.google.com with SMTP id v15-v6so8506500ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wZHPggfSt3jojrbcWHOqN6DfKMWRWCRtzNWm965aV4w=;
 b=Nrih6dDkrP6THUl5lMvF5x+eGdOKA5ADhX/D+dGHeW8XXC05JCL9DDmiAxrR00xRE8
 pa+/EYjaCn782md0/Jn2i8v6W14fhWm/5gEr4Hkaf8qi5NCZjcrTp9M4XJA1f1f5sIG3
 H/xRMo6Xv4dnftKW0i55hDXLOV+ErEkH8T8XLXA9K8cidBVeNczmrUjC4ybsSmOlPTSa
 XYLuR7HAh61yKnTG++45E3qFdfALVwTAKhPDEfY8TfNQQ7lw1eSKmh8eUtdhnNgoxNhW
 OMiwkXT2KoLsZjVsLy2SgzyM3k5+l1EzXsnmQF/6IyUGHhn9tb+f1GSmL1XAsGvqDBkh
 imgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wZHPggfSt3jojrbcWHOqN6DfKMWRWCRtzNWm965aV4w=;
 b=Db6/wvpzj/myEGEqfDrj+r7UvyznHHo6+0iICQPngJ78W7nDJxasyB3vqNpKI5xGaC
 dbQyxQh3Ti8duWVdJHgta2HkSx58ssahh5T5IAUFtQ7uu7twtKtc/urBpIA5Sq91rPQ1
 0W6XsnXB9iBblR9R/XyezaWERcAvarbKEQwQp5LMlTDcFmXnnfd8JZz9Rn+athwB8UXD
 mUBLdTysuhKaAP7m89oK+Q53hbYmTwor0kLsqYuSrbj9hKv/xCxgJpxJpa+2huNirNFW
 xrDMQmfFkuALNY+NkpPpjjr9ZWPLjffyiYKKrBhSw7W4oVWvDuO5qqty/scgMN1e+KiP
 v48A==
X-Gm-Message-State: AHQUAuZ3B2iOzWpKRDErux01dTlhj7HpNz7JyCYjADWgSyoKkriOyETN
 oCUWv/rxK8NSRTE000p0TK6qXg==
X-Google-Smtp-Source: AHgI3IZqOIYkoCS4OnM/SQ9bT/ACUYmOOEb1KGcsLGo5sg5P0EE0Ufvu+Cwj3ZaYAfKHC8gkYmzdZQ==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr2779845ljo.10.1549528621358; 
 Thu, 07 Feb 2019 00:37:01 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l72sm470910lfg.75.2019.02.07.00.36.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 00:37:00 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH 1/4] drm/simple_kms_helper: enable use of external encoder
Date: Thu,  7 Feb 2019 09:36:44 +0100
Message-Id: <20190207083647.20615-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207083647.20615-1-linus.walleij@linaro.org>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_003705_565951_8883A415 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This makes it possible to pass a connector with an already
attached external encoder into the simple KMS helper.

This is helpful for my MCDE drivers, as it is pretty simple
but uses DSI to communicate with the displays and bridges.
DSI requires the use of the DSI bus which in turn requires
us to set up a custom connector from the display driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 917812448d1b..e7499b939235 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -266,7 +266,7 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 			const uint64_t *format_modifiers,
 			struct drm_connector *connector)
 {
-	struct drm_encoder *encoder = &pipe->encoder;
+	struct drm_encoder *encoder;
 	struct drm_plane *plane = &pipe->plane;
 	struct drm_crtc *crtc = &pipe->crtc;
 	int ret;
@@ -289,10 +289,23 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_encoder_init(dev, encoder, &drm_simple_kms_encoder_funcs,
-			       DRM_MODE_ENCODER_NONE, NULL);
-	if (ret || !connector)
+	/* Other encoder already attached to the connector */
+	if (connector->encoder_ids[0] != 0) {
+		encoder = drm_encoder_find(connector->dev, NULL,
+					   connector->encoder_ids[0]);
+		encoder->possible_crtcs = drm_crtc_mask(crtc);
+		DRM_INFO("an encoder is already attached to the connector\n");
+	} else {
+		encoder = &pipe->encoder;
+		encoder->possible_crtcs = drm_crtc_mask(crtc);
+		ret = drm_encoder_init(dev, encoder,
+				       &drm_simple_kms_encoder_funcs,
+				       DRM_MODE_ENCODER_NONE, NULL);
+		if (ret)
+			return ret;
+	}
+
+	if (!connector)
 		return ret;
 
 	return drm_connector_attach_encoder(connector, encoder);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
