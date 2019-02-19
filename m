Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6519C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EC921773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4jn302q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onSOAUnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EC921773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5qj+wVHdhps/Ie7mp+adQKCgCX5OaUmZA71+vOSHHYI=; b=i4jn302qagkonj
	cevvyHqF+yiPsCu+OIdDnKECUQz76dKSn5ZlIC7cJDDIjv2dBjlAPUkwD+uUTMd2qrtVGNKA0Mw+z
	k/cTVDbpaWTLotqxegHWROEc/a8PrNuMx6YoljOCOkvKGw1B9GPE2kYm0o2W0SZSV2iXJRdmL3eVm
	81ptkrAjVDEV+lBQR2t8TDC+LVsdSveXG84fLY3o0M2Nl+dMOcx62QFRFID0v3cYXbsiFZbESOfJQ
	+n5PnEdkY4jW3ghkTPvb4tMZn6gq7BrYEMTgwHBqHTbdFMApwsqw19AaijH82fsUSOVd/NJRZ28hD
	lR4gbZ2uas57NYr+DxRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2MC-0007RI-1q; Tue, 19 Feb 2019 10:10:32 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2LC-0005HZ-9A; Tue, 19 Feb 2019 10:09:42 +0000
Received: by mail-wm1-x342.google.com with SMTP id e74so1338826wmg.3;
 Tue, 19 Feb 2019 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zZsaRWsv8rJ4Zc0/xYkKmtb0SxRSmk27SRf3LWFvUUI=;
 b=onSOAUnxjUZ1MDJyL+IweR/xShBOQKKhZ9SDCol4WinFICdYvbq+nywYyYYMLHXNeP
 6mruoNiD9NSwCtEsBI9Us/90MWaSq9P+gKb7yN1EF50FQt/7VObUfrVUO2TDAUoqq7cx
 4zBpu/iEtyDSFbarxyVJ6ZQqhkkrV9Kk2MZ8wu4u6BgNmV43JTkYxO0hy0s7n/rqZFcj
 xjek30UPfByJ8FkI8NlyNZ0Ec9sSjVy2WBulnx0FxkfOHu7TQ45n7MwdrEaYYX4XSrbU
 ax/F387clcipfDKMy+bDWd1KC1sbuQ5RbOCYY+rfxYAo8XKiO64rs1w1eByNtwpv6ZUY
 yKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zZsaRWsv8rJ4Zc0/xYkKmtb0SxRSmk27SRf3LWFvUUI=;
 b=SYsXm5oDBp5wEQY4DkZnQAmMTALakWKWAnYqtnBTLhmHQNn6t0Go+XpCEK3Qa6QkOc
 NCO66aESXUrnM9C2TZKG+vJLT6PcvSybABcgzjzJ9b1/y7P4iKeRmI+DxfVfWcQP2XcQ
 HA9ZlmIjRdWbgyKy8iw9KyvlsDZkdvkfU5rDznNmM5p/BACSJHyXeRlVyFJycmKZkW0E
 uZcGfu6uvX020FCYyOvURJD/SKpGKAfRxCzLhX5OoCHcWo7Y0KycMBuvuCjlM2oTFfNg
 bPj0Nuhu+zYSfS26enHeNYvcZNvoEkrPPrr/rTOzcqHdw2Rcp/PV13Sr6SIRuBG+4xqW
 SZOA==
X-Gm-Message-State: AHQUAuYmrjLP7koa8hrt7TSke2tehK5UFMdBKHuvSO12eOIQh5KUBtxV
 TNiLuJen/M+NNEiilS5CacUgdp8d1w==
X-Google-Smtp-Source: AHgI3IbERLcge4my/B95slL350C+6FDOWd18AFiV+nYQEHbJ3sazsMGtSlsFo7E3mpzeRMPO9y699A==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr2258626wmd.110.1550570967694;
 Tue, 19 Feb 2019 02:09:27 -0800 (PST)
Received: from localhost.localdomain (esm-84-240-79-214.netplaza.fi.
 [84.240.79.214])
 by smtp.gmail.com with ESMTPSA id f68sm3542053wmg.5.2019.02.19.02.09.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 02:09:27 -0800 (PST)
From: Urja Rannikko <urjaman@gmail.com>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH v2] drm/rockchip: vop: Support dithering to RGB666
Date: Tue, 19 Feb 2019 10:08:48 +0000
Message-Id: <20190219100848.2222-1-urjaman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217134255.6287-1-urjaman@gmail.com>
References: <20190217134255.6287-1-urjaman@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_020930_447674_4FFFA256 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: Urja Rannikko <urjaman@gmail.com>, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, hjc@rock-chips.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Splits out the dither register bits and introduces
the same config enumerations as in the rockchip kernel tree.
Tested to fix the banding on my ASUS C201.

Signed-off-by: Urja Rannikko <urjaman@gmail.com>
---
This is a version of the patch that is quite inspired by the rockchip
kernel tree (that i hadn't looked at enough), but still keeps
to just implementing RGB666 dithering because more changes
are needed to get the information in place for detecting RGB565,
but adding that should be easier afterwards.

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 25 +++++++++++++++++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 14 +++++++++++-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 18 +++++++++++++--
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0c35a88e33dd..98c8b5b7627b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -951,10 +951,27 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	    !(vop_data->feature & VOP_FEATURE_OUTPUT_RGB10))
 		s->output_mode = ROCKCHIP_OUT_MODE_P888;
 
-	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc == 8)
-		VOP_REG_SET(vop, common, pre_dither_down, 1);
-	else
-		VOP_REG_SET(vop, common, pre_dither_down, 0);
+	if (s->output_bpc) { /* Only dither if bpc known. */
+		if (vop_data->feature & VOP_FEATURE_OUTPUT_RGB10) {
+			if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc <= 8)
+				VOP_REG_SET(vop, common, pre_dither_down, 1);
+			else
+				VOP_REG_SET(vop, common, pre_dither_down, 0);
+		}
+		if (s->output_bpc == 6) {
+			/* Enable allegro dither to RGB666 */
+			VOP_REG_SET(vop, common, dither_down_sel, DITHER_DOWN_ALLEGRO);
+			VOP_REG_SET(vop, common, dither_down_mode, RGB888_TO_RGB666);
+			VOP_REG_SET(vop, common, dither_down_en, 1);
+		} else {
+			VOP_REG_SET(vop, common, dither_down_en, 0);
+		}
+	} else {
+		if (vop_data->feature & VOP_FEATURE_OUTPUT_RGB10)
+			VOP_REG_SET(vop, common, pre_dither_down, 0);
+
+		VOP_REG_SET(vop, common, dither_down_en, 0);
+	}
 
 	VOP_REG_SET(vop, common, out_mode, s->output_mode);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index fd5765dfd637..92050de140b6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -68,7 +68,9 @@ struct vop_common {
 	struct vop_reg dsp_blank;
 	struct vop_reg data_blank;
 	struct vop_reg pre_dither_down;
-	struct vop_reg dither_down;
+	struct vop_reg dither_down_sel;
+	struct vop_reg dither_down_mode;
+	struct vop_reg dither_down_en;
 	struct vop_reg dither_up;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
@@ -268,6 +270,16 @@ enum scale_down_mode {
 	SCALE_DOWN_AVG = 0x1
 };
 
+enum dither_down_mode {
+	RGB888_TO_RGB565 = 0x0,
+	RGB888_TO_RGB666 = 0x1
+};
+
+enum dither_down_mode_sel {
+	DITHER_DOWN_ALLEGRO = 0x0,
+	DITHER_DOWN_FRC = 0x1
+};
+
 enum vop_pol {
 	HSYNC_POSITIVE = 0,
 	VSYNC_POSITIVE = 1,
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index a6db3cd5544b..59266c473795 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -137,6 +137,9 @@ static const struct vop_common rk3036_common = {
 	.standby = VOP_REG_SYNC(RK3036_SYS_CTRL, 0x1, 30),
 	.out_mode = VOP_REG(RK3036_DSP_CTRL0, 0xf, 0),
 	.dsp_blank = VOP_REG(RK3036_DSP_CTRL1, 0x1, 24),
+	.dither_down_sel = VOP_REG(RK3036_DSP_CTRL0, 0x1, 27),
+	.dither_down_en = VOP_REG(RK3036_DSP_CTRL0, 0x1, 11),
+	.dither_down_mode = VOP_REG(RK3036_DSP_CTRL0, 0x1, 10),
 	.cfg_done = VOP_REG_SYNC(RK3036_REG_CFG_DONE, 0x1, 0),
 };
 
@@ -200,6 +203,9 @@ static const struct vop_common px30_common = {
 	.standby = VOP_REG_SYNC(PX30_SYS_CTRL2, 0x1, 1),
 	.out_mode = VOP_REG(PX30_DSP_CTRL2, 0xf, 16),
 	.dsp_blank = VOP_REG(PX30_DSP_CTRL2, 0x1, 14),
+	.dither_down_en = VOP_REG(PX30_DSP_CTRL2, 0x1, 8),
+	.dither_down_sel = VOP_REG(PX30_DSP_CTRL2, 0x1, 7),
+	.dither_down_mode = VOP_REG(PX30_DSP_CTRL2, 0x1, 6),
 	.cfg_done = VOP_REG_SYNC(PX30_REG_CFG_DONE, 0x1, 0),
 };
 
@@ -350,6 +356,9 @@ static const struct vop_common rk3188_common = {
 	.standby = VOP_REG(RK3188_SYS_CTRL, 0x1, 30),
 	.out_mode = VOP_REG(RK3188_DSP_CTRL0, 0xf, 0),
 	.cfg_done = VOP_REG(RK3188_REG_CFG_DONE, 0x1, 0),
+	.dither_down_sel = VOP_REG(RK3188_DSP_CTRL0, 0x1, 27),
+	.dither_down_en = VOP_REG(RK3188_DSP_CTRL0, 0x1, 11),
+	.dither_down_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 10),
 	.dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x3, 24),
 };
 
@@ -473,8 +482,10 @@ static const struct vop_common rk3288_common = {
 	.standby = VOP_REG_SYNC(RK3288_SYS_CTRL, 0x1, 22),
 	.gate_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 23),
 	.mmu_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 20),
+	.dither_down_sel = VOP_REG(RK3288_DSP_CTRL1, 0x1, 4),
+	.dither_down_mode = VOP_REG(RK3288_DSP_CTRL1, 0x1, 3),
+	.dither_down_en = VOP_REG(RK3288_DSP_CTRL1, 0x1, 2),
 	.pre_dither_down = VOP_REG(RK3288_DSP_CTRL1, 0x1, 1),
-	.dither_down = VOP_REG(RK3288_DSP_CTRL1, 0xf, 1),
 	.dither_up = VOP_REG(RK3288_DSP_CTRL1, 0x1, 6),
 	.data_blank = VOP_REG(RK3288_DSP_CTRL0, 0x1, 19),
 	.dsp_blank = VOP_REG(RK3288_DSP_CTRL0, 0x3, 18),
@@ -707,7 +718,10 @@ static const struct vop_misc rk3328_misc = {
 
 static const struct vop_common rk3328_common = {
 	.standby = VOP_REG_SYNC(RK3328_SYS_CTRL, 0x1, 22),
-	.dither_down = VOP_REG(RK3328_DSP_CTRL1, 0xf, 1),
+	.dither_down_sel = VOP_REG(RK3328_DSP_CTRL1, 0x1, 4),
+	.dither_down_mode = VOP_REG(RK3328_DSP_CTRL1, 0x1, 3),
+	.dither_down_en = VOP_REG(RK3328_DSP_CTRL1, 0x1, 2),
+	.pre_dither_down = VOP_REG(RK3328_DSP_CTRL1, 0x1, 1),
 	.dither_up = VOP_REG(RK3328_DSP_CTRL1, 0x1, 6),
 	.dsp_blank = VOP_REG(RK3328_DSP_CTRL0, 0x3, 18),
 	.out_mode = VOP_REG(RK3328_DSP_CTRL0, 0xf, 0),
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
