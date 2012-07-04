From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 04 Jul 2012 21:49:33 +0200
Subject: [PATCH v2 07/12] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <20120703165839.GA1519@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <2232439.93KkEvHiYj@flexo> <20120703165839.GA1519@lunn.ch>
Message-ID: <1779200.JgQeyzoLkl@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Tuesday 03 July 2012 18:58:39 Andrew Lunn wrote:
> On Tue, Jul 03, 2012 at 05:59:13PM +0200, Florian Fainelli wrote:
> > Hello Andrew,
> > 
> > On Tuesday 03 July 2012 16:22:40 Andrew Lunn wrote:
> > > Extends the driver to get properties from device tree. Also extend the
> > > kirkwood DT support to supply the needed properties.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > [snip]
> > > -	if ((pd->id != 0) || !pdata)
> > > +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
> > >  		return -ENODEV;
> > 
> > This is more a reminder than a real remark, but the driver here should not 
be 
> > limiting us to a single platform_device. In fact kirkwood55 (88F6282) has 
two 
> > I2C controllers for instance.
> 
> Yes, i don't understand this code. It looks impossible to use it using
> platform_data with more than one controller. Any idea why its like
> this? I didn't want to change the behavior because i don't understand
> why its like this.

No idea, we just stumbled over this with a colleague the other day, and just 
removing the check made our second I2C controller work, so I don't see any 
reason why there is such a limitation. That said, this is for a subsequent 
patch.

> 
> However, it should be possible to instantiate multiple I2C controllers
> using DT. However, i've only tested it with one.
> 
>       Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-- 
Florian
