From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 10:15:33 +0200
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
In-Reply-To: <20180815052435.GA6412@dell>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell>
Message-ID: <20180824101533.7728195a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 15 Aug 2018 06:24:35 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> > +static const struct mfd_cell lcdc_cells[] = {
> > +	{
> > +		.name = "atmel-lcdc-pwm",
> > +		.of_compatible = "atmel,lcdc-pwm",
> > +	},
> > +	{
> > +		.name = "atmel-lcdc-dc",
> > +		.of_compatible = "atmel,lcdc-display-controller",
> > +	},
> > +};  
> 
> Will you be adding any more devices, or is this the entirety of the
> device?  If the latter, I suggest that this doesn't warrant being an
> MFD.
> 

Is there a lower limit to define when an MFD is recommended, or is it
that you find a PWM (driving a backlight) and a display controller
close enough to be implemented in a single driver?

I personally prefer the separation we have today, because I can then
place the drivers where they belong (PWM subsystem and DRM subsystem)
and the respective maintainers know about these drivers.

Regards,

Boris
