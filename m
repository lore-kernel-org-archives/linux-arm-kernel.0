From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Nov 2017 19:23:03 +0000
Subject: [PATCH v2 07/12] hwrng: bcm2835-rng: Manage an optional clock
In-Reply-To: <1065382783.63901.1510168797132@email.1und1.de>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-8-f.fainelli@gmail.com>
 <1065382783.63901.1510168797132@email.1und1.de>
Message-ID: <20171108192303.GT9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 08, 2017 at 08:19:57PM +0100, Stefan Wahren wrote:
> Hi Florian,
> > +	/* Clock is optional on most platforms */
> > +	priv->clk = devm_clk_get(dev, NULL);
> > +
> 
> At least EPROBE_DEFER should be handled here:
> 
> if (IS_ERR(priv->clk) && PTR_ERR(priv->clk) == -EPROBE_DEFER)
> 	return -EPROBE_DEFER;

	if (priv->clk == ERR_PTR(-EPROBE_DEFER))
		return -EPROBE_DEFER;

is a simpler test for one particular error-pointer value.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
