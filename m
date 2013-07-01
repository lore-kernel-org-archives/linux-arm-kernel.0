From: marex@denx.de (Marek Vasut)
Date: Mon, 1 Jul 2013 12:54:18 +0200
Subject: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time before writting
In-Reply-To: <20130701100710.GB27646@sirena.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
 <20130701100710.GB27646@sirena.org.uk>
Message-ID: <201307011254.18952.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Brown,

> On Mon, Jul 01, 2013 at 04:16:08PM +0800, Shawn Guo wrote:
> > +	/*
> > +	 * It seems that sgtl5000 takes a longer time to get the registers
> > +	 * ready for write than bread.  Let's give it a ramping time before
> > +	 * the first write goes.
> > +	 */
> > +	msleep(50);
> > +
> > 
> >  	/* Ensure sgtl5000 will start with sane register values */
> >  	ret = sgtl5000_fill_defaults(sgtl5000);
> >  	if (ret)
> 
> This seems like a really odd place to add the sleep - I'd have expected
> this to be a part of or just after the reset operation.  It's a *really*
> long sleep too, though if that's what you need that's what you need.

The delay might also be caused by the I2C driver, I have this in my ToDo to 
check, but I didn't get to it yet. On the other hand, if subsequent IO does 
work, then it's unlikely to be the case.

> Also "bread" :)

Of course, sometimes you want to put a lot of things on it, like bacon and such.

Best regards,
Marek Vasut
