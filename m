From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 11 May 2010 09:55:35 +0100
Subject: [PATCH 1/5] Add HP iPAQ RX1950 machine support
In-Reply-To: <201005110950.27613.anarsoul@gmail.com>
References: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
	<1273524194-13346-2-git-send-email-anarsoul@gmail.com>
	<20100511001542.GG6684@trinity.fluff.org>
	<201005110950.27613.anarsoul@gmail.com>
Message-ID: <20100511085534.GI6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 09:50:22AM +0300, Vasily Khoruzhick wrote:
> ?? ?????????????????? ???? 11 ?????? 2010 03:15:42 ?????????? Ben Dooks ??????????????:
> > 
> > firstly, do you need this mapping for anything and secondly can
> > you check the indentation on it if it is staying.
> 
> Ok, I don't need them.
> > > +static struct s3c2410fb_display rx1950_display __initdata = {
> > 
> > don't think this is allowed to be __initdata at the moment.
> 
> Ok
> > > +		/* Wait a bit here... */
> > > +		mdelay(100);
> > 
> > would msleep() be a better thing to do herer.
> 
> Nope, I prefer to use mdelay here, msleep doesn't do well for
> some reason (there's a garbage on screen in case of msleep usage).
> And actually wait for hsync/vsync should replace
> this mdelay, but it isn't implemented at the moment.

Can you add a comment to this effect? I'm a little conecrned that
the mdelay() and msleep() produce such differing output...
  
> > 
> > i think S3C_GPIO_SFN(2) would do for all of these, and would allow
> > you to loop over the range.
> 
> Ok
> 
> > 
> > at-least get a space between { and KEY_
> > would prefer to see properly named initialisers.
> 
> Ok
>  
> > > +	s3c_irq_wake(IRQ_EINT0, 1);
> > > +}
> > 
> > surely this should be propertyu of a key in the keys table?
> 
> Ok
>  
> > > +	gpio_request(S3C2410_GPJ(1), "MMC power");
> > > +	gpio_direction_output(S3C2410_GPJ(1), 0);
> > 
> > you might want to WARN_ON() the result of gpio_request().
> 
> Ok
> 
> Thanks for review.

No problem.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
