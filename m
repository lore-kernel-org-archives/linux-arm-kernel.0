Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21887214E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KrJJdMgt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IbLRTBEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21887214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6QqBhz4plfksOoiK3soHCaO4kMIwJCuHiP7UPhVwMeo=; b=KrJJdMgtQUH8fznXR+MFSl/pDX
	fU2OlcEUOofiL/Lo4u6rCH3xtdVdyQFMz1gfkoyfG478/PduX6jB7as3lgEryXJ5Pkm+VPYG57u2p
	ZTgyQA831dN4mNKK8X/8RQVD5b/k3ChtnrkEfR5AKfHSUYkCsEHMGOE7fuOX7M4rOXQgGBrULxgYe
	S4eKEwNVYi4Muk7MOX3lgJ/j3Sj/LDbszqhMofcYBSJRMn7F5C+WdIrxtkkAHzzh0jxMLwHLMipqJ
	dkHasWpHjiJTy302mIVlhtlmDSxPjiY2IuCgWqiR2MmivPD8DBQbwRVJ+YGf/+gyqQ+jVhAp53CH7
	+k7X1Yfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmK5-0000ks-4D; Fri, 14 Dec 2018 12:12:05 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmIq-0007uj-V1
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:10:51 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181214121040euoutp02b83948c3cca89803b69ff21dbda7a74c~wMc_6ef-M0861108611euoutp02l
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 12:10:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181214121040euoutp02b83948c3cca89803b69ff21dbda7a74c~wMc_6ef-M0861108611euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544789440;
 bh=R86hvHcr4RqSX4ALDbytEehmsG+3tPVMFf+mxGZ0o8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IbLRTBEWWQALIMMWbs8CEaHjOQcTN7ucNohZAgWjdP5p4IG1rf8UhSY7bFPvxEmqC
 i3ea16+YdC4rzfJfQU9Boy6BR9lLYPLf+VPGfl7yayam31h7xYy2A6C+FAOIzdbw9R
 lYDpOWNqHgNYfMxolUgWIJgChCWDAkzOecOa5ONY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181214121039eucas1p1f2b41003a918eab54a3c502dece0d777~wMc_KnfAD1061410614eucas1p1s;
 Fri, 14 Dec 2018 12:10:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B8.7D.04294.FBD931C5; Fri, 14
 Dec 2018 12:10:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121038eucas1p20a2aec53761cacb8e4ee57f9f2aa1167~wMc9d5EFE0911909119eucas1p2B;
 Fri, 14 Dec 2018 12:10:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181214121038eusmtrp107fa9abe1a0b0da439b5e0ef2bc0919f~wMc9Hgmn82638626386eusmtrp1f;
 Fri, 14 Dec 2018 12:10:38 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-28-5c139dbf31e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.91.04128.EBD931C5; Fri, 14
 Dec 2018 12:10:38 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121037eusmtip27979f972f7e5d102709e321e4701a5e7~wMc8aSSsQ0092500925eusmtip2B;
 Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 6/6] drm/exynos: mixer: Make input buffer color range
 configurable
Date: Fri, 14 Dec 2018 13:10:21 +0100
Message-Id: <1544789421-5265-7-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzvd88rde3pGL+pZc5qNG+1Wr8ttd5WT/+xZC22uniGccfucfKy
 liSFyuEPF1EtvQyR65CrUcJNxiUv6eq47dQIWYcWUjkP9d/n+3n5fr777UdjkjbCjY5RJHJK
 hSxOSjri9e1zRt/mUqfwgO48V2Sq7ibQ9e4OEarV1BDI8Pw+QH2zUyQqGFbjaHSoB0d51nEM
 GY1PKNSVMUEhrXWAQL36WyTSGJtE6HGrmUJ3v9fhyDLWDJC5sBUgTeEYuV/CllWlsdqKbJJt
 +GEh2LKOYHY41yBin5ZfYA16E8Xe0FUAdlq7OcjhlGNgJBcXk8Qp/fedcYwenPuDJzR7JWeq
 K6l0YPTIAQ40ZHbCybcjRA5wpCXMIwDzJ64AYZgBcOh1ESUM0wBWD30mVyNFnaMrwkMAb9c+
 oP5Fytp0wO4imV3wo9m2nHBmPOFifsXyXozRE/CbdV5kF5yYEGhpMOM5gKZxZgv8pHGx02Lm
 KMzU9WNC22b4oTt7GTswLHygL1/eAxkTBbM6NUAwHYaVjSO4gJ3gV4OOEvAm2Fl4DRcClwA0
 zQwQwqAG8FVlzkpiD9QOfhXZr8AYb1ij9xfoA7CnTk3Zacish4OTG+w0tgQL6oswgRbDq1kS
 wb0Vjut05Grt6PTsymkszMzoFwkPVAJgjWWMVAP34v9ldwCoAK6cipdHcfwOBXfOj5fJeZUi
 yi8iXq4FS5+r87dh5hnQ/zrbAhgaSNeJowsk4RJClsSnyFsApDGpszj0slO4RBwpS0nllPGn
 lao4jm8BG2lc6ipOW2MJkzBRskQuluMSOOWqKqId3NJBsO/NbxG4VeXx3rAtNcbHVuozN89l
 GBZ4trElsq8qNtsiO7nbtVl6+eq9pueTIHltyYmAjkXv4tB5U5dX8Evzvje2hbD8T4dCbBeD
 G3V7j2gKlbZcLPXL8amQ2ne7km+El/dmHTusqlbU/yRdggJfZHq6nPlh9dK6t+fJz8f/OijF
 +WjZ9m2Ykpf9BUrA5FdYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7r75grHGLy+IWNxa905VovecyeZ
 LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
 Ysb5fUwWa4/cZbdY+HEri8WDl/sZLe5OPsJoMWPySzYHIY95a6o9Nq3qZPPY/u0Bq8e8k4Ee
 97uPM3lsXlLvcXzXLXaPvi2rGD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
 NDaPtTIyVdK3s0lJzcksSy3St0vQy7jx8z9LwX6NipYJq9kbGM8rdjFyckgImEhMP/2CvYuR
 i0NIYCmjxLQlM5ghEjIS8872sUHYwhJ/rnWxQRR9YpRY0TeZCSTBJmAqcfvuJ7AiEQFlib8T
 VzGCFDELHGOVmPh+FTtIQlggSKLv5HQgm4ODRUBV4s4MMZAwr4C7RMuWq1DL5CRunusEszkF
 PCSW7VrCCGILAdW8mvmFcQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBUbTt2M8t
 Oxi73gUfYhTgYFTi4T0wRShGiDWxrLgy9xCjBAezkghvWKtwjBBvSmJlVWpRfnxRaU5q8SFG
 U6CbJjJLiSbnAyM8ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD
 o/Nc43SZ1teND+serjRxFQ9VyOUyNOgRlD6brsf810VVNz70anu5etvhAPYDa7RYV/6UjD+k
 /O7u9rNvwrgMYiWvbTi22/LO1Qem6as+fVtSOk1GMudCobBuw5mAT1V7KyYb+C6fKlFvdT5+
 kSWrkrTgx8rLk5eY2d6V+uNRcFnRYnbSjXU1SizFGYmGWsxFxYkApMsaXrgCAAA=
X-CMS-MailID: 20181214121038eucas1p20a2aec53761cacb8e4ee57f9f2aa1167
X-Msg-Generator: CA
X-RootMTR: 20181214121038eucas1p20a2aec53761cacb8e4ee57f9f2aa1167
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121038eucas1p20a2aec53761cacb8e4ee57f9f2aa1167
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121038eucas1p20a2aec53761cacb8e4ee57f9f2aa1167@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_041049_308952_63322B79 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 David Airlie <airlied@linux.ie>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mixer hardware supports RGB input buffers with full and limited range.
Set the csc matrix accordingly to chosen range. Note that range setting
has to be equal for both graphic layers.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 57 ++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/exynos/regs-mixer.h   |  2 ++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 895c6268025d..035d635188d7 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -35,6 +35,8 @@
 #include <linux/component.h>
 
 #include <drm/exynos_drm.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_crtc.h"
@@ -133,7 +135,9 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
 				EXYNOS_DRM_PLANE_CAP_PIX_BLEND |
-				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND |
+				EXYNOS_DRM_PLANE_CAP_RANGE,
+		.range = DRM_COLOR_FULL_RANGE,
 	}, {
 		.zpos = 1,
 		.type = DRM_PLANE_TYPE_CURSOR,
@@ -142,7 +146,9 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
 				EXYNOS_DRM_PLANE_CAP_PIX_BLEND |
-				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND |
+				EXYNOS_DRM_PLANE_CAP_RANGE,
+		.range = DRM_COLOR_FULL_RANGE,
 	}, {
 		.zpos = 2,
 		.type = DRM_PLANE_TYPE_OVERLAY,
@@ -389,13 +395,19 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, struct drm_display_mode
 
 	if (format == HDMI_COLORIMETRY_ITU_601) {
 		val = MXR_CFG_RGB601;
+
+		mixer_reg_write(ctx, MXR_CM_COEFF_Y,
+			MXR_CSC_CT( 0.257,  0.504,  0.098));
+		mixer_reg_write(ctx, MXR_CM_COEFF_CB,
+			MXR_CSC_CT(-0.148, -0.291,  0.439));
+		mixer_reg_write(ctx, MXR_CM_COEFF_CR,
+			MXR_CSC_CT( 0.439, -0.368, -0.071));
 	} else {
 		val = MXR_CFG_RGB709;
 
 		/* Configure the BT.709 CSC matrix for full range RGB. */
 		mixer_reg_write(ctx, MXR_CM_COEFF_Y,
-			MXR_CSC_CT( 0.184,  0.614,  0.063) |
-			MXR_CM_COEFF_RGB_FULL);
+			MXR_CSC_CT( 0.184,  0.614,  0.063));
 		mixer_reg_write(ctx, MXR_CM_COEFF_CB,
 			MXR_CSC_CT(-0.102, -0.338,  0.440));
 		mixer_reg_write(ctx, MXR_CM_COEFF_CR,
@@ -560,6 +572,20 @@ static void mixer_layer_update(struct mixer_context *ctx)
 	mixer_reg_writemask(ctx, MXR_CFG, ~0, MXR_CFG_LAYER_UPDATE);
 }
 
+static void mixer_set_input_buffer_range(struct mixer_context *ctx,
+					 struct exynos_drm_plane *plane)
+{
+	u32 cm_coeff;
+
+	if (plane->base.state->color_range == DRM_COLOR_LIMITED_RANGE)
+		cm_coeff = MXR_CM_COEFF_RGB_LIMITED;
+	else
+		cm_coeff = MXR_CM_COEFF_RGB_FULL;
+
+	mixer_reg_writemask(ctx, MXR_CM_COEFF_Y, cm_coeff,
+			    MXR_CM_COEFF_RGB_RANGE_MASK);
+}
+
 static void mixer_graph_buffer(struct mixer_context *ctx,
 			       struct exynos_drm_plane *plane)
 {
@@ -647,6 +673,9 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 		ctx->mxr_ver == MXR_VER_128_0_0_184)
 		mixer_layer_update(ctx);
 
+	/* set the input buffer rgb range */
+	mixer_set_input_buffer_range(ctx, plane);
+
 	spin_unlock_irqrestore(&ctx->reg_slock, flags);
 
 	mixer_regs_dump(ctx);
@@ -917,6 +946,25 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
 	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
 }
 
+static int mixer_atomic_check(struct exynos_drm_crtc *crtc,
+			      struct drm_crtc_state *state)
+{
+	const struct drm_plane_state *pstate;
+	enum drm_color_range range_val[2];
+	struct drm_plane *plane;
+	unsigned int cnt = 0;
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
+		if (plane->color_range_property && cnt < 2) {
+			range_val[cnt] = pstate->color_range;
+			++cnt;
+		}
+	}
+	if (cnt == 2 && range_val[0] != range_val[1])
+		return -EINVAL;
+	return 0;
+}
+
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct mixer_context *mixer_ctx = crtc->ctx;
@@ -1096,6 +1144,7 @@ static const struct exynos_drm_crtc_ops mixer_crtc_ops = {
 	.disable		= mixer_disable,
 	.enable_vblank		= mixer_enable_vblank,
 	.disable_vblank		= mixer_disable_vblank,
+	.atomic_check		= mixer_atomic_check,
 	.atomic_begin		= mixer_atomic_begin,
 	.update_plane		= mixer_update_plane,
 	.disable_plane		= mixer_disable_plane,
diff --git a/drivers/gpu/drm/exynos/regs-mixer.h b/drivers/gpu/drm/exynos/regs-mixer.h
index 5ff095b0c1b3..7d558e3dd46c 100644
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -158,7 +158,9 @@
 #define MXR_LAYER_CFG_VP_MASK		MXR_LAYER_CFG_VP_VAL(~0)
 
 /* bits for MXR_CM_COEFF_Y */
+#define MXR_CM_COEFF_RGB_LIMITED	(0 << 30)
 #define MXR_CM_COEFF_RGB_FULL		(1 << 30)
+#define MXR_CM_COEFF_RGB_RANGE_MASK	(1 << 30)
 
 #endif /* SAMSUNG_REGS_MIXER_H */
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
