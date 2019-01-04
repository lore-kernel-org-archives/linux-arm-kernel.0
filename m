Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B386C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:02:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BCD21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p5s1b419"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BCD21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1c09LmWaMLvq9kxD89N1jwyftJBxi7oHWvGHpy4lGj8=; b=p5s1b419UqCx0Y
	0wUDnfbBc+oaDDNYFfpT08NT9LgcNOrzc8iYjNe42fQyQJ2zo04MmVayZzJ34g9Emup4FBDuy0Yd6
	aq5NhWCr3T9lRtuWSLNpWxhgEfhQM1IuQB0R81MUQJsPmRRO9Mjlxlo/fp9f+IweOyLT+95qHYbrZ
	DSS9Dl33I0WDSMmNm9lRSphXl4ApckLtiNNmPXxhm5Vm3ni/6A3ja/tbxlpSgiSPZfDC+yINkzVP9
	QWfOnL5RSRWFeu9QMDjQgxKAP5R/t1OyGP1t2F6WxpjUdqv0+lHDYvCEaLoCuEQNsqTRw82iEmBu5
	dWkmfnylYhE4W4wkiphg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMIe-0001LI-0L; Fri, 04 Jan 2019 10:01:56 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMIZ-0001KN-E0; Fri, 04 Jan 2019 10:01:53 +0000
X-UUID: b0e4fdf96e8b4e159395641178bfcd12-20190104
X-UUID: b0e4fdf96e8b4e159395641178bfcd12-20190104
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1822763611; Fri, 04 Jan 2019 02:01:30 -0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Jan 2019 02:01:29 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 4 Jan 2019 18:01:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 18:01:15 +0800
Message-ID: <1546596075.27100.17.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
From: CK Hu <ck.hu@mediatek.com>
To: Frank Wunderlich <frank-w@public-files.de>
Date: Fri, 4 Jan 2019 18:01:15 +0800
In-Reply-To: <20190102122540.7002-2-frank-w@public-files.de>
References: <20190102122540.7002-1-frank-w@public-files.de>
 <20190102122540.7002-2-frank-w@public-files.de>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_020151_489581_93021BDC 
X-CRM114-Status: GOOD (  25.73  )
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
Cc: Alexander Ryabchenko <d3adme4t@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Frank:

On Wed, 2019-01-02 at 13:25 +0100, Frank Wunderlich wrote:
> From: CK Hu <ck.hu@mediatek.com>
> 
> This patch adds Framebuffer-Driver for Mediatek
> 
> currently tested on mt7623, maybe works on other platforms
> MTK-FBDev written by CK Hu and ported from 4.4
> 
> based on patchset drm/hdmi for 7623 v5 (except last part included in 4.20)
>   https://patchwork.kernel.org/project/linux-mediatek/list/?series=25989
> 
> depends on
>   dts-patch (resend of 5/5, parts 1-4 already in 4.20):
>     "arm: dts: mt7623: add display subsystem related device nodes"
>     https://patchwork.kernel.org/patch/10588951/
>   2 bugfix-patches from bibby hsieh
>     fix-boot-up-for-720-and-480-but-1080
>     using-different-round-rate-for-mt7623
>   1 Patch from Ryder Lee
>     http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/52
> 
> full working tree here for reference:
> https://github.com/frank-w/BPI-R2-4.14/commits/4.20-hdmiv5
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Alexander Ryabchenko <d3adme4t@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/Makefile        |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   |   6 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   4 +
>  drivers/gpu/drm/mediatek/mtk_drm_fb.c    |  13 ++
>  drivers/gpu/drm/mediatek/mtk_drm_fb.h    |   3 +
>  drivers/gpu/drm/mediatek/mtk_drm_fbdev.c | 178 +++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_fbdev.h |  25 ++++
>  7 files changed, 230 insertions(+)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 82ae49c64221..d71e57dea77a 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -14,6 +14,7 @@ mediatek-drm-y := mtk_disp_color.o \
>  		  mtk_mipi_tx.o \
>  		  mtk_dpi.o
>  
> +mediatek-drm-$(CONFIG_DRM_FBDEV_EMULATION) += mtk_drm_fbdev.o
>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
>  
>  mediatek-drm-hdmi-objs := mtk_cec.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 7800822b4db1..51f1ec3412d3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -32,6 +32,7 @@
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_drv.h"
>  #include "mtk_drm_fb.h"
> +#include "mtk_drm_fbdev.h"
>  #include "mtk_drm_gem.h"
>  
>  #define DRIVER_NAME "mediatek"
> @@ -299,6 +300,10 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	drm_kms_helper_poll_init(drm);
>  	drm_mode_config_reset(drm);
>  
> +	ret = mtk_fbdev_init(drm);
> +	if (ret)
> +		goto err_component_unbind;
> +
>  	return 0;
>  
>  err_component_unbind:
> @@ -311,6 +316,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  
>  static void mtk_drm_kms_deinit(struct drm_device *drm)
>  {
> +	mtk_fbdev_fini(drm);
>  	drm_kms_helper_poll_fini(drm);
>  
>  	component_unbind_all(drm->dev, drm);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 256a3ff2e66e..56129a21fb2b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -14,6 +14,7 @@
>  #ifndef MTK_DRM_DRV_H
>  #define MTK_DRM_DRV_H
>  
> +#include <drm/drm_fb_helper.h>
>  #include <linux/io.h>
>  #include "mtk_drm_ddp_comp.h"
>  
> @@ -43,6 +44,7 @@ struct mtk_drm_private {
>  	struct drm_device *drm;
>  	struct device *dma_dev;
>  
> +	struct drm_crtc *crtc[MAX_CRTC];

Useless, so remove it.

>  	unsigned int num_pipes;
>  
>  	struct device_node *mutex_node;
> @@ -59,6 +61,8 @@ struct mtk_drm_private {
>  	} commit;
>  
>  	struct drm_atomic_state *suspend_state;
> +	struct drm_fb_helper fb_helper;
> +	struct drm_gem_object *fbdev_bo;
>  };
>  
>  extern struct platform_driver mtk_ddp_driver;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> index be5f6f1daf55..7533aa4733d2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> @@ -56,6 +56,19 @@ static struct drm_framebuffer *mtk_drm_framebuffer_init(struct drm_device *dev,
>  	return fb;
>  }
>  
> +struct drm_framebuffer *mtk_drm_framebuffer_create(struct drm_device *dev,
> +					const struct drm_mode_fb_cmd2 *mode,
> +					struct drm_gem_object *obj)
> +{
> +	struct drm_framebuffer *mtk_fb;
> +
> +	mtk_fb = mtk_drm_framebuffer_init(dev, mode, obj);
> +	if (IS_ERR(mtk_fb))
> +		return ERR_CAST(mtk_fb);
> +
> +	return mtk_fb;
> +}

mtk_drm_framebuffer_create() is exactly the same as
mtk_drm_framebuffer_init(), so remove this function and use
mtk_drm_framebuffer_init() directly.

> +
>  /*
>   * Wait for any exclusive fence in fb's gem object's reservation object.
>   *
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.h b/drivers/gpu/drm/mediatek/mtk_drm_fb.h
> index 7f976b196a15..e49e015380d0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_fb.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.h
> @@ -18,5 +18,8 @@ int mtk_fb_wait(struct drm_framebuffer *fb);
>  struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
>  					       struct drm_file *file,
>  					       const struct drm_mode_fb_cmd2 *cmd);
> +struct drm_framebuffer *mtk_drm_framebuffer_create(struct drm_device *dev,
> +		const struct drm_mode_fb_cmd2 *mode,
> +		struct drm_gem_object *obj);
>  
>  #endif /* MTK_DRM_FB_H */
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
> new file mode 100644
> index 000000000000..9670f50d1247
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: CK Hu <ck.hu@mediatek.com>
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_gem.h>
> +
> +#include "mtk_drm_drv.h"
> +#include "mtk_drm_fb.h"
> +#include "mtk_drm_gem.h"
> +#include "mtk_drm_fbdev.h"

Alphabetic order.

> +
> +#define to_drm_private(x) \
> +		container_of(x, struct mtk_drm_private, fb_helper)
> +
> +static int mtk_drm_fbdev_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	struct drm_fb_helper *helper = info->par;
> +	struct mtk_drm_private *private = to_drm_private(helper);
> +
> +	return mtk_drm_gem_mmap_buf(private->fbdev_bo, vma);
> +}
> +
> +static struct fb_ops mtk_fbdev_ops = {
> +	.owner = THIS_MODULE,
> +	DRM_FB_HELPER_DEFAULT_OPS,
> +	.fb_fillrect = drm_fb_helper_cfb_fillrect,
> +	.fb_copyarea = drm_fb_helper_cfb_copyarea,
> +	.fb_imageblit = drm_fb_helper_cfb_imageblit,
> +	.fb_check_var = drm_fb_helper_check_var,
> +	.fb_set_par = drm_fb_helper_set_par,
> +	.fb_blank = drm_fb_helper_blank,
> +	.fb_pan_display = drm_fb_helper_pan_display,
> +	.fb_setcmap = drm_fb_helper_setcmap,
> +	.fb_mmap = mtk_drm_fbdev_mmap,
> +};

DRM_FB_HELPER_DEFAULT_OPS is defined as follow, so you should remove the
same definition part.

#define DRM_FB_HELPER_DEFAULT_OPS \
	.fb_check_var	= drm_fb_helper_check_var, \
	.fb_set_par	= drm_fb_helper_set_par, \
	.fb_setcmap	= drm_fb_helper_setcmap, \
	.fb_blank	= drm_fb_helper_blank, \
	.fb_pan_display	= drm_fb_helper_pan_display, \
	.fb_debug_enter = drm_fb_helper_debug_enter, \
	.fb_debug_leave = drm_fb_helper_debug_leave, \
	.fb_ioctl	= drm_fb_helper_ioctl

> +
> +static int mtk_fbdev_probe(struct drm_fb_helper *helper,
> +			   struct drm_fb_helper_surface_size *sizes)
> +{
> +	struct drm_device *dev = helper->dev;
> +	struct mtk_drm_private *private = to_drm_private(helper);
> +	struct drm_mode_fb_cmd2 mode = { 0 };
> +	struct mtk_drm_gem_obj *mtk_gem;
> +	struct fb_info *info;
> +	struct drm_framebuffer *fb;
> +	unsigned int bytes_per_pixel;
> +	unsigned long offset;
> +	size_t size;
> +	int err = 0;

Need not initialize to zero.

> +
> +	bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
> +
> +	mode.width = sizes->surface_width;
> +	mode.height = sizes->surface_height;
> +	mode.pitches[0] = sizes->surface_width * bytes_per_pixel;
> +	mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
> +						      sizes->surface_depth);
> +
> +	size = mode.pitches[0] * mode.height;
> +
> +	mtk_gem = mtk_drm_gem_create(dev, size, true);
> +	if (IS_ERR(mtk_gem))
> +		return PTR_ERR(mtk_gem);
> +
> +	private->fbdev_bo = &mtk_gem->base;
> +
> +	info = drm_fb_helper_alloc_fbi(helper);
> +	if (IS_ERR(info)) {
> +		DRM_DEV_ERROR(dev->dev,
> +			"failed to allocate framebuffer info, %d\n",

Align to the right of '('.

> +			err);

Why print err before assign it?

> +		err = PTR_ERR(info);
> +		goto out;
> +	}
> +
> +	fb = mtk_drm_framebuffer_create(dev, &mode, private->fbdev_bo);
> +	if (IS_ERR(fb)) {
> +		DRM_DEV_ERROR(dev->dev,
> +			"failed to allocate DRM framebuffer, %d\n",

Align to the right of '('.

> +			err);

Why print err before assign it?

> +		err = PTR_ERR(fb);
> +		goto out;

I think here should goto somewhere to undo drm_fb_helper_alloc_fbi().

> +	}
> +	helper->fb = fb;
> +
> +	info->par = helper;
> +	info->flags = FBINFO_FLAG_DEFAULT;
> +	info->fbops = &mtk_fbdev_ops;
> +
> +	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
> +	drm_fb_helper_fill_var(info, helper, sizes->fb_width, sizes->fb_height);
> +
> +	offset = info->var.xoffset * bytes_per_pixel;
> +	offset += info->var.yoffset * fb->pitches[0];
> +
> +	dev->mode_config.fb_base = 0;
> +	info->screen_base = mtk_gem->kvaddr + offset;
> +	info->screen_size = size;
> +	info->fix.smem_len = size;
> +
> +	DRM_DEBUG_KMS("FB [%ux%u]-%u offset=%lu size=%zd\n",
> +		      fb->width, fb->height, fb->format->depth, offset, size);
> +
> +	info->skip_vt_switch = true;
> +
> +	return 0;
> +
> +out:

I would like the label naming as 'err_gem_free_object'

> +
> +
> +	mtk_drm_gem_free_object(&mtk_gem->base);
> +	return err;
> +}
> +
> +static const struct drm_fb_helper_funcs mtk_drm_fb_helper_funcs = {
> +	.fb_probe = mtk_fbdev_probe,
> +};
> +
> +int mtk_fbdev_init(struct drm_device *dev)
> +{
> +	struct mtk_drm_private *priv = dev->dev_private;
> +	struct drm_fb_helper *helper = &priv->fb_helper;
> +	int ret;
> +
> +	if (!dev->mode_config.num_crtc || !dev->mode_config.num_connector)
> +		return -EINVAL;
> +
> +	drm_fb_helper_prepare(dev, helper, &mtk_drm_fb_helper_funcs);
> +
> +	ret = drm_fb_helper_init(dev, helper, dev->mode_config.num_connector);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev->dev,
> +			"failed to initialize DRM FB helper, %d\n",
> +			ret);
> +//		goto fini;

Remove useless line.

> +		return ret;
> +	}
> +
> +	ret = drm_fb_helper_single_add_all_connectors(helper);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev->dev, "failed to add connectors, %d\n", ret);
> +		goto fini;
> +	}
> +
> +	ret = drm_fb_helper_initial_config(helper, 32);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev->dev,
> +			"failed to set initial configuration, %d\n",

Align to the right of '('.

> +			ret);
> +		goto fini;
> +	}
> +
> +	return 0;
> +
> +fini:

I would like the label naming as err_fini.

Regards,
CK

> +	drm_fb_helper_fini(helper);
> +	return ret;
> +}
> +
> +void mtk_fbdev_fini(struct drm_device *dev)
> +{
> +	struct mtk_drm_private *priv = dev->dev_private;
> +	struct drm_fb_helper *helper = &priv->fb_helper;
> +
> +	drm_fb_helper_unregister_fbi(helper);
> +
> +	if (helper->fb) {
> +		drm_framebuffer_unregister_private(helper->fb);
> +		drm_framebuffer_remove(helper->fb);
> +	}
> +
> +	drm_fb_helper_fini(helper);
> +}
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
> new file mode 100644
> index 000000000000..45717b642dc5
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: CK Hu <ck.hu@mediatek.com>
> + */
> +
> +#ifndef MTK_DRM_FBDEV_H
> +#define MTK_DRM_FBDEV_H
> +
> +#ifdef CONFIG_DRM_FBDEV_EMULATION
> +int mtk_fbdev_init(struct drm_device *dev);
> +void mtk_fbdev_fini(struct drm_device *dev);
> +#else
> +int mtk_fbdev_init(struct drm_device *dev)
> +{
> +	return 0;
> +}
> +
> +void mtk_fbdev_fini(struct drm_device *dev)
> +{
> +
> +}
> +#endif /* CONFIG_DRM_FBDEV_EMULATION */
> +
> +#endif /* MTK_DRM_FBDEV_H */



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
