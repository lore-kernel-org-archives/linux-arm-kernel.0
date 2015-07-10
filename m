From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 10 Jul 2015 19:02:07 +0200
Subject: [PATCH v7 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <1436527063-44762-1-git-send-email-jianwei.wang@freescale.com>
References: <1436527063-44762-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <20150710170207.GF3736@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 07:17:40PM +0800, Jianwei Wang wrote:
> This patch add support for Two Dimensional Animation and Compositing
> Engine (2D-ACE) on the Freescale SoCs.
> 
> 2D-ACE is a Freescale display controller. 2D-ACE describes
> the functionality of the module extremely well its name is a value
> that cannot be used as a token in programming languages.
> Instead the valid token "DCU" is used to tag the register names and
> function names.
> 
> The Display Controller Unit (DCU) module is a system master that
> fetches graphics stored in internal or external memory and displays
> them on a TFT LCD panel. A wide range of panel sizes is supported
> and the timing of the interface signals is highly configurable.
> Graphics are read directly from memory and then blended in real-time,
> which allows for dynamic content creation with minimal CPU
> intervention.
> 
> The features:
> (1) Full RGB888 output to TFT LCD panel.
> (2) For the current LCD panel, WQVGA "480x272" is supported.
> (3) Blending of each pixel using up to 4 source layers
> dependent on size of panel.
> (4) Each graphic layer can be placed with one pixel resolution
> in either axis.
> (5) Each graphic layer support RGB565 and RGB888 direct colors
> without alpha
> channel and BGRA8888 BGRA4444 ARGB1555 direct colors with an
> alpha channel and
> YUV422 format.
> (6) Each graphic layer support alpha blending with 8-bit
> resolution.
> 
> This is a simplified version, only one primary plane, one
> framebuffer created for
> fbdev, one crtc, one connector for TFT LCD panel, an encoder.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <jianwei.wang@freescale.com>

Can't find any other use of deprecated functions or legacy code patterns
or anything else that we've recently started cleaning up, looks good. No
detailed review though (for one I lack hw docs).

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Might be good to get some cross-review from some other arm soc drm driver
team, then send a pull request to Dave for 4.3.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
