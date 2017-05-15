From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 May 2017 19:56:44 +0800
Subject: [PATCH 1/5] pinctrl: imx: add generic pin config core support
In-Reply-To: <AM3PR04MB3069DA0AEF0F56AB2F7808080E10@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-2-git-send-email-aisheng.dong@nxp.com>
 <20170515083500.GL8471@dragon>
 <AM3PR04MB3067B92ED9E3D62153536F880E10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170515105615.GN8471@dragon>
 <AM3PR04MB3069DA0AEF0F56AB2F7808080E10@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170515115643.GQ8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 11:16:57AM +0000, A.S. Dong wrote:
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > Sent: Monday, May 15, 2017 6:56 PM
> > To: A.S. Dong
> > Cc: Andy Duan; Jacky Bai; linus.walleij at linaro.org; stefan at agner.ch;
> > linux-gpio at vger.kernel.org; kernel at pengutronix.de; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH 1/5] pinctrl: imx: add generic pin config core support
> > 
> > On Mon, May 15, 2017 at 08:56:18AM +0000, A.S. Dong wrote:
> > > > > @@ -489,17 +547,29 @@ static int imx_pinctrl_parse_groups(struct
> > > > device_node *np,
> > > > >  		pin_size = SHARE_FSL_PIN_SIZE;
> > > > >  	else
> > > > >  		pin_size = FSL_PIN_SIZE;
> > > > > +
> > > > > +	if (info->generic_pinconf)
> > > > > +		pin_size -= 4;
> > > > > +
> > > > >  	/* Initialise group */
> > > > >  	grp->name = np->name;
> > > > >
> > > > >  	/*
> > > > > -	 * the binding format is fsl,pins = <PIN_FUNC_ID CONFIG ...>,
> > > > > +	 * the binding format is pins = <PIN_FUNC_ID CONFIG ...>,
> > > >
> > > > This is not correct for generic pinconf bindings.  CONIFIG shouldn't
> > > > be there.
> > > >
> > >
> > > Yes, that's for legacy stuff.
> > 
> > If that's for legacy bindings, you shouldn't change 'fsl,pins' to 'pins',
> > right?
> > 
> 
> I mean the binding format.
> For the legacy format, either the name of 'fsl,pins' or 'pins' is ok.
> 
> But in order to increase the standard 'pins' priority, I change
> 'fsl,pins' to 'pins' to make it more explicitly.
> 
> I do can leave "fsl,pins' not changed, but I think the new one
> may be better, right?

Please leave "fsl,pins' unchanged, and let's use 'fsl,pins' for legacy
bindings and 'pins' for new one.

Shawn
