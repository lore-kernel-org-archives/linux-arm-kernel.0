Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1181C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810E22086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="soDKGjvf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mZoe0h9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810E22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ccSSYkaFQXWYrvrKDjQdGiOrrevgAk62uzt337rYIbQ=; b=soDKGjvfNVg/Ze
	qcKPw2MpGBHiiUOCA0eM5TtK8NfDYRsYV3zzcEYyi45hWllNanRRX+f8LQb5jWIUSN/Sfv2jDSWW0
	I9WfbYhYbuh3PUxjcQDotAOOVDjLB3j32Od1FHmKDX5ZxJY0h008/z/AGFbF5WjHdCDDMyRySE+W0
	G92vOsO+wVvk/8KPjkuCaLl+t2JuIc30VnMMiP6GNOP/rZLEHIP956ogxbjjeGNMnQ2gohMo4cwRi
	/+iaO1SUG6S+0x14/vsw+FU2GGilMGtH9sBNZ2A0WJaKfrS4eJ5a1FfoMH39Gbf3lvk4GivgoCpyn
	Gyx5hVTR9io4WpnvGdfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVnA-0003Qp-SQ; Fri, 18 Jan 2019 15:10:44 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVn9-0003Qe-MX
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 15:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=epTpH5zH5jqgobY5oBf0z8GAsXh5Z1VOIherPIeJQwE=; b=mZoe0h9d3uKE6aMjxcNWEIJdrB
 IpnzbFA5ZOYut+GSHfCegRsFe9yXEYaqDjhD78oOptnVDeb+NccvEvLNijN+bLS2SID6tGX7qBJ9Z
 VlappgKhVb28TKvJPrHrOxn5cA6NIu6vm7oNVpm/tbi9UVYUCy3oUZgBWI65B087J+bSS3fymdACY
 gCk4CCXAEQG7H/DkBnILq+ycDbNxfJvRc3ZUrwCP39Zw15UjcozimK05gwmNsXDnAQGaGfNKPQk+/
 ej6zkPW3eFjMWHw9hC/B2Dgkoukebjkk8nj/jS5n17S2wgu0GViP5QX5t7NNz0drlE+3A+7Ff6s7m
 F3Il57WA==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVV5-0003OR-UK
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:52:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 80CC5224CE; Fri, 18 Jan 2019 15:51:56 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5F2E120C2D;
 Fri, 18 Jan 2019 15:51:45 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 17/23] drm/sun4i: Move access control before setting
 the register as documented
Date: Fri, 18 Jan 2019 15:51:27 +0100
Message-Id: <20190118145133.21281-18-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_095204_113129_435540FC 
X-CRM114-Status: UNSURE (   9.78  )
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

From: Maxime Ripard <maxime.ripard@bootlin.com>

Unlike what is currently being done, the ACCESS_CTRL bit documentation asks
that this bit should be set before modifying any register. The code in the
BSP also does this, so make sure we do this as well.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1153539f3aef..88ac77518610 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -75,6 +75,10 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
 
+	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
+			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
+			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
+
 	for (i = 0; i < 32; i++) {
 		regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZCOEF0_REG(i),
 			     sun4i_frontend_horz_coef[2 * i]);
@@ -90,9 +94,6 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 			     sun4i_frontend_vert_coef[i]);
 	}
 
-	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
-			   SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
-			   SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
 }
 
 int sun4i_frontend_init(struct sun4i_frontend *frontend)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
