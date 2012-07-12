From: pavel@denx.de (Pavel Machek)
Date: Thu, 12 Jul 2012 12:33:06 +0200
Subject: [PATCH v5] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <1342041579.19608.6.camel@dinguyen-VirtualBox>
References: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
 <20120711210837.GA32489@elf.ucw.cz>
 <1342041579.19608.6.camel@dinguyen-VirtualBox>
Message-ID: <20120712103305.GA11798@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Make a common device tree glue for clocksource/dw_apb_timer.
> > > Move mach-picoxcell/time.c to be a generic device tree application
> > > of the dw_apb_timer.
> > > 
> > > Configure mach-picoxcell to use the dw_apb_timer_of device tree
> > > implementation in drivers/clocksource.
> > 
> > > @@ -25,11 +32,12 @@ static void timer_get_base_and_rate(struct device_node *np,
> > >  	if (!*base)
> > >  		panic("Unable to map regs for %s", np->name);
> > >  
> > > -	if (of_property_read_u32(np, "clock-freq", rate))
> > > -		panic("No clock-freq property for %s", np->name);
> > > +	if (of_property_read_u32(np, "clock-freq", rate) &&
> > > +		of_property_read_u32(np, "clock-frequency", rate))
> > > +		panic("No clock-frequency property for %s", np->name);
> > >  }
> > >  
> > 
> > But this should be ||, not &&, I guess.
> 
> Actually the way the code was written, it should be &&. Since
> of_property_read_u32 returns 0 for success, doing an OR will fail if 1
> of the conditions is true. We only want to fail if both conditions fail.

Oops, sorry, I was blind.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
