From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Feb 2011 10:52:21 +0100
Subject: [PATCH 3/7] Add i.MX5 framebuffer driver
In-Reply-To: <AANLkTina46_CMvB_9cqc4=PvcPxaV_BQ_H_ghJZFFxg8@mail.gmail.com>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
	<1297865452-32181-4-git-send-email-s.hauer@pengutronix.de>
	<AANLkTina46_CMvB_9cqc4=PvcPxaV_BQ_H_ghJZFFxg8@mail.gmail.com>
Message-ID: <20110218095221.GK24426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Fri, Feb 18, 2011 at 05:22:09PM +0800, Jason Chen wrote:
> hi, Sasha,
> 
> > +       if (var->vmode & FB_VMODE_ODD_FLD_FIRST) /* PAL */
> > +               sig_cfg.odd_field_first = 1;
> > +       if (var->sync & FB_SYNC_EXT)
> > +               sig_cfg.ext_clk = 1;
> > +       if (var->sync & FB_SYNC_HOR_HIGH_ACT)
> > +               sig_cfg.Hsync_pol = 1;
> Please remove FB_SYNC_EXT support.

No problem, can do. But why? Is it nonfunctional in the hardware
or is it that the current code just misses more pieces to support
this?

> 
> +static void imx_ipu_fb_disable_overlay(struct fb_info *ovl)
> +{
> +       struct imx_ipu_fb_info *mxc_ovl = ovl->par;
> +
> +       if (!mxc_ovl->enabled)
> +               return;
> +
> +       ipu_dp_disable_fg(mxc_ovl->dp);
> +       ipu_wait_for_interrupt(451, 100);
> +       ipu_idmac_disable_channel(mxc_ovl->ipu_ch);
> +       ipu_dmfc_disable_channel(mxc_ovl->dmfc);
> +       mxc_ovl->enabled = 0;
> +}
> Had better has a definition of ipu irq 451.

Ok.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
