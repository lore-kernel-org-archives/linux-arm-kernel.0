Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB09FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C852063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t3ZQSvtN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JmClL8V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C852063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AAYk+64qiJ7+qiV8qX0LWS7P+XH3BBeUjl7fa9g9kmA=; b=t3ZQSvtNqJ5olm
	Tu0xHK6C2Jnbz6NRn4RS//eO7/KIENJNjTrVoDr6rUvmctctdCzkU2qQggMQ70q4ls8GWcIJ2vtI/
	J5OOOt4wST803hianJ91jqx6oQDQNFkNyhwxorfH3in81+8VUprz5wqc22BCuVxOj8n1soVMdNVvf
	YrTLrsCjOA8ukBK5UH8upRDTMbXP2+aJVQq/8IXSEhAIxHLABQaYb68JKhJ3zX6DFvLCrDWLYKnxm
	FoJy2cqPdS/iiaLLn/BQPEE01B2DN5afcr1cnmQ8FyJVnF68tmr7AA8INe4FUdi0VRzlYSaF1Pjct
	tqSzIjeeSi4+TPdCgYLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPih-0007Aq-2Y; Tue, 15 Jan 2019 14:29:35 +0000
Received: from perceval.ideasonboard.com ([213.167.242.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPib-00079J-PV; Tue, 15 Jan 2019 14:29:32 +0000
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 104374F8;
 Tue, 15 Jan 2019 15:29:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1547562554;
 bh=6Lt8GE7mqRAOiWSVFaVewmz6sdGOGz5y3RFGYDTXlrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JmClL8V1yzOm1NiPOiRt3AbPAmmwS/zsVSQUlk77juViLMw3UAtIXX7MXO00MAwm8
 vLeQVyWLKOo8hlJkFmP+xwzjmOk8y1TswwpAQ0SKPj2x5w7T+klz75gA62UJ+RSUmv
 LidnlD3AcVFwKpjHIs/6TJc/qh3P3wqlowbun6aQ=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Tue, 15 Jan 2019 16:30:29 +0200
Message-ID: <5798967.qfukvHqhlx@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20190115104137.25695-1-daniel.vetter@ffwll.ch>
References: <20190115104137.25695-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_062930_281835_53378566 
X-CRM114-Status: GOOD (  28.39  )
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
Cc: nouveau@lists.freedesktop.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 spice-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xen.org,
 linux-renesas-soc@vger.kernel.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

Thank you for the patch.

On Tuesday, 15 January 2019 12:41:37 EET Daniel Vetter wrote:
> Having the probe helper stuff (which pretty much everyone needs) in
> the drm_crtc_helper.h file (which atomic drivers should never need) is
> confusing. Split them out.
> =

> To make sure I actually achieved the goal here I went through all
> drivers. And indeed, all atomic drivers are now free of
> drm_crtc_helper.h includes.
> =

> v2: Make it compile. There was so much compile fail on arm drivers
> that I figured I'll better not include any of the acks on v1.
> =

> v3: Massive rebase because i915 has lost a lot of drmP.h includes, but
> not all: Through drm_crtc_helper.h > drm_modeset_helper.h -> drmP.h
> there was still one, which this patch largely removes. Which means
> rolling out lots more includes all over.
> =

> This will also conflict with ongoing drmP.h cleanup by others I
> expect.
> =

> v3: Rebase on top of atomic bochs.
> =

> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> (v2)
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org> (v2)
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: spice-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-tegra@vger.kernel.org
> Cc: xen-devel@lists.xen.org
> ---
> Merging this is going to be a bit a mess due to all the ongoing drmP.h
> cleanups. I think the following should work:
> - Apply Sam's prep patches for removing drmP.h from
>   drm_modeset_helper.h
> - Get the i915 drmP.h cleanup backmerged into drm-misc-next
> - Apply this patch.
> - Apply Sam's patch to remove drmP.h from drm_modeset_helper.h
> - All through drm-misc-next, which has some potential for trivial
>   conflicts around #includes with other drivers unfortunately.
> =

> I hope there's no other driver who'll blow up accidentally because
> someone else is doing a drmP.h cleanup. Laurent maybe?

There's a drmP.h cleanup in the R-Car DU driver, but it doesn't conflict wi=
th =

this patch, the combination of both compiles fine.

> Jani, ack on this?
> -Daniel
> ---

[snip]

>  drivers/gpu/drm/bridge/adv7511/adv7511.h      |  5 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.c     |  2 +-
>  drivers/gpu/drm/bridge/dumb-vga-dac.c         |  2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
>  drivers/gpu/drm/drm_atomic_helper.c           |  1 -
>  drivers/gpu/drm/drm_dp_mst_topology.c         |  2 +-
>  drivers/gpu/drm/drm_modeset_helper.c          |  2 +-
>  drivers/gpu/drm/drm_probe_helper.c            |  2 +-
>  drivers/gpu/drm/drm_simple_kms_helper.c       |  2 +-
>  drivers/gpu/drm/omapdrm/omap_connector.c      |  2 +-
>  drivers/gpu/drm/omapdrm/omap_crtc.c           |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.h            |  2 +-
>  drivers/gpu/drm/omapdrm/omap_encoder.c        |  2 +-
>  drivers/gpu/drm/omapdrm/omap_fb.c             |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_lvds.c           |  2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c     |  1 +
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c      |  1 +
>  drivers/gpu/drm/shmobile/shmob_drm_kms.c      |  1 +
>  include/drm/drm_crtc_helper.h                 | 16 ------
>  include/drm/drm_probe_helper.h                | 50 +++++++++++++++++++

For the above files, with the comments below addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  227 files changed, 289 insertions(+), 200 deletions(-)
>  create mode 100644 include/drm/drm_probe_helper.h

[snip]

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> b/drivers/gpu/drm/bridge/adv7511/adv7511.h index 73d8ccb97742..d52ffab41e=
b4
> 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -14,8 +14,11 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> =

> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>

The probe helpers are needed in adv7511_drv.c only, I would move the includ=
e =

there.

>  #include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_bridge.h>

Please keep the headers alphabetically sorted, here and in all other driver=
s.

>  #define ADV7511_REG_CHIP_REVISION		0x00
>  #define ADV7511_REG_N0				0x01

[snip]

> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c
> b/drivers/gpu/drm/omapdrm/omap_crtc.c index 40acf4ce7c9f..9beb0edd5ffa
> 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -18,7 +18,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>

This file doesn't use the probe helpers, you can drop this.

>  #include <drm/drm_mode.h>
>  #include <drm/drm_plane_helper.h>
>  #include <linux/math64.h>

[snip]

> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h
> b/drivers/gpu/drm/omapdrm/omap_drv.h index bd7f2c227a25..513ae8ab5e64
> 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -23,7 +23,7 @@
>  #include <linux/workqueue.h>
> =

>  #include <drm/drmP.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>

This isn't needed globally in the driver either.

>  #include <drm/drm_gem.h>
>  #include <drm/omap_drm.h>
> =

> diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c
> b/drivers/gpu/drm/omapdrm/omap_encoder.c index 148b6b20274f..cd2328fa4ba6
> 100644
> --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
> +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
> @@ -18,7 +18,7 @@
>  #include <linux/list.h>
> =

>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_atomic_helper.h>

As far as I can tell this is only used to include =

drm_modeset_helper_vtables.h. Should we include that file instead ?

>  #include <drm/drm_edid.h>
> =

>  #include "omap_drv.h"

[snip]

> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 90dacab67be5..b15d2b3a07f1
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -15,7 +15,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>

Not needed either.

>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_plane_helper.h>

[snip]

> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c index
> 1877764bd6d9..0b440f554aed 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> @@ -11,7 +11,7 @@
> =

>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_atomic_helper.h>

As far as I can tell this is only used to include =

drm_modeset_helper_vtables.h. Should we include that file instead ?

>  #include <drm/drm_panel.h>
> =

>  #include "rcar_du_drv.h"

[snip]

> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> b/drivers/gpu/drm/rcar-du/rcar_du_plane.c index 39d5ae3fdf72..b7fa278ca745
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> @@ -11,7 +11,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>

Not needed.

>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_plane_helper.h>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c index 4576119e7777..35b2a4d3ae74
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -10,7 +10,7 @@
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>

Not needed.

>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>

[snip]

> diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_helpe=
r.h
> new file mode 100644
> index 000000000000..96c060c16a1e
> --- /dev/null
> +++ b/include/drm/drm_probe_helper.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright =A9 2006 Keith Packard
> + * Copyright =A9 2007-2008 Dave Airlie
> + * Copyright =A9 2007-2008 Intel Corporation
> + *   Jesse Barnes <jesse.barnes@intel.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"), + * to deal in the Software without restriction, including
> without limitation + * the rights to use, copy, modify, merge, publish,
> distribute, sublicense, + * and/or sell copies of the Software, and to
> permit persons to whom the + * Software is furnished to do so, subject to
> the following conditions: + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> in + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> OR + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
. =

> IN NO EVENT SHALL + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR
> ANY CLAIM, DAMAGES OR + * OTHER LIABILITY, WHETHER IN AN ACTION OF
> CONTRACT, TORT OR OTHERWISE, + * ARISING FROM, OUT OF OR IN CONNECTION WI=
TH
> THE SOFTWARE OR THE USE OR + * OTHER DEALINGS IN THE SOFTWARE.

Let's use an SPDX tag instead.

> + */
> +
> +#ifndef __DRM_PROBE_HELPER_H__
> +#define __DRM_PROBE_HELPER_H__
> +
> +#include <linux/types.h>
> +
> +struct drm_connector;
> +struct drm_device;
> +struct drm_modeset_acquire_ctx;
> +
> +int drm_helper_probe_single_connector_modes(struct drm_connector
> +					    *connector, uint32_t maxX,
> +					    uint32_t maxY);
> +int drm_helper_probe_detect(struct drm_connector *connector,
> +			    struct drm_modeset_acquire_ctx *ctx,
> +			    bool force);
> +void drm_kms_helper_poll_init(struct drm_device *dev);
> +void drm_kms_helper_poll_fini(struct drm_device *dev);
> +bool drm_helper_hpd_irq_event(struct drm_device *dev);
> +void drm_kms_helper_hotplug_event(struct drm_device *dev);
> +
> +void drm_kms_helper_poll_disable(struct drm_device *dev);
> +void drm_kms_helper_poll_enable(struct drm_device *dev);
> +bool drm_kms_helper_is_poll_worker(void);
> +
> +#endif

-- =

Regards,

Laurent Pinchart




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
