From: aisheng.dong@nxp.com (A.S. Dong)
Date: Thu, 25 May 2017 05:04:58 +0000
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <20170525031620.GS26102@dragon>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
 <5e78ef100319f229a87e33804384e5b3@agner.ch>
 <DBXPR04MB320A55DE4386DE561A1D4DC80F90@DBXPR04MB320.eurprd04.prod.outlook.com>
 <20170525031620.GS26102@dragon>
Message-ID: <AM3PR04MB3068FA0B94C9B0D6269FC9C80FF0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, May 25, 2017 11:16 AM
> To: A.S. Dong
> Cc: Stefan Agner; Mark Rutland; devicetree at vger.kernel.org; Andy Duan;
> Jacky Bai; linus.walleij at linaro.org; linux-gpio at vger.kernel.org; Rob
> Herring; kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl
> binding doc
> 
> On Tue, May 23, 2017 at 10:37:27AM +0000, A.S. Dong wrote:
> > > > +#ifndef __DTS_IMX7ULP_PINFUNC_H
> > > > +#define __DTS_IMX7ULP_PINFUNC_H
> > > > +
> > > > +/*
> > > > + * The pin function ID is a tuple of
> > > > + * <mux_conf_reg input_reg mux_mode input_val>  */
> > > > +
> > > > +#define ULP1_PAD_PTC0__PTC0
> > > > 0x0000 0x0000 0x1 0x0
> > >
> > >
> > > For consistency with other SoCs, can we add MX7 to the define? E.g.
> > > MX7ULP1?
> > >
> >
> > ULP1 is another SoC name of IMX7ULP.
> > And there will be ULP0, ULPx in the future..
> 
> What is the external/formal SoC name for ULP0 and ULPx?
> 

I don't know, it's still a plan.
Maybe IMX7ULP0, just can't sure.

> >
> > It looks like not big issue, so I did not change it.
> 
> It's an easy change to make things more obvious, so +1 on Stefan's opinion.
> 

If we really want to change, 'IMX7ULP1' may be a little strange as 'IMX7ULP' is
the official external name and all other places are using it.
So IMX7ULP may be more suitable.

Then next generation may be:
IMX7ULP0_PAD_PTC0_PTC0.
Vs
IMX7ULP_PAD_PTC0_PTC0

Just not much better than:
ULP1_PAD_PTC0_PTC0.
vs
ULP0_PAD_PTC0_PTC0

That's why I did not do it initially.

However, if you do want the change, i'm okay to do it.
 
Regards
Dong Aisheng
