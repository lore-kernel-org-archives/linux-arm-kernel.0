From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 13:41:28 +0800
Subject: VF610 broken by pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <20151123150823.GA16184@lunn.ch>
References: <20151115024409.GB2194@lunn.ch> <20151123132838.GM13744@tiger>
 <20151123150823.GA16184@lunn.ch>
Message-ID: <20151124054128.GN13744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:08:23PM +0100, Andrew Lunn wrote:
> > Can you please try the following change to see if it fixes your problem?
> > 
> > Shawn
> > 
> > diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
> > index 37a037543d29..587d1ff6210e 100644
> > --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
> > +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
> > @@ -299,7 +299,7 @@ static const struct pinctrl_pin_desc vf610_pinctrl_pads[] = {
> >  static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
> >         .pins = vf610_pinctrl_pads,
> >         .npins = ARRAY_SIZE(vf610_pinctrl_pads),
> > -       .flags = SHARE_MUX_CONF_REG,
> > +       .flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
> >  };
> >  
> >  static const struct of_device_id vf610_pinctrl_of_match[] = {
> 
> Hi Shawn
> 
> I'm away from the hardware right now, but yes, that should fix it.

I would wait for your testing confirmation to send the formal patch.

Shawn
