Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F55C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5175920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0ZLBEyI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fi8MqaPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ReZo0pFYv3h0IM2E1cXhoGvv0AZBDmTWLiyB5ZtsBI=; b=I0ZLBEyINDttZh
	dU7WG//61xSSm+eh+S/ElacGpiZVR8N7rgDx7jM+OvDruX5fDbzsZranbAgXyisYo6GKcoIoaF6tX
	7fV+/ZsB4KwSJH/s1NHNKmA1iA9eEg1ZDE9ar1Lv/RqMAkN2MurgRFGIkXQWTSDH50uZDSrpdlbQC
	nNtqU8e1qafnxqYR67isSyiiM666+iiAjcvftIQq5fgO7eMIgh8/2VTVnZUg0DffRtUKwioq7vUzo
	9rFG/QaICuGDDc1Jd5v065vUSDaiGaUKA5zv912cKnHCUj/P8eBrvN+tPl5pln70zO3CkuEomatZV
	hQ6ml4VEoIIHTTILt/+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMlw-00078l-7M; Thu, 14 Feb 2019 19:34:12 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMky-0005sn-Iy
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:33:27 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so3549494pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2IvGrusmnL/Aou1wugSnS6px5st/Z0p64m7B6OiPnzc=;
 b=Fi8MqaPcIxGKR7Yzp0F8zn6F1VZ/N22K3AfaYUJXqdIeKAlYZPwmHaiFjwjRCcB0Kt
 2fEzYBYvqfk3C6DASFb+0QLNeEIxsuP4g0pJxBPetZpJnilhPokZgiBKz/DHMFJAiB8X
 dMEUBFpENR3eyuV/myAH9aCFmqWwERt8EXQ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2IvGrusmnL/Aou1wugSnS6px5st/Z0p64m7B6OiPnzc=;
 b=oJk5S+uibBW/ftEMXYIh813xRiWD7kDtDNQ4JgC9n5IDByOJnOHhAsJzOjXz5g075y
 yrdY2JSnzAeg4W7SVjUivMOG/FplfVev94ss3mYbPrpSypYlRZz2HjI+o3zj+JZ7Hryl
 z/SoS2ch4W/JrJIpSbk4Tl4Nb+eUEt9Csr+rYE6pGObY+UMvn9P0artyjImCwRri7Jc3
 rn/PdG8Dpa/t9F+zWJO6A8Bz/8TIpS6d4jejj+uiG3mtTgfToGI/t7O9aZgmmohv+55e
 LJUK7ciWtrFsrjP2AvHZ2e0/5AaMOmekqYklg+YswL9+NEdcEWSi2NNvftyk/IUWYA9W
 8sLQ==
X-Gm-Message-State: AHQUAuarp1sD6zmC9r2vTZ2MylpTi7Hx+kU24TO4dA+V5gh0cUhzgLBS
 eACbGYN0iFVcRMOEGF3EhqbK6A==
X-Google-Smtp-Source: AHgI3Ib+1+e8H9z4Pwke0tlc8r+YEYJdjpJ38IlWiXWurtSImc7BJmn9yEj1Vf3/xNFL5r+kAJ2fuQ==
X-Received: by 2002:a63:e410:: with SMTP id a16mr1483811pgi.28.1550172791847; 
 Thu, 14 Feb 2019 11:33:11 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:33:11 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 06/10] drm/sun4i: tcon: Export get tcon0 routine
Date: Fri, 15 Feb 2019 01:02:33 +0530
Message-Id: <20190214193236.7504-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113313_195329_3493A8A5 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sometimes tcon attributes like tcon divider, clock rate etc are needed
in interface drivers like DSI. So for such cases interface driver must
probe the respective tcon and get the attributes.

Since tcon0 probe is already available, via sun4i_get_tcon0 function,
export the same instead of probing tcon explicitly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 7136fc91c603..4bb36ceb786b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -221,7 +221,7 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
  * are located in TCON0. This helper returns a pointer to TCON0's
  * sun4i_tcon structure, or NULL if not found.
  */
-static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 {
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
@@ -235,6 +235,7 @@ static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 
 	return NULL;
 }
+EXPORT_SYMBOL(sun4i_get_tcon0);
 
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			const struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b5214d71610f..a52696db14a5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -274,6 +274,7 @@ struct sun4i_tcon {
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm);
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
