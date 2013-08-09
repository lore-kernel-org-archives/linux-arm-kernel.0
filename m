From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 9 Aug 2013 15:31:15 +0200
Subject: [PATCH 2/7] pinctrl: imx header, conditional probe functions
In-Reply-To: <20130805054312.GC24629@S2101-09.ap.freescale.net>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-3-git-send-email-mpa@pengutronix.de>
 <20130805054312.GC24629@S2101-09.ap.freescale.net>
Message-ID: <20130809133115.GE13664@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 01:43:15PM +0800, Shawn Guo wrote:
> On Fri, Aug 02, 2013 at 12:38:22PM +0200, Markus Pargmann wrote:
> > The functions are not available if included by imx1 core driver.
> > 
> 
> Does imx1 core driver include the header?

I removed the include to simplify some structs.

Thanks

Markus

> 
> Shawn
> 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/pinctrl/pinctrl-imx.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
> > index bcedd99..446fc01 100644
> > --- a/drivers/pinctrl/pinctrl-imx.h
> > +++ b/drivers/pinctrl/pinctrl-imx.h
> > @@ -89,7 +89,11 @@ struct imx_pinctrl_soc_info {
> >  #define IMX_MUX_MASK	0x7
> >  #define IOMUXC_CONFIG_SION	(0x1 << 4)
> >  
> > +#if IS_ENABLED(PINCTRL_IMX)
> > +
> >  int imx_pinctrl_probe(struct platform_device *pdev,
> >  			struct imx_pinctrl_soc_info *info);
> >  int imx_pinctrl_remove(struct platform_device *pdev);
> > +
> > +#endif
> >  #endif /* __DRIVERS_PINCTRL_IMX_H */
> > -- 
> > 1.8.3.2
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
