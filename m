Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E129C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:59:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84DD20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dSASks2G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JMCP8xPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84DD20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NAXyArjiR/CxTL5W+Go7E813UnvbrKz4UvnKXl4GWGw=; b=dSA
	Sks2G1cu4C843cvD2oagSIpijtxErCN90mWn2bu0wr5WtH6fYxDKoEJOP/d+FcZT+BzSqtnTfRnMe
	CkTGGsuDT90lhiolcqG6dyPWHxgt6Ir96yW2Y1Xlsvu2FqlhMdbTFxbj4zqSR03KjjbkJ9C7viksF
	G0S3wuV2krC8qvD5tx2ILed/s7kjve4y7ljD4MleevOmTGx8k6BVYxeOv4ec9v8eclOqjGSnxR0NX
	w53PcPd+oGEfKY/DgrznqclvEfTXyfRtpPyKqfTwJS1QJDFm9J29de+/Z+TW1yoZhCuwuTuMJ3FU/
	DlIc4KolC0IJCj8u1vGQxZwoqKoRoqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh7ps-0007JW-8y; Wed, 09 Jan 2019 06:59:32 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh7po-0007J2-UM
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 06:59:30 +0000
Received: by mail-pf1-x442.google.com with SMTP id q1so3216299pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 22:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6AjmQoj4vZga1M05cboJY5gLkKlpnzB8nWkEfzeU72s=;
 b=JMCP8xPS+PH7DDjyTHv5NqjPaycfCstVNiYHZypDuTK0FROS+pR+a9BswBrk9KpsDH
 h9xteNBGEFTEmRAbNffAPozpdop93eV6WBziycD/fNBpELv6lp4QXXIwNdMtcLbKQXdI
 rqPmEUFOzvSNN1xLbcsuwrDUxiDM+yTzxIKs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6AjmQoj4vZga1M05cboJY5gLkKlpnzB8nWkEfzeU72s=;
 b=YW9FXPsAUoaFHuh+dX6a04QDu63BMj1AXFJ84EUkk5kZrh7GlTS991MVW4/1k5Czb5
 tP7opawzgM+SwOoRPKFCMCQTQpNo4VmnQq8NJKocE/rRmUMEFT4Ohn9252I5DTPbEYo+
 g+nlnNBOFjmi21PSfCXktFdBEf0rbcx42ZYQC6XrhNli8UVkrb/0dCSYdtftQklwzbzB
 WVxwdWID2y2xKHZs/Laikv4vLXMEMpkGazdsM7gE6OcU4hehfZZz57CbevqEiDoXsmuX
 PaFRcOXo4zV5NBIdNtQlcQnDKnZtT2a+x2In7IG8M9RkwmckhvrO3bzgII65HE2qVvik
 Nakw==
X-Gm-Message-State: AJcUukdB3fawH0sstvHCDkznH4yfa9GYW7omnzFJMs11kF3v61ydgw6Q
 hTuqDynS4l1X06AupZktAfV56dYm2w3fNw==
X-Google-Smtp-Source: ALg8bN4tfm8j6CoknFNirnHygNkSos3VA+xBsXL4cGYlnScOGW1mNK6VuEuM5CelRcqIkbU34vpxbw==
X-Received: by 2002:a63:ac1a:: with SMTP id v26mr4398523pge.293.1547017167532; 
 Tue, 08 Jan 2019 22:59:27 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:b852:bd51:9305:4261])
 by smtp.gmail.com with ESMTPSA id r80sm119773259pfa.111.2019.01.08.22.59.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 08 Jan 2019 22:59:27 -0800 (PST)
From: "Hsin-Yi, Wang" <hsinyi@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH resend] drm/panel: panel-innolux: set display off in
 innolux_panel_unprepare
Date: Wed,  9 Jan 2019 14:59:22 +0800
Message-Id: <20190109065922.231753-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_225929_001578_3DE6C6F1 
X-CRM114-Status: GOOD (  12.72  )
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
Resend for review.
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
