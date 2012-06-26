From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 20:13:36 +0800
Subject: [PATCH 3/3] net: fec: add phy-reset-interval for device tree probe
In-Reply-To: <2921547.BkALd1Y1Bk@flexo>
References: <1340700308-8315-1-git-send-email-shawn.guo@linaro.org>
 <1340700308-8315-4-git-send-email-shawn.guo@linaro.org>
 <2921547.BkALd1Y1Bk@flexo>
Message-ID: <20120626121334.GF8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 01:55:05PM +0200, Florian Fainelli wrote:
> > +	of_property_read_u32(np, "phy-reset-interval", &msec);
> >  	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
> >  	err = gpio_request_one(phy_reset, GPIOF_OUT_INIT_LOW, "phy-reset");
> >  	if (err) {
> >  		pr_debug("FEC: failed to get gpio phy-reset: %d\n", err);
> >  		return;
> >  	}
> > -	msleep(1);
> > +	msleep(msec);
> 
> You might want to check the value of the property here to make sure it is in 
> the msleep() acceptable range.
> 
Sounds good.  I think a sensible reset duration should be less one
second, so let's force 1000 ms to be the possible max one?

-- 
Regards,
Shawn
