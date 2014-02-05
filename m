From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 5 Feb 2014 21:40:53 +0100 (CET)
Subject: [PATCH 2/2] clocksource: Make clocksource register functions void
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0C889.6000106@prisktech.co.nz>
 <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.02.1402052139560.24986@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yijing,

On Thu, 23 Jan 2014, David Laight wrote:

> From: Linuxppc-dev Tony Prisk
> > On 23/01/14 20:12, Yijing Wang wrote:
> > > Currently, clocksource_register() and __clocksource_register_scale()
> > > functions always return 0, it's pointless, make functions void.
> > > And remove the dead code that check the clocksource_register_hz()
> > > return value.
> > ......
> > > -static inline int clocksource_register_hz(struct clocksource *cs, u32 hz)
> > > +static inline void clocksource_register_hz(struct clocksource *cs, u32 hz)
> > >   {
> > >   	return __clocksource_register_scale(cs, 1, hz);
> > >   }
> > 
> > This doesn't make sense - you are still returning a value on a function
> > declared void, and the return is now from a function that doesn't return
> > anything either ?!?!
> > Doesn't this throw a compile-time warning??
> 
> It depends on the compiler.
> Recent gcc allow it.
> I don't know if it is actually valid C though.
> 
> There is no excuse for it on lines like the above though.

Can you please resend with that fixed against 3.14-rc1 ?

Thanks,

	tglx
