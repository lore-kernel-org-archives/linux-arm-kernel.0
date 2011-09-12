From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Sep 2011 14:30:23 +0200
Subject: [PATCH] Add platform driver support to the CS890x driver
In-Reply-To: <CAGzjT4ce0gZ2e6cM1PfUb9JkZ=52PUCjPz1C9qjjRYxgSJckbQ@mail.gmail.com>
References: <1315390967-6683-1-git-send-email-jaccon.bastiaansen@gmail.com>
	<20110907125047.GU28816@pengutronix.de>
	<CAGzjT4f3VDL-rDzup4kSc11eCdhR9s7fxf8RYNjEZmK9Rk50Cw@mail.gmail.com>
	<20110910141244.GQ28816@pengutronix.de>
	<CAGzjT4f2agA30TGb8XFSRu57=--qyBt=bU5QWVTmU6LAGmwM8A@mail.gmail.com>
	<20110911185312.GD28624@pengutronix.de>
	<CAGzjT4ce0gZ2e6cM1PfUb9JkZ=52PUCjPz1C9qjjRYxgSJckbQ@mail.gmail.com>
Message-ID: <20110912123023.GJ28624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jaccon,

On Mon, Sep 12, 2011 at 12:52:52PM +0200, Jaccon Bastiaansen wrote:
> 2011/9/11 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >             On some machines (e.g arm/imx/mx31ads) some magic constants
> > are defined somewhere in arch/ to fill in netcard_portlist and
> > cs8900_irq_map. On these machines the cs8900 driver does drive some
> > hardware, but not via the platform bus. This is what i want to have
> > changed.
> >
> 
> Ok, so you would like to see the #ifdefs for the IXDP2351, IXDP2X01,
> QQ2440 and MX31ADS in the cs890x driver replaced by platform_device
> definitions in the platform specific code of those platforms (in the
> same way as I have done for the i.MX21ADS platform)? Is this correct?
More or less, yes. I would have started to keep the change local to
the cs8900 driver, but moving the devices to arch is the final goal.

The upside of first reworking the driver and only then move the devices
out is that it might be better/easier to bisect and review.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
