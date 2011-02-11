From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 11 Feb 2011 10:42:48 +0100
Subject: [PATCH 1/5] mmc: sdhci-esdhc-imx: add support for write
	protect on custom GPIO
In-Reply-To: <201102110924.38338.marc@cpdesign.com.au>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
	<1297365291-1038-2-git-send-email-w.sang@pengutronix.de>
	<201102110924.38338.marc@cpdesign.com.au>
Message-ID: <20110211094248.GA2264@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Fri, Feb 11, 2011 at 09:24:38AM +1100, Marc Reilly wrote:

> Tested-by: Marc Reilly <marc@cpdesign.com.au> 

Thanks a lot!

> > +	if (boarddata) {
> 
> Perhaps (boarddata && gpio_is_valid(boarddata->wp_gpio) as above?
> 
> For example what if someone sets up the boarddata for a card detect, but not 
> write protect.

Well, I couldn't do this here, because later the cd_pin-stuff will also
be added to the if-block. However, I see what you mean and that could
still be added before the gpio_request below. That would add another
level of indentation, though, for a case I'd consider to be more
theoretical (and definately not recommended). Maybe I will adjust the
warning message to be also understandable for the case a GPIO is preset
with an invalid number. I think the warning itself is justified.

> 
> > +		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
> > +		if (err) {
> > +			dev_warn(mmc_dev(host->mmc), "can't get wp_pin!\n");
> > +			boarddata->wp_gpio = err;
> > +		}
> > +	}

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
