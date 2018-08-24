From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 Aug 2018 11:58:14 +0100
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
In-Reply-To: <20180824101533.7728195a@bbrezillon>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell> <20180824101533.7728195a@bbrezillon>
Message-ID: <20180824105814.GG28860@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Aug 2018, Boris Brezillon wrote:

> Hi Lee,
> 
> On Wed, 15 Aug 2018 06:24:35 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > > +static const struct mfd_cell lcdc_cells[] = {
> > > +	{
> > > +		.name = "atmel-lcdc-pwm",
> > > +		.of_compatible = "atmel,lcdc-pwm",
> > > +	},
> > > +	{
> > > +		.name = "atmel-lcdc-dc",
> > > +		.of_compatible = "atmel,lcdc-display-controller",
> > > +	},
> > > +};  
> > 
> > Will you be adding any more devices, or is this the entirety of the
> > device?  If the latter, I suggest that this doesn't warrant being an
> > MFD.
> > 
> 
> Is there a lower limit to define when an MFD is recommended, or is it
> that you find a PWM (driving a backlight) and a display controller
> close enough to be implemented in a single driver?

I was erring towards that latter.

> I personally prefer the separation we have today, because I can then
> place the drivers where they belong (PWM subsystem and DRM subsystem)
> and the respective maintainers know about these drivers.

Yes separation is good a good thing.  Not placing them in MFD and
having the individual parts reside in the appropriate subsystems are
not mutually exclusive though.  I assume the Display Controller is
higher ranking than the PWM device right?  Seeing as they are so
closely bound i.e. the DC can't operated with the PWM, it would be
justifiable to register the PWM from the DC.

Of course if there is complicated set-up to be done, lots of devices
are involved or there are shared functions between them, then that is
where MFD usually steps in.

However, since there is a very similar device already in MFD, I
suggest you simply extend it to add support for this new device and
have done.
 
-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
