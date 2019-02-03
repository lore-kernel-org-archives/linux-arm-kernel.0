Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1731FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CA3217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ysau79Lj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjFccvht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CA3217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2CvnOjrUi52uJ63Gp1cNu5+Xwm3CFkSPnjHo4rk/iTk=; b=Ysau79LjiuQ+Qe
	jHDc3MrXvy7MnYBkV8K5iFp9BX5j6O0Zv1161xUJdAtggcu4zwy05OMVhZiUCg12fcmTFLjYZArMP
	YozizMS5nO01jk8wGWNySYdQ/g/81gpXOcOKPj6zIj+im/J9zTP92t0z/iyc/3vT0Edhnk466UT7Y
	E2IEQZSVUlk5yos9zl6GekjD6l/kH1u3PHvxOqcAtBJs/3UDvCN1jlK5B/jtp7iVcYYrxjq1xuGoa
	tNxXp34N5bD+qTbBJ03bIB6JjluqIyYiQwsNQh9LeFw733glapvmX+5Jidri+0p7qsoVlrh1f2Xao
	Sm+xOXpqQbxAF44qpuXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMx6-0006h4-Hh; Sun, 03 Feb 2019 18:57:12 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvd-0005E6-QA
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:53 +0000
Received: by mail-pl1-x643.google.com with SMTP id w4so5762263plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J3HkVQyg1bgdqlOuNsd9gIG4QKbDWhLCCN+a7fE0LAQ=;
 b=pjFccvhtiQ9mgd7Wq60ksQR0Rhp+s9Ory4pFo+eyVD1qki2BYEBScTzNa7gz3hpMKe
 oFK6i9fF+/J6dJbs+s6o2iy0mIVG4S+2H829Ma04kx7bJYsyEaO0HRZ+PU3iU2zjtk54
 4BzdbDZr5YiIovAn795WG+7aYXCr+yYDY6Sc9vBwt4MNLHABq1C4KTuSpXMl//sqc1Wq
 5xe5m0uG/79nUq/iVUATWfcHUXjaCUxpWCFwg+rPyllQQwTRKDAMdQrg8Emy79kMMRF+
 Uofx8NXLB7RAF00a6gL11CzvwJNOxj3WqpaSZJsyr9FsMhmxKEar8vzWrGQiewrZsxoh
 ukFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J3HkVQyg1bgdqlOuNsd9gIG4QKbDWhLCCN+a7fE0LAQ=;
 b=Vl+rRw4kVecsWBHp64AkWrx5VfcEvlVg8ezgNySM2h7/rc+2ybiX+b6//l3cXyli87
 QbBPqZLvgiuTQCZtd9ir6Na623Kpepfm3Zcail6fNjLYtKtqhklm0sukGIM343ZkWjMe
 e21+VDzVBRiYMS03iQL21QauOsrQX6ET2LTO+8RQt5DhI1y/gWS1JfF6xMO+fVtme1eC
 awf6dfYaEvBVS1Fr4bYVrj4lywp6W2ID7QeYh6dgDV8XtcYFl4isWBNJJEerrb6Xo5dG
 6a3HKSkKUey507+6fi0g+LUsi/4Oi+dJTsUUnLuBm8NhvcnnS5c0lFupgfcEMv7WSdY3
 CWDQ==
X-Gm-Message-State: AJcUukeuGbt0fKW229lxe5MrSmQTfv2MVUqGlCfiLDpvDEaGzUGNGcyB
 FWOGm/rS8hXiJekbEdLp7o4=
X-Google-Smtp-Source: ALg8bN5OwbywqHdgK7IjsCHN0cVGCDeCzrTGt/EjjFJJ+udYOHB2pigM5vvLSPoTSpzuzVCQojptww==
X-Received: by 2002:a17:902:690c:: with SMTP id
 j12mr48089523plk.206.1549220141232; 
 Sun, 03 Feb 2019 10:55:41 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:40 -0800 (PST)
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
Subject: [PATCH RESEND v2 07/12] drm/panel: simple: don't fail if we don't
 have panel desc
Date: Sun,  3 Feb 2019 10:54:56 -0800
Message-Id: <20190203185501.8958-8-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105542_564764_6F6EBFA6 
X-CRM114-Status: GOOD (  14.02  )
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

This is preparation for addition of generic eDP panel that
doesn't have any modes or delays defined.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9c69e739a524..2f2cb2d81f2b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -176,7 +176,7 @@ static int panel_simple_disable(struct drm_panel *panel)
 		backlight_update_status(p->backlight);
 	}
 
-	if (p->desc->delay.disable)
+	if (p->desc && p->desc->delay.disable)
 		msleep(p->desc->delay.disable);
 
 	p->enabled = false;
@@ -195,7 +195,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 
 	regulator_disable(p->supply);
 
-	if (p->desc->delay.unprepare)
+	if (p->desc && p->desc->delay.unprepare)
 		msleep(p->desc->delay.unprepare);
 
 	p->prepared = false;
@@ -220,11 +220,13 @@ static int panel_simple_prepare(struct drm_panel *panel)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
-	delay = p->desc->delay.prepare;
-	if (p->no_hpd)
-		delay += p->desc->delay.hpd_absent_delay;
-	if (delay)
-		msleep(delay);
+	if (p->desc) {
+		delay = p->desc->delay.prepare;
+		if (p->no_hpd)
+			delay += p->desc->delay.hpd_absent_delay;
+		if (delay)
+			msleep(delay);
+	}
 
 	p->prepared = true;
 
@@ -238,7 +240,7 @@ static int panel_simple_enable(struct drm_panel *panel)
 	if (p->enabled)
 		return 0;
 
-	if (p->desc->delay.enable)
+	if (p->desc && p->desc->delay.enable)
 		msleep(p->desc->delay.enable);
 
 	if (p->backlight) {
@@ -280,6 +282,9 @@ static int panel_simple_get_timings(struct drm_panel *panel,
 	struct panel_simple *p = to_panel_simple(panel);
 	unsigned int i;
 
+	if (!p->desc)
+		return 0;
+
 	if (p->desc->num_timings < num_timings)
 		num_timings = p->desc->num_timings;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
