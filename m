Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:40:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2D021903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K30WcF4f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWelxNgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2D021903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=520wzvt7RXRYFcoawIgL6BWUz3tvYuDlW3cGmvCUjGc=; b=K30
	WcF4fQYacwGCXLVabSvYuSz/GcdQbxiAovxOV/SwikQP91UURJCpkRCCpCQcutkbbhxSkEb+q95Kn
	EL5Pg3R4tXVTIpwz4WroXnUWhv1RO8E5rK2D/YHBIM+P2Oi8TYGUOFesn7r+n9AOurC6PIXq7KF3r
	U5tzRmY0QdeKHGXj1ip0yG/tn9rlmC6f4s7PoI2IuWyNRH37dSywOgJPG+VVUamtqV2BeJLacbzX/
	6TSN6Cl1F41c86eeTJYX0Py9MbboIbIeqVph8FQKtli25/KgFOUzZRxSHY4q3iNZB5HNe3Mn1+Bmn
	BcYykVydTT+w0Br6hgp37f9laqohhhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaBfU-0004oe-Bw; Fri, 21 Dec 2018 03:40:08 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaBfQ-0003yy-Fl
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 03:40:06 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so1854408pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 19:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=bJ2V06NMTy+xKzXTskQidTBx2BRu4+3E8mCUEpdOR+s=;
 b=oWelxNgjhzxb9CH3SM9kmZLNNk3YZnTmvwzHlCduSXmLYSn5ysFLKCS/OAMvVzzQ41
 9UzPZHPRDEuRbDAS09VAIdYWRbb91zncq9Co8rwQsJlQIfoXqy7kj87Cmy0ybMXi000p
 2crPikdG69GrDRp6RQq7V9GI50XTuCZL0Z2Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bJ2V06NMTy+xKzXTskQidTBx2BRu4+3E8mCUEpdOR+s=;
 b=QNw00D9RUtEkHeUAe6SGqDnp1O3yrjHQ6ZgnpLGdhZS8zJk8NjvlLs8xVah+kJ8FLV
 6nnBgnOxaAM3yTS5M1m3rgFcXDhyLc6KHTIePbSGD3J3wbI/FgbP1wN8DVKx8ZYjumOE
 ASszk5nQzoqc8rtbBVkKAzRstMclkofqO8DsAF9/X/HgPH4lmzhLOYe5nHzcBhsFr9yZ
 gn/R8c4Ishg/VjkDbtdjxyWUOpvI8mo3/O5qqSPFUjHBmxsdwYE3AiVnGrzI7WRDSR/O
 uRFklrFphDYPbs5urF52JYb00M2C0gG7J90XAXOrCGzOBh3J3eecinhc6mCBtBb/mXHV
 wwww==
X-Gm-Message-State: AJcUukfI2KN/rS6JuHGm71udX5Z2yq+6XMD5q8pMNUdDosRQwGZ9KHT5
 EzjSRrpQ4C2L0F6pREsDqna1JvNKq3Elkg==
X-Google-Smtp-Source: ALg8bN7APAmFGqjomZcpt/9bqbSIfcH852JAUIrOH7tvP7UpwbiMu8MQJtgnZ0perF/JjfgCCrVlQg==
X-Received: by 2002:a63:451a:: with SMTP id s26mr852194pga.150.1545363592366; 
 Thu, 20 Dec 2018 19:39:52 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:b852:bd51:9305:4261])
 by smtp.gmail.com with ESMTPSA id v184sm32063902pfb.182.2018.12.20.19.39.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 19:39:51 -0800 (PST)
From: "Hsin-Yi, Wang" <hsinyi@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] panel-innolux: set display off in innolux_panel_unprepare
Date: Fri, 21 Dec 2018 11:39:25 +0800
Message-Id: <20181221033925.42179-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_194004_552975_86DF56B1 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
to innolux_panel_unprepare(), so they are consistent with
innolux_panel_enable() and innolux_panel_prepare().

This also fixes some mode check and irq timeout issue in MTK dsi code.

Since some dsi code (e.g. mtk_dsi) have following call trace:
1. drm_panel_disable(), which calls innolux_panel_disable()
2. switch to cmd mode
3. drm_panel_unprepare(), which calls innolux_panel_unprepare()

However, mtk_dsi needs to be in cmd mode to be able to send commands
(e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
so we need these functions to be called after the switch to cmd mode happens,
i.e. in innolux_panel_unprepare.


Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index ca4ae45dd307..8e5724b63f1f 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 static int innolux_panel_disable(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
 
 	if (!innolux->enabled)
 		return 0;
 
 	backlight_disable(innolux->backlight);
 
-	err = mipi_dsi_dcs_set_display_off(innolux->link);
-	if (err < 0)
-		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
-			      err);
-
 	innolux->enabled = false;
 
 	return 0;
@@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (!innolux->prepared)
 		return 0;
 
+	err = mipi_dsi_dcs_set_display_off(innolux->link);
+	if (err < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      err);
+
 	err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
 	if (err < 0) {
 		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
