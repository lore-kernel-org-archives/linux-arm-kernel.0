From: ping.bai@nxp.com (Jacky Bai)
Date: Mon, 5 Feb 2018 09:07:24 +0000
Subject: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180205084505.GV31354@dragon>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-2-l.stach@pengutronix.de>
 <HE1PR04MB3113FF72B02D642392D625DF87F90@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <20180205084505.GV31354@dragon>
Message-ID: <HE1PR04MB31135BD7833FD443CD6BAD6B87FE0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
> 
> On Fri, Feb 02, 2018 at 08:13:56AM +0000, Jacky Bai wrote:
> > > Subject: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
> > >
> > > This adds the basic DTS for the i.MX8MQ.
> > > For now only the following peripherals are supported:
> > > - IOMUXC (pin controller)
> > > - CCM (clock controller)
> > > - GPIO
> > > - UART
> > > - uSDHC (SD/eMMC controller)
> > > - FEC (ethernet controller)
> > > - i2c
> > >
> > > This is enough to get a very basic board support up and running.
> > >
> > > One known limitation is that the driver for the GPC interrupt
> > > controller is still missing, rendering the CPU sleep states unusable
> > > as there is nothing waking them up anymore. This will be fixed in
> > > due course.
> > >
> >
> > The cpu sleep states can NOT be supported in community kernel due to
> hardware limitation.
> 
> Jacky,
> 
> Can you elaborate your comment a bit?  If it's a hardware limitation, I guess
> not only community but also vendor kernel has no way to support sleep states,
> right?
> 
> Shawn

It need to add a workaround in GIC common code, maybe it can NOT be accepted by community.

BR
Jacky bai
