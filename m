From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Dec 2013 13:02:57 -0800
Subject: [PATCHv3,RESEND] rtc: Add support for Intersil ISL12057 I2C RTC
 chip
In-Reply-To: <20131216201743.GT3185@sirena.org.uk>
References: <637f26e051b700ca510a0af695dfd84cf2bfd35d.1387222475.git.arno@natisbad.org>
 <20131216201424.GA6639@roeck-us.net>
 <20131216201743.GT3185@sirena.org.uk>
Message-ID: <20131216210257.GA7981@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 08:17:43PM +0000, Mark Brown wrote:
> On Mon, Dec 16, 2013 at 12:14:24PM -0800, Guenter Roeck wrote:
> > On Mon, Dec 16, 2013 at 08:49:36PM +0100, Arnaud Ebalard wrote:
> 
> > > +#ifdef CONFIG_OF
> > > +static struct of_device_id isl12057_dt_match[] = {
> > > +	{ .compatible = "isl,isl12057" },
> > > +	{ },
> > > +};
> > > +#endif
> 
> > Is this needed ? For i2c devices, struct i2c_device_id should be sufficient.
> 
> It is required, it's bad practice to omit the vendor specifier.
> Different vendors can and do use the same prefix in their device names
> leading to collisions - for example both Wondermedia and Wolfson use wm.
> Linux happens to accept unprefixed names but that doesn't mean it's a
> good idea.

Ok, I'll keep that in mind.

Thanks,
Guenter
