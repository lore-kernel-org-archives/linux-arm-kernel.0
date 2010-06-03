From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Thu, 3 Jun 2010 17:35:34 +0300
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100603135705.GA25357@pengutronix.de>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100603123908.GB3527@matterhorn.lan>
	<20100603135705.GA25357@pengutronix.de>
Message-ID: <20100603143534.GC3527@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 03, Sascha Hauer wrote:
> On Thu, Jun 03, 2010 at 03:39:08PM +0300, Amit Kucheria wrote:
> > Two comments inline.
> > 
> > > +static struct platform_device smsc_lan9217_device = {
> > > +	.name = "smsc911x",
> > > +	.id = 0,
> > > +	.dev = {
> > > +		.platform_data = &smsc911x_config,
> > > +	},
> > > +	.num_resources = ARRAY_SIZE(smsc911x_resources),
> > > +	.resource = smsc911x_resources,
> > > +};
> > 
> > You forgot to move this platform_device to devices.c
> 
> No, devices.c is the place for the i.MX51 integrated peripherals, not
> for externally conntected peripherals.

OK. Didn't know this was an externally connected peripheral. Which, BTW, is
also why I had suggested that the smsc and the debug board support were added as
separate patches. But it is a preference thing.

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
