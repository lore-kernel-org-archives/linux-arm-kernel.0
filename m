From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 11 May 2010 12:51:10 +0300
Subject: [PATCH 1/5] Add HP iPAQ RX1950 machine support
In-Reply-To: <20100511085534.GI6684@trinity.fluff.org>
References: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
	<201005110950.27613.anarsoul@gmail.com>
	<20100511085534.GI6684@trinity.fluff.org>
Message-ID: <201005111251.15504.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 11 ??? 2010 11:55:35 ????? Ben Dooks ???????:
> On Tue, May 11, 2010 at 09:50:22AM +0300, Vasily Khoruzhick wrote:
> > ?? ?????????????????? ???? 11 ?????? 2010 03:15:42 ?????????? Ben Dooks 
??????????????:
> > > firstly, do you need this mapping for anything and secondly can
> > > you check the indentation on it if it is staying.
> > 
> > Ok, I don't need them.
> > 
> > > > +static struct s3c2410fb_display rx1950_display __initdata = {
> > > 
> > > don't think this is allowed to be __initdata at the moment.
> > 
> > Ok
> > 
> > > > +		/* Wait a bit here... */
> > > > +		mdelay(100);
> > > 
> > > would msleep() be a better thing to do herer.
> > 
> > Nope, I prefer to use mdelay here, msleep doesn't do well for
> > some reason (there's a garbage on screen in case of msleep usage).
> > And actually wait for hsync/vsync should replace
> > this mdelay, but it isn't implemented at the moment.
> 
> Can you add a comment to this effect? I'm a little conecrned that
> the mdelay() and msleep() produce such differing output...

Even more, backlight notify callback can be called in atomic context (in 
suspend handler of pwm_bl driver), and notify callback calls lcd_power 
functions so using msleep is impossible - device doesn't wake up. So I think 
comment is not necessary, but if you insist
I can add it and send v3 of patch series.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100511/03f29721/attachment.sig>
