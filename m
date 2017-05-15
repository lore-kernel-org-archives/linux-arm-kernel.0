From: aisheng.dong@nxp.com (A.S. Dong)
Date: Mon, 15 May 2017 11:04:14 +0000
Subject: [PATCH 2/5] pinctrl: imx: add soc specific mux_mode mask and
 shift property
In-Reply-To: <20170515105906.GO8471@dragon>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-3-git-send-email-aisheng.dong@nxp.com>
 <20170515085236.GM8471@dragon>
 <AM3PR04MB306F70328E49CB7EE68E2C380E10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170515105906.GO8471@dragon>
Message-ID: <AM3PR04MB30602DD3FC2061DCB30FEA380E10@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, May 15, 2017 6:59 PM
> To: A.S. Dong
> Cc: Andy Duan; Jacky Bai; linus.walleij at linaro.org; stefan at agner.ch;
> linux-gpio at vger.kernel.org; kernel at pengutronix.de; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/5] pinctrl: imx: add soc specific mux_mode mask and
> shift property
> 
> On Mon, May 15, 2017 at 09:00:32AM +0000, A.S. Dong wrote:
> > > > @@ -432,7 +432,7 @@ static int imx_pinconf_get(struct pinctrl_dev
> > > *pctldev,
> > > >  	*config = readl(ipctl->base + pin_reg->conf_reg);
> > > >
> > > >  	if (info->flags & SHARE_MUX_CONF_REG)
> > > > -		*config &= 0xffff;
> > > > +		*config &= ~info->mux_mask;
> > >
> > > It changes the way how code works.  We need a note in the commit log
> > > explaining why it's safe.
> > >
> >
> > Well, that's Vybrid tricks that BIT[15-0] are all configs part.
> > So it hardcoded 0xffff there.
> >
> > But it's not true in ULP, so use mux_mask instead to address the
> > difference.
> 
> So you make the assumption that for all SHARE_MUX_CONF_REG SoCs, all bits
> in the register except mux ones are config bits.  You at least need to
> mention that in the commit log, IMO.

Yes, it's true, at least for all current known SoCs.
But your suggestion is good, I can add it in commit log.

Thanks

Regards
Dong Aisheng

> 
> Shawn
