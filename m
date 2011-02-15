From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Feb 2011 07:11:46 +0800
Subject: [PATCH v2 7/7] ARM: mxs/mx28evk: add mmc device
In-Reply-To: <20110214102646.GB30100@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
	<20110214102646.GB30100@pengutronix.de>
Message-ID: <20110215231145.GK10990@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 11:26:46AM +0100, Wolfram Sang wrote:
> Shawn,
> 
> > +/* mmc */
> > +static void __init mx28evk_mmc_slot_poweron(int gpio)
> > +{
> > +	int ret;
> > +
> > +	ret = gpio_request(gpio, "mmc-slot-power");
> > +	if (ret) {
> > +		pr_err("Failed to request gpio mmc-slot-power: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = gpio_direction_output(gpio, 0);
> > +	if (ret) {
> > +		pr_err("Failed to drive gpio mmc-slot-power: %d\n", ret);
> > +		return;
> > +	}
> > +}
> 
> Minor nit: You could use gpio_request_one(), and doing so maybe even get rid of
> this function and simply do it the init-function. The advantage would be, that
> you can name the two GPIOs independently.
> 
OK. Will take it.

Thanks,
Shawn
