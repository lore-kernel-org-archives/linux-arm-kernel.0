Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDAC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949121726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hB1sSDgo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TCD0TRN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949121726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=35Cww0oA/3Ij34XFXjhvTThSFXeQAA3n4zrRIJtqZjg=; b=hB1sSDgoJ1Jwbv
	lEARgmTXi8jN1YivWh7R4DH9wDuWZ3FwnIKnMoqPuHt3J4Jp7L6ViiekCCDTXU8x/Cyo0jHDRUIPl
	MKRn1KdRa4IQ8Q+eqH8tHgKfxJqQGuLGo5eUgUfj0XWFImy4g37oKrASBj7RyVcoLxMb0aTc+V1c2
	GJuFpHwm4AuC+8E3Ip3groOpTjy2HGpmZEEMY3xpmxcntzleRM7e6AV1NXN6ulmec36u2rSs0KoTL
	DeH21qG7bXi9/yQ2AdQ3lUYF4RjyAK2kBQYlCefgzOa6nOck0TotVs8SjhT+Sar2JXJ4jF1DX2wIU
	zHe826hinYNCv+SokNfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlBZ-0001S3-Bx; Thu, 24 Jan 2019 20:01:13 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAA-0007Pe-PU
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:06 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so3391848plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EkDBLnbNod31G2yEaFX2CmKKS0jTQnqrj15H3QWvn9U=;
 b=TCD0TRN38afPd8Zhe1O+pYkOUH9l5R+moib5iY6n5hpyBrxb53upzWLLGzkDYl8E+I
 gTUUj61LciP1lsUReMlCJjvy9FiZefnOeCTMzcBQ0IwfE1S/WNJFNnF0RLMGmBVLhm1Y
 /4rXYrgXjGbn0Kg6zLVn52zjLpm0bhHsidHbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EkDBLnbNod31G2yEaFX2CmKKS0jTQnqrj15H3QWvn9U=;
 b=a9oaXIk3iRRP1+WMWCtiw3bkrf0rRQC8Ecm7RRmoEHghaLzfL0L1rOCljT8zQTAWmH
 Q2zV/iRhXrkQhUZoUAtjeHdfWUg+FvC2d8M3jyaFMj1VDVC0kcSo7pL9oEsXJxdB/Olz
 EMioA6/UB+meXEpLD09xagZKwdFnMs+K2oF11CFXCCCWp/VKaSHfKslYYy/XpPOKCHGu
 obxAEG2kinGrC9EukQn2sh58zCNVu497Xau5d1Wxolde5I0XvtoR8xo84/l9TUXxAgLQ
 0O8J5dI7ih17MCWehZechWZZ8LRVLKlD29vIderuTJIpHuKGcz2svr6ZpIQ7UaDZhykz
 qLqw==
X-Gm-Message-State: AJcUukc6bFhUCsUNBosXP9YckabAisd5xKtTpiv7yBiebzJlUz173NrL
 JpoIAZ4IGuTUi23h8yApsIh+xQ==
X-Google-Smtp-Source: ALg8bN4QkLSV0WFm3xl4VI9OHOoNMAnX0RC7j2nesGatXwzQg47Fp7+0f439shiK4E3EI2iSUdNhvw==
X-Received: by 2002:a17:902:28aa:: with SMTP id
 f39mr7941512plb.297.1548359986023; 
 Thu, 24 Jan 2019 11:59:46 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:45 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 05/22] drm/sun4i: tcon: Export get tcon0 routine
Date: Fri, 25 Jan 2019 01:28:43 +0530
Message-Id: <20190124195900.22620-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115947_453824_D9A6B6D7 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0420f5c978b9..3da75a0c5c5d 100644
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
