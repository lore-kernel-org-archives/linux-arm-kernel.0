From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 20:17:43 +0000
Subject: [PATCHv3,RESEND] rtc: Add support for Intersil ISL12057 I2C RTC
 chip
In-Reply-To: <20131216201424.GA6639@roeck-us.net>
References: <637f26e051b700ca510a0af695dfd84cf2bfd35d.1387222475.git.arno@natisbad.org>
 <20131216201424.GA6639@roeck-us.net>
Message-ID: <20131216201743.GT3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 12:14:24PM -0800, Guenter Roeck wrote:
> On Mon, Dec 16, 2013 at 08:49:36PM +0100, Arnaud Ebalard wrote:

> > +#ifdef CONFIG_OF
> > +static struct of_device_id isl12057_dt_match[] = {
> > +	{ .compatible = "isl,isl12057" },
> > +	{ },
> > +};
> > +#endif

> Is this needed ? For i2c devices, struct i2c_device_id should be sufficient.

It is required, it's bad practice to omit the vendor specifier.
Different vendors can and do use the same prefix in their device names
leading to collisions - for example both Wondermedia and Wolfson use wm.
Linux happens to accept unprefixed names but that doesn't mean it's a
good idea.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/5f2876f4/attachment.sig>
