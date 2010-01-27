From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 27 Jan 2010 13:17:30 +0100
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <20100127104537.GB17421@pengutronix.de>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<20100127104537.GB17421@pengutronix.de>
Message-ID: <1264594650.2463.66.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mer, 2010-01-27 at 11:45 +0100, Uwe Kleine-K?nig wrote:
> Hallo Alberto,
> 
> On Wed, Jan 27, 2010 at 11:33:04AM +0100, Lothar Wa?mann wrote:
> > > +	keypad->clk = clk_get(NULL, "kpp");
> > >
> > clk_get(&pdev->dev, "kpp");
> Maybe even
> 
> 	clk_get(&pdev->dev, NULL);
> 

Mmm.. kpp clock is defined as:
	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)

what you say should work if it would be defined as follow right?
	_REGISTER_CLOCK("mxc_keypad", "kpp", kpp_clk)
