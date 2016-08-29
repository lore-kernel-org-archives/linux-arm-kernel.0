From: anson.huang@nxp.com (Yongcai Huang)
Date: Mon, 29 Aug 2016 07:33:36 +0000
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <20160829072347.GJ30790@tiger>
References: <1472055231-28434-1-git-send-email-Anson.Huang@nxp.com>
 <1472029735.2780.3.camel@pengutronix.de>
 <AM3PR04MB131584BCC7F2389B8C9437C7F5EA0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <1472033090.2780.20.camel@pengutronix.de> <20160829072347.GJ30790@tiger>
Message-ID: <AM3PR04MB13157395B3378BAE7F0DC82CF5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2016-08-29 3:24 PM
> To: Lucas Stach <l.stach@pengutronix.de>; Yongcai Huang
> <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Fabio
> Estevam <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> kernel at pengutronix.de
> Subject: Re: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
> 
> On Wed, Aug 24, 2016 at 12:04:50PM +0200, Lucas Stach wrote:
> > Personally I would just remove the condition, but if you are concerned
> > about the double L1 flush overhead (I wouldn't worry about this, it
> > should be negligible) you should really make this conditional on an
> > architected L2 being present. Making it conditional on the outer cache
> > being absent is confusing.
> 
> Anson,
> 
> Is there any concern or problem if we follow Lucas' suggestion to
> unconditionally calls flush_cache_all() here?
> 
> Shawn

Because this code is in idle thread, my original aim is to make the latency as
small as possible, but since the double L1 flush here should finish very quick at this
stage and compare to hardware ARM core power down/up latency, it should be
negligible as Lucas mentioned, yes, I agree to remove condition check here and
just call L1 flush again to avoid any confusion. Will send out a V2 patch later, thanks.

Anson.
