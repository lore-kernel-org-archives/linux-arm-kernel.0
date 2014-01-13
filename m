From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 13 Jan 2014 16:37:35 +0100
Subject: [PATCH v2 17/28] drm/i2c: tda998x: set the repeat PLL value in
 range 0..3
In-Reply-To: <20140111182602.GF15937@n2100.arm.linux.org.uk>
References: <20140109120513.0965ddad@armhf>
 <20140111182602.GF15937@n2100.arm.linux.org.uk>
Message-ID: <20140113163735.43c1d19b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jan 2014 18:26:02 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> >  	div = 148500 / mode->clock;
> > +	if (div != 0) {
> > +		div--;
> > +		if (div > 3)
> > +			div = 3;
> > +	}  
> 
> As the driver currently stands, we know that the clock divider works for
> the lower resolution modes.  So, as things stand, for 74.25MHz modes,
> we get a divisor of one.
> 
> Your patch changes this, the divider becomes zero.  I wonder whether
> you've tested 720p modes at all with this?

In 720p, the divider becomes (148500 / 74250 - 1) = 1 and this mode
works fine.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
