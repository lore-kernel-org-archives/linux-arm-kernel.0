From: david-b@pacbell.net (David Brownell)
Date: Wed, 23 Jun 2010 02:39:46 -0700 (PDT)
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and sleeping
	gpios)
In-Reply-To: <4C21955D.1020502@bluewatersys.com>
Message-ID: <728731.73469.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Tue, 6/22/10, Ryan Mallon <ryan@bluewatersys.com> wrote:

> > --- On Tue, 6/22/10, Ryan Mallon <ryan@bluewatersys.com>
> wrote:
> > 
> > 
> >> gpiolib
> > 
> > 
> > Again, you're talking about "gpiolib" when
> > you seem to mean the GPIO framework itself
> > (for which gpiolib is only an implementation
> > option)...
> 
> Fine, its just semantics.

Yes, just the foundation of what you're
saying.  Stuff that, when you get it wrong,
prevents communication.  Try to get it right.

If you can't be bothered to get the basics
right, I'll just have to assume you're being
a troll.  There's enough evidence of that in
other parts of your latest message; sorry.


 I think everyone knows what I
> mean when I
> refer to gpiolib.

Not without first wasting tiime finding
that you don't really mean "gpiolib"; you
instead mean something else entirely.  Sigh.

 
> >> 'Can sleep' for a gpio has two different meanings
> depending
> >> on context
> > 
> > NO; for the GPIO itself it's only ever had one
> > meaning, regardless of context.
> > 
> > You're trying to conflate the GPIO and one
> > of the contexts in which it's used.? That's
> > the problem you seem to be struggling with.
> > 
> > Please stop conflating/confusing
> > those two disparate concepts...
> 
> I'm not. 

BUT Your "counter" example below is solid
proof that you are:  it shows exactly the
confusion I pointed out:  call context versus
the GPIO itself.  There's no way I can read
that as anything except "you are"...

 
Your intent here seems perhaps more to
be a troll than to address any real
technical issues.  I don't see much
point participating any further.


 Some gpios, such as those on io expanders, may
> sleep in their
> implementations of the gpio_(set/get) functions.
> 

Such GPIOs have a "cansleep" attribute, in short.


> Drivers, which use a gpio, may call gpio_(set/get)
> functions for a given
> gpio from a context where it is not safe to sleep.

And that's the call dontext
(in this case, from a driver).

  QED.  You are confusing two disparate concepts.


 In this
> case, a gpio
> which may sleep (ie one on an i2c io-expander) cannot be
> used with this
> driver. The gpio_request will succeed, but any call to
> gpio_(set/get)_value will produce a warning.
> 
> >> example, if a driver calls gpio_get_value(gpio)
> from an
> >> interupt handler


(YOU introduce interrupt/IRQ handlers...)

> >> then the gpio must not be a sleeping gpio.
> > 
> > In a threaded IRQ handler it's OK to use
> > the get_value_cansleep() option..
> 
> Ugh, you are really twisting my words.


You said IRQ handler, so did I.  In what csense could I
possibly be "twisting" your words"???


STOP TROLLING.




 replace 'interrupt
> handler' with
> 'non sleep safe context'.

No, that would really be "twisting", by
moving words from one place to another
and significantly changing meanings.
