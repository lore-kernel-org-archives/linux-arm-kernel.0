Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B11EC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:06:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5B520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBEKAlD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5B520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4U+4yNno3c8XZHvd5QQD6yVwyxJTHH0vIf8rUmLy2tA=; b=TBEKAlD/KwPuxT
	P7WDNxwk4bs5epiiKpgL5RZIR5wsHxYjLK4CTD8qrS/fswxF/F5EwbtqTnA3QuAsCAG/kCgT+cAFC
	CSFSAheiDZdK2V5pMMkZ4Jb4kiTZmFaceaFcbQwzTHyOodE6wtUYEi1Dh/ZxubKUaylCd6c1aLULq
	OCKQZ+IOCzOplXGRkkTLff4u64dh/04FADgKq6oRFQ+vbnnsB26w8YVdoQeQBWMpEvoFLwgfmlpuK
	c5IkcYqMEDaLIAcG5heZT3H9OiHDMe1shmQ/BvNg61FB24r7bf2Z4Km+CZFhJ0zcpWLU1ULqUFZQr
	5cWwvBRbeCefZTHejcuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWISX-0002FK-2f; Mon, 10 Dec 2018 10:06:41 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWISP-0002E1-C5; Mon, 10 Dec 2018 10:06:39 +0000
Received: from p5b127812.dip0.t-ipconnect.de ([91.18.120.18]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gWIS7-0007uZ-Rx; Mon, 10 Dec 2018 11:06:15 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v3] drm/rockchip: support hwc layer
Date: Mon, 10 Dec 2018 11:06:15 +0100
Message-ID: <1640679.nbCe1t6P6s@phil>
In-Reply-To: <20181205135230.17677-1-ayaka@soulik.info>
References: <20181205135230.17677-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_020633_560671_0E000789 
X-CRM114-Status: GOOD (  26.12  )
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 5. Dezember 2018, 14:52:30 CET schrieb Randy Li:
> From: ayaka <ayaka@soulik.info>
> 
> The Windows 2/3 or a RGB UI layer is a high performance flexibly
> plane. It is too waste to use it as a cursor plane.
> 
> I have verified this patch with weston git version, I am not
> sure whether X would meet with this patch. As the previous
> author is gone, I can't confirm this problem with him.
> 
> Also the weston only use the only two achors with a same
> size and pixel format, I need more users to verify this
> patch.
> 
> changelog:
> v2: the previous version is mixed with the code for the other
> patches, I forget to remove it.
> v3: fix the error for the rk3399 vop little.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

just as a note for people not following irc discussions [and also for
my bad memory :-) ], it got reported that while this seems to work
nice on wayland, X11 seems to have an issue with it, to quote from
the public log:

"hmm.. but something funky is going on. with your patch the curser doesn't
seem to be updated if i move it close to the left or right edges of the
screen if the slower i move the curser towards an edge the closer to the
edge it will draw the cursor removing your patch again fixes the problem
this is in plain old Xorg version 1.20.3"


>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 20 ++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++++++++++---
>  2 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fb70fb486fbf..1a3b72391ee8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -751,6 +751,26 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>  
>  	dsp_info = (drm_rect_height(dest) - 1) << 16;
>  	dsp_info |= (drm_rect_width(dest) - 1) & 0xffff;
> +	/* HWC layer only supports various of square icon */
> +	if (plane->type == DRM_PLANE_TYPE_CURSOR) {
> +		switch (actual_w) {
> +		case 32:
> +			dsp_info = 0;
> +			break;
> +		case 64:
> +			dsp_info = 0x1;
> +			break;
> +		case 94:
> +			dsp_info = 0x10;
> +			break;
> +		case 128:
> +			dsp_info = 0x11;
> +			break;
> +		/* Unsupported pixel resolution */
> +		default:
> +			return;
> +		}
> +	}
>  
>  	dsp_stx = dest->x1 + crtc->mode.htotal - crtc->mode.hsync_start;
>  	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 08fc40af52c8..694f43fdeb23 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -63,6 +63,15 @@ static const uint32_t formats_win_lite[] = {
>  	DRM_FORMAT_BGR565,
>  };
>  
> +static const uint32_t formats_win_hwc[] = {
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +};
> +
>  static const struct vop_scl_regs rk3036_win_scl = {
>  	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
>  	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
> @@ -456,6 +465,19 @@ static const struct vop_win_phy rk3288_win23_data = {
>  	.dst_alpha_ctl = VOP_REG(RK3288_WIN2_DST_ALPHA_CTRL, 0xff, 0),
>  };
>  
> +static const struct vop_win_phy rk3288_winhwc_data = {
> +	.data_formats = formats_win_hwc,
> +	.nformats = ARRAY_SIZE(formats_win_hwc),
> +	.enable = VOP_REG(RK3288_HWC_CTRL0, 0x1, 0),
> +	.format = VOP_REG(RK3288_HWC_CTRL0, 0x7, 1),
> +	.rb_swap = VOP_REG(RK3288_HWC_CTRL0, 0x1, 12),
> +	.dsp_info = VOP_REG(RK3288_HWC_CTRL0, 0x3, 5),
> +	.dsp_st = VOP_REG(RK3288_HWC_DSP_ST, 0x1fff1fff, 0),
> +	.yrgb_mst = VOP_REG(RK3288_HWC_MST, 0xffffffff, 0),
> +	.src_alpha_ctl = VOP_REG(RK3288_HWC_SRC_ALPHA_CTRL, 0xffff, 0),
> +	.dst_alpha_ctl = VOP_REG(RK3288_HWC_DST_ALPHA_CTRL, 0xffffffff, 0),
> +};
> +
>  static const struct vop_modeset rk3288_modeset = {
>  	.htotal_pw = VOP_REG(RK3288_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
>  	.hact_st_end = VOP_REG(RK3288_DSP_HACT_ST_END, 0x1fff1fff, 0),
> @@ -500,7 +522,10 @@ static const struct vop_win_data rk3288_vop_win_data[] = {
>  	{ .base = 0x00, .phy = &rk3288_win23_data,
>  	  .type = DRM_PLANE_TYPE_OVERLAY },
>  	{ .base = 0x50, .phy = &rk3288_win23_data,
> -	  .type = DRM_PLANE_TYPE_CURSOR },
> +	  .type = DRM_PLANE_TYPE_OVERLAY },
> +	{ .base = 0x00, .phy = &rk3288_winhwc_data,
> +	  .type = DRM_PLANE_TYPE_CURSOR,
> +	},
>  };
>  
>  static const int rk3288_vop_intrs[] = {
> @@ -573,7 +598,10 @@ static const struct vop_win_data rk3368_vop_win_data[] = {
>  	{ .base = 0x00, .phy = &rk3368_win23_data,
>  	  .type = DRM_PLANE_TYPE_OVERLAY },
>  	{ .base = 0x50, .phy = &rk3368_win23_data,
> -	  .type = DRM_PLANE_TYPE_CURSOR },
> +	  .type = DRM_PLANE_TYPE_OVERLAY },
> +	{ .base = 0x00, .phy = &rk3288_winhwc_data,
> +	  .type = DRM_PLANE_TYPE_CURSOR,
> +	},
>  };
>  
>  static const struct vop_output rk3368_output = {
> @@ -653,7 +681,10 @@ static const struct vop_win_data rk3399_vop_lit_win_data[] = {
>  	{ .base = 0x00, .phy = &rk3288_win01_data,
>  	  .type = DRM_PLANE_TYPE_PRIMARY },
>  	{ .base = 0x00, .phy = &rk3368_win23_data,
> -	  .type = DRM_PLANE_TYPE_CURSOR},
> +	  .type = DRM_PLANE_TYPE_OVERLAY},
> +	{ .base = 0x00, .phy = &rk3288_winhwc_data,
> +	  .type = DRM_PLANE_TYPE_CURSOR,
> +	},
>  };
>  
>  static const struct vop_data rk3399_vop_lit = {
> @@ -735,7 +766,10 @@ static const struct vop_win_data rk3328_vop_win_data[] = {
>  	{ .base = 0x1d0, .phy = &rk3288_win01_data,
>  	  .type = DRM_PLANE_TYPE_OVERLAY },
>  	{ .base = 0x2d0, .phy = &rk3288_win01_data,
> -	  .type = DRM_PLANE_TYPE_CURSOR },
> +	  .type = DRM_PLANE_TYPE_OVERLAY },
> +	{ .base = 0x3d0, .phy = &rk3288_winhwc_data,
> +	  .type = DRM_PLANE_TYPE_CURSOR,
> +	},
>  };
>  
>  static const struct vop_data rk3328_vop = {
> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
