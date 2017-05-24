From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 24 May 2017 20:05:50 +0800
Subject: [nomadik:gemini-dir-685-tvc 24/24]
 drivers/gpu//drm/tve200/tve200_display.c:34:32: error: 'CLCD_TVE200_MIS'
 undeclared
Message-ID: <201705242043.p1PtJNoo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-tvc
head:   b09e3156ca92c226eda407c70377a5dae458d889
commit: b09e3156ca92c226eda407c70377a5dae458d889 [24/24] stab
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b09e3156ca92c226eda407c70377a5dae458d889
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/smp.h:20:0,
                    from include/linux/smp.h:59,
                    from include/linux/topology.h:33,
                    from include/linux/gfp.h:8,
                    from include/linux/mm.h:9,
                    from include/linux/scatterlist.h:7,
                    from include/linux/dma-buf.h:29,
                    from drivers/gpu//drm/tve200/tve200_display.c:18:
   drivers/gpu//drm/tve200/tve200_display.c: In function 'tve200_irq':
>> drivers/gpu//drm/tve200/tve200_display.c:34:32: error: 'CLCD_TVE200_MIS' undeclared (first use in this function)
     irq_stat = readl(priv->regs + CLCD_TVE200_MIS);
                                   ^
   arch/ia64/include/asm/io.h:379:27: note: in definition of macro 'readl'
    #define readl(a) __readl((a))
                              ^
   drivers/gpu//drm/tve200/tve200_display.c:34:32: note: each undeclared identifier is reported only once for each function it appears in
     irq_stat = readl(priv->regs + CLCD_TVE200_MIS);
                                   ^
   arch/ia64/include/asm/io.h:379:27: note: in definition of macro 'readl'
    #define readl(a) __readl((a))
                              ^
>> drivers/gpu//drm/tve200/tve200_display.c:39:17: error: 'CLCD_IRQ_NEXTBASE_UPDATE' undeclared (first use in this function)
     if (irq_stat & CLCD_IRQ_NEXTBASE_UPDATE) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/ia64/include/asm/smp.h:20:0,
                    from include/linux/smp.h:59,
                    from include/linux/topology.h:33,
                    from include/linux/gfp.h:8,
                    from include/linux/mm.h:9,
                    from include/linux/scatterlist.h:7,
                    from include/linux/dma-buf.h:29,
                    from drivers/gpu//drm/tve200/tve200_display.c:18:
>> drivers/gpu//drm/tve200/tve200_display.c:46:32: error: 'CLCD_TVE200_ICR' undeclared (first use in this function)
     writel(irq_stat, priv->regs + CLCD_TVE200_ICR);
                                   ^
   arch/ia64/include/asm/io.h:395:36: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                       ^
   drivers/gpu//drm/tve200/tve200_display.c: In function 'tve200_display_enable':
>> drivers/gpu//drm/tve200/tve200_display.c:137:22: error: 'CLCD_TIM0' undeclared (first use in this function)
            priv->regs + CLCD_TIM0);
                         ^
   arch/ia64/include/asm/io.h:395:36: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                       ^
>> drivers/gpu//drm/tve200/tve200_display.c:142:22: error: 'CLCD_TIM1' undeclared (first use in this function)
            priv->regs + CLCD_TIM1);
                         ^
   arch/ia64/include/asm/io.h:395:36: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                       ^
>> drivers/gpu//drm/tve200/tve200_display.c:148:49: error: 'TIM2_IHS' undeclared (first use in this function)
     writel(((mode->flags & DRM_MODE_FLAG_NHSYNC) ? TIM2_IHS : 0) |
                                                    ^
   arch/ia64/include/asm/io.h:395:31: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                  ^
>> drivers/gpu//drm/tve200/tve200_display.c:149:49: error: 'TIM2_IVS' undeclared (first use in this function)
            ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? TIM2_IVS : 0) |
                                                    ^
   arch/ia64/include/asm/io.h:395:31: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                  ^
>> drivers/gpu//drm/tve200/tve200_display.c:151:27: error: 'TIM2_IOE' undeclared (first use in this function)
       DRM_BUS_FLAG_DE_LOW) ? TIM2_IOE : 0) |
                              ^
   arch/ia64/include/asm/io.h:395:31: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                  ^
>> drivers/gpu//drm/tve200/tve200_display.c:153:36: error: 'TIM2_IPC' undeclared (first use in this function)
       DRM_BUS_FLAG_PIXDATA_NEGEDGE) ? TIM2_IPC : 0) |
                                       ^
   arch/ia64/include/asm/io.h:395:31: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                  ^
>> drivers/gpu//drm/tve200/tve200_display.c:154:9: error: 'TIM2_BCD' undeclared (first use in this function)
            TIM2_BCD |
            ^
   arch/ia64/include/asm/io.h:395:31: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                  ^
>> drivers/gpu//drm/tve200/tve200_display.c:156:22: error: 'CLCD_TIM2' undeclared (first use in this function)
            priv->regs + CLCD_TIM2);
                         ^
   arch/ia64/include/asm/io.h:395:36: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                       ^
>> drivers/gpu//drm/tve200/tve200_display.c:157:25: error: 'CLCD_TIM3' undeclared (first use in this function)
     writel(0, priv->regs + CLCD_TIM3);
                            ^
   arch/ia64/include/asm/io.h:395:36: note: in definition of macro 'writel'
    #define writel(v,a) __writel((v), (a))
                                       ^
>> drivers/gpu//drm/tve200/tve200_display.c:162:9: error: 'CNTL_LCDEN' undeclared (first use in this function)
     cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
            ^~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:162:22: error: 'CNTL_LCDTFT' undeclared (first use in this function)
     cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
                         ^~~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:162:36: error: 'CNTL_LCDPWR' undeclared (first use in this function)
     cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
                                       ^~~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:162:50: error: implicit declaration of function 'CNTL_LCDVCOMP' [-Werror=implicit-function-declaration]
     cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
                                                     ^~~~~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:171:11: error: 'CNTL_LCDBPP24' undeclared (first use in this function)
      cntl |= CNTL_LCDBPP24;
              ^~~~~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:175:27: error: 'CNTL_BGR' undeclared (first use in this function)
      cntl |= CNTL_LCDBPP24 | CNTL_BGR;
                              ^~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:178:11: error: 'CNTL_LCDBPP16_565' undeclared (first use in this function)
      cntl |= CNTL_LCDBPP16_565;
              ^~~~~~~~~~~~~~~~~
>> drivers/gpu//drm/tve200/tve200_display.c:185:11: error: 'CNTL_LCDBPP16' undeclared (first use in this function)
      cntl |= CNTL_LCDBPP16;
              ^~~~~~~~~~~~~

vim +/CLCD_TVE200_MIS +34 drivers/gpu//drm/tve200/tve200_display.c

    12	 * GNU General Public License version 2 as published by the Free Software
    13	 * Foundation, and any use by you of this program is subject to the terms of
    14	 * such GNU licence.
    15	 */
    16	#include <linux/clk.h>
    17	#include <linux/version.h>
  > 18	#include <linux/dma-buf.h>
    19	#include <linux/of_graph.h>
    20	
    21	#include <drm/drmP.h>
    22	#include <drm/drm_panel.h>
    23	#include <drm/drm_gem_cma_helper.h>
    24	#include <drm/drm_fb_cma_helper.h>
    25	
    26	#include "tve200_drm.h"
    27	
    28	irqreturn_t tve200_irq(int irq, void *data)
    29	{
    30		struct tve200_drm_dev_private *priv = data;
    31		u32 irq_stat;
    32		irqreturn_t status = IRQ_NONE;
    33	
  > 34		irq_stat = readl(priv->regs + CLCD_TVE200_MIS);
    35	
    36		if (!irq_stat)
    37			return IRQ_NONE;
    38	
  > 39		if (irq_stat & CLCD_IRQ_NEXTBASE_UPDATE) {
    40			drm_crtc_handle_vblank(&priv->pipe.crtc);
    41	
    42			status = IRQ_HANDLED;
    43		}
    44	
    45		/* Clear the interrupt once done */
  > 46		writel(irq_stat, priv->regs + CLCD_TVE200_ICR);
    47	
    48		return status;
    49	}
    50	
    51	static u32 tve200_get_fb_offset(struct drm_plane_state *pstate)
    52	{
    53		struct drm_framebuffer *fb = pstate->fb;
    54		struct drm_gem_cma_object *obj = drm_fb_cma_get_gem_obj(fb, 0);
    55	
    56		return (obj->paddr +
    57			fb->offsets[0] +
    58			fb->format->cpp[0] * pstate->src_x +
    59			fb->pitches[0] * pstate->src_y);
    60	}
    61	
    62	static int tve200_display_check(struct drm_simple_display_pipe *pipe,
    63				       struct drm_plane_state *pstate,
    64				       struct drm_crtc_state *cstate)
    65	{
    66		const struct drm_display_mode *mode = &cstate->mode;
    67		struct drm_framebuffer *old_fb = pipe->plane.state->fb;
    68		struct drm_framebuffer *fb = pstate->fb;
    69	
    70		if (mode->hdisplay % 16)
    71			return -EINVAL;
    72	
    73		if (fb) {
    74			u32 offset = tve200_get_fb_offset(pstate);
    75	
    76			/* FB base address must be dword aligned. */
    77			if (offset & 3)
    78				return -EINVAL;
    79	
    80			/* There's no pitch register -- the mode's hdisplay
    81			 * controls it.
    82			 */
    83			if (fb->pitches[0] != mode->hdisplay * fb->format->cpp[0])
    84				return -EINVAL;
    85	
    86			/* We can't change the FB format in a flicker-free
    87			 * manner (and only update it during CRTC enable).
    88			 */
    89			if (old_fb && old_fb->format != fb->format)
    90				cstate->mode_changed = true;
    91		}
    92	
    93		return 0;
    94	}
    95	
    96	static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
    97					 struct drm_crtc_state *cstate)
    98	{
    99		struct drm_crtc *crtc = &pipe->crtc;
   100		struct drm_plane *plane = &pipe->plane;
   101		struct drm_device *drm = crtc->dev;
   102		struct tve200_drm_dev_private *priv = drm->dev_private;
   103		const struct drm_display_mode *mode = &cstate->mode;
   104		struct drm_framebuffer *fb = plane->state->fb;
   105		struct drm_connector *connector = &priv->connector.connector;
   106		u32 cntl;
   107		u32 ppl, hsw, hfp, hbp;
   108		u32 lpp, vsw, vfp, vbp;
   109		u32 cpl;
   110		int ret;
   111	
   112		ret = clk_set_rate(priv->clk, mode->clock * 1000);
   113		if (ret) {
   114			dev_err(drm->dev,
   115				"Failed to set pixel clock rate to %d: %d\n",
   116				mode->clock * 1000, ret);
   117		}
   118	
   119		clk_prepare_enable(priv->clk);
   120	
   121		ppl = (mode->hdisplay / 16) - 1;
   122		hsw = mode->hsync_end - mode->hsync_start - 1;
   123		hfp = mode->hsync_start - mode->hdisplay - 1;
   124		hbp = mode->htotal - mode->hsync_end - 1;
   125	
   126		lpp = mode->vdisplay - 1;
   127		vsw = mode->vsync_end - mode->vsync_start - 1;
   128		vfp = mode->vsync_start - mode->vdisplay;
   129		vbp = mode->vtotal - mode->vsync_end;
   130	
   131		cpl = mode->hdisplay - 1;
   132	
   133		writel((ppl << 2) |
   134		       (hsw << 8) |
   135		       (hfp << 16) |
   136		       (hbp << 24),
 > 137		       priv->regs + CLCD_TIM0);
   138		writel(lpp |
   139		       (vsw << 10) |
   140		       (vfp << 16) |
   141		       (vbp << 24),
 > 142		       priv->regs + CLCD_TIM1);
   143		/* XXX: We currently always use CLCDCLK with no divisor.  We
   144		 * could probably reduce power consumption by using HCLK
   145		 * (apb_pclk) with a divisor when it gets us near our target
   146		 * pixel clock.
   147		 */
 > 148		writel(((mode->flags & DRM_MODE_FLAG_NHSYNC) ? TIM2_IHS : 0) |
 > 149		       ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? TIM2_IVS : 0) |
   150		       ((connector->display_info.bus_flags &
 > 151			 DRM_BUS_FLAG_DE_LOW) ? TIM2_IOE : 0) |
   152		       ((connector->display_info.bus_flags &
 > 153			 DRM_BUS_FLAG_PIXDATA_NEGEDGE) ? TIM2_IPC : 0) |
 > 154		       TIM2_BCD |
   155		       (cpl << 16),
 > 156		       priv->regs + CLCD_TIM2);
 > 157		writel(0, priv->regs + CLCD_TIM3);
   158	
   159		drm_panel_prepare(priv->connector.panel);
   160	
   161		/* Enable and Power Up */
 > 162		cntl = CNTL_LCDEN | CNTL_LCDTFT | CNTL_LCDPWR | CNTL_LCDVCOMP(1);
   163	
   164		/* Note that the the hardware's format reader takes 'r' from
   165		 * the low bit, while DRM formats list channels from high bit
   166		 * to low bit as you read left to right.
   167		 */
   168		switch (fb->format->format) {
   169		case DRM_FORMAT_ABGR8888:
   170		case DRM_FORMAT_XBGR8888:
 > 171			cntl |= CNTL_LCDBPP24;
   172			break;
   173		case DRM_FORMAT_ARGB8888:
   174		case DRM_FORMAT_XRGB8888:
 > 175			cntl |= CNTL_LCDBPP24 | CNTL_BGR;
   176			break;
   177		case DRM_FORMAT_BGR565:
 > 178			cntl |= CNTL_LCDBPP16_565;
   179			break;
   180		case DRM_FORMAT_RGB565:
   181			cntl |= CNTL_LCDBPP16_565 | CNTL_BGR;
   182			break;
   183		case DRM_FORMAT_ABGR1555:
   184		case DRM_FORMAT_XBGR1555:
 > 185			cntl |= CNTL_LCDBPP16;
   186			break;
   187		case DRM_FORMAT_ARGB1555:
   188		case DRM_FORMAT_XRGB1555:
   189			cntl |= CNTL_LCDBPP16 | CNTL_BGR;
   190			break;
   191		case DRM_FORMAT_ABGR4444:
   192		case DRM_FORMAT_XBGR4444:
 > 193			cntl |= CNTL_LCDBPP16_444;
   194			break;
   195		case DRM_FORMAT_ARGB4444:
   196		case DRM_FORMAT_XRGB4444:
   197			cntl |= CNTL_LCDBPP16_444 | CNTL_BGR;
   198			break;
   199		default:
   200			WARN_ONCE(true, "Unknown FB format 0x%08x\n",
   201				  fb->format->format);
   202			break;
   203		}
   204	
 > 205		writel(cntl, priv->regs + CLCD_TVE200_CNTL);
   206	
   207		drm_panel_enable(priv->connector.panel);
   208	
   209		drm_crtc_vblank_on(crtc);
   210	}
   211	
   212	void tve200_display_disable(struct drm_simple_display_pipe *pipe)
   213	{
   214		struct drm_crtc *crtc = &pipe->crtc;
   215		struct drm_device *drm = crtc->dev;
   216		struct tve200_drm_dev_private *priv = drm->dev_private;
   217	
   218		drm_crtc_vblank_off(crtc);
   219	
   220		drm_panel_disable(priv->connector.panel);
   221	
   222		/* Disable and Power Down */
 > 223		writel(0, priv->regs + CLCD_TVE200_CNTL);
   224	
   225		drm_panel_unprepare(priv->connector.panel);
   226	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47740 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/2f6e78e3/attachment-0001.gz>
