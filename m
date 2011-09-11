From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 11 Sep 2011 20:53:12 +0200
Subject: [PATCH] Add platform driver support to the CS890x driver
In-Reply-To: <CAGzjT4f2agA30TGb8XFSRu57=--qyBt=bU5QWVTmU6LAGmwM8A@mail.gmail.com>
References: <1315390967-6683-1-git-send-email-jaccon.bastiaansen@gmail.com>
	<20110907125047.GU28816@pengutronix.de>
	<CAGzjT4f3VDL-rDzup4kSc11eCdhR9s7fxf8RYNjEZmK9Rk50Cw@mail.gmail.com>
	<20110910141244.GQ28816@pengutronix.de>
	<CAGzjT4f2agA30TGb8XFSRu57=--qyBt=bU5QWVTmU6LAGmwM8A@mail.gmail.com>
Message-ID: <20110911185312.GD28624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jaccon,

On Sun, Sep 11, 2011 at 07:34:25PM +0200, Jaccon Bastiaansen wrote:
> >> > hmm, better switch the complete driver to be a platform driver and
> >> > instead of the legacy probing let it create the corresponding device.
> >> >
> >>
> >> What exactly do you mean with "switch the complete driver to be a
> >> platform driver"? That I should remove all the legacy from the driver
> >> (which would break the driver for users who don't use it as a platform
> >> driver) or that I should add a new probe() function free of legacy
> >> (which would duplicate code of the existing cs89x0_probe1() function)?
> > Of course you should not break it for legacy users. Just instead of the
> > legacy stuff just add a platform device with the respective values such
> > that the platform driver is used in all cases.
> >
> > For extra points move the adding of the device to platform code.
> >
> 
> The platform device you mention is added by another patch that I also
> sent on the the 7th of September (not directly to you, but to Sascha
> and kernel at pengutronix.de). This patch was called:
> 
> [PATCH] Add CS890x0 ethernet controller support to the i.MX21ADS
> 
> In this patch I add a platform device to the i.MX21ADS evaluation
> board. All the required settings (memory address and IRQ) that the
> CS890x platform driver needs to run on the i.MX21ADS board are set in
> the i.MX21ADS specific code. You find the patch below. It this the
> approach you mean?
not really. On some machines (e.g arm/imx/mx31ads) some magic constants
are defined somewhere in arch/ to fill in netcard_portlist and
cs8900_irq_map. On these machines the cs8900 driver does drive some
hardware, but not via the platform bus. This is what i want to have
changed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
