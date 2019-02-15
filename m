Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0DDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D657D2192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cj35XXa8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlD9cM9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D657D2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kMW6sfkKzUeSvfHaNv8pdyzBqaf230IqwqgWD+8X1Pg=; b=Cj35XXa8FVT2dd
	6GHPQJ9aI/FHvS46Fy9k8bphG/1yM9ReSPLwNeSDdCObHOZV0v4BckLvoWFe8GD+64E4F/qhMlMDm
	F0/vEHOjeaAW86RVj06vF/gQMm5CsAImyq9gyLki7nwA4lGAwynd5H/qyLHLyDtuHrNuwa414Dh1i
	7l1gHcVycw5N6EXWTU+Kjn+m2iptDr48jG86u7gNzR4zdNyoZ+4lNwClxjxGEKytk+mVynDfk60ic
	2Z9i2vQTBjshpHRjzo/LBcGVy2UT5LVZ3Jca1RI8ic13PZK4lTMYUQqKmTMVm722BxQOR/0j+bttm
	5fQQxH4PDzsm3tdYcSGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVmr-00057e-Go; Fri, 15 Feb 2019 05:11:45 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlf-0003cW-K4
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:36 +0000
Received: by mail-pg1-x544.google.com with SMTP id h11so1865900pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZyZJb+ob6Qv28jOtpsZthUPniM2T1vjLSspFlfrMVB4=;
 b=KlD9cM9lQgh2Kv44/ub3U6AJfj277fqP/GXNvqOr1jgmE/UfClj0R5Xm7x7eUj4LYj
 Qi4i3a8wM2Sqba3hF9verxhImcDO8WMSSgT+KaDi2gmx5pYFENFC8VgLzoVhMrIUnT+C
 ybScqgXnom37eLyGAGl8B2x9WK/CKz7ORkbhYOLrK8jHBSuUtQW17m+pGGB9rl2n+P5M
 fud+fw6ZtUEdgG53KA7sZWl+gHr9dV17nydA6ytOXIhjKr+ud4Cy34QcyojL5XKCSzgf
 C4rwvUVIBrbfHPqBuxb1uiOpYWIvVacbbeTgg0o68ukpkNXHddxt4Z+VT29i1Ydk3PxA
 vjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZyZJb+ob6Qv28jOtpsZthUPniM2T1vjLSspFlfrMVB4=;
 b=RIvWBQjO0+u389alCDFi8cDg5riBxuNeIz9sDv8cHpZXvq9RowNxSmP8QfjjqmrCiQ
 6zmVgShBY1IRpnQQbUskIJfmM5MTu0tqeiAdOF9O+krHpr5UAtxvq8zjtl4QynkG0bJR
 7HpKOvMZv8d/bCUDugfK2jPjujoAbrhJ8/E7wB5Ij/BsxlFDGrTupA5ejda1QusHJfv9
 zV/UTRgQorLW2ixcku37rjhJDvab5q+ejWydRzmhe9+XcMRZNbF8EgZUkt9qAekQSpbp
 Z6BVNaLhQp/hgyUQ30ExARiWu63rZ7AD28WwvJGP4PGRi2WcPvcIWfD2xJEjoso2qdzk
 5jJg==
X-Gm-Message-State: AHQUAuYYIyJ/o1hjzthMx+MTenRAT3v0naspTqxL2Msq1Wq0r0c7Rf3d
 NpxrDQnI2YqtJodzI1VBsgE=
X-Google-Smtp-Source: AHgI3IZCi/JmcU0djeRHW5i59DMMIey6ducnQszKxoKh9U0BUaUX0WM9w9Xw66GiFYUy96gI82gLRA==
X-Received: by 2002:a63:134a:: with SMTP id 10mr3367772pgt.83.1550207430830;
 Thu, 14 Feb 2019 21:10:30 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:30 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH v3 08/11] drm/panel: simple: Add BOE HB140WX1-501 panel support
Date: Thu, 14 Feb 2019 21:09:54 -0800
Message-Id: <20190215050957.20755-9-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211031_957503_C076AC1F 
X-CRM114-Status: GOOD (  16.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This commit adds support for the BOE HB140WX1-501 14" WXGA TFT LCD
panel.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../display/panel/boe,hb140wx1-501.txt        |  7 +++++
 drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt b/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
new file mode 100644
index 000000000000..fc6f085eb8d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
@@ -0,0 +1,7 @@
+BOE HB140WX1-501 14" WXGA (1366x768) TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,hb140wx1-501"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9c69e739a524..9a4c9dd02c6c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -828,6 +828,29 @@ static const struct panel_desc bananapi_s070wv20_ct16 = {
 	},
 };
 
+static const struct drm_display_mode boe_hb140wx1_mode = {
+	.clock = 72300,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 48,
+	.hsync_end = 1366 + 48 + 32,
+	.htotal = 1366 + 48 + 32 + 80,
+	.vdisplay = 768,
+	.vsync_start = 768 + 3,
+	.vsync_end = 768 + 3 + 6,
+	.vtotal = 768 + 3 + 6 + 13,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc boe_hb140wx1 = {
+	.modes = &boe_hb140wx1_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 310,
+		.height = 170,
+	},
+};
+
 static const struct drm_display_mode boe_hv070wsa_mode = {
 	.clock = 42105,
 	.hdisplay = 1024,
@@ -2541,6 +2564,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "bananapi,s070wv20-ct16",
 		.data = &bananapi_s070wv20_ct16,
+	}, {
+		.compatible = "boe,hb140wx1-501",
+		.data = &boe_hb140wx1
 	}, {
 		.compatible = "boe,hv070wsa-100",
 		.data = &boe_hv070wsa
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
