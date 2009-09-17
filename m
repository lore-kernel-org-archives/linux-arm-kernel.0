From: schen@mvista.com (Steve Chen)
Date: Thu, 17 Sep 2009 17:25:04 -0500
Subject: [PATCH v2] arm: remove unused code in delay.S
In-Reply-To: <20090917213723.GC10599@shareable.org>
References: <1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
	<m3k4zzdimy.fsf@intrepid.localdomain>
	<20090916134721.GA11218@n2100.arm.linux.org.uk>
	<20090917193257.GA10599@shareable.org>
	<20090917194119.GA12510@n2100.arm.linux.org.uk>
	<1253222978.3273.236.camel@linux-1lbu>
	<20090917213723.GC10599@shareable.org>
Message-ID: <1253226304.3273.249.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-09-17 at 22:37 +0100, Jamie Lokier wrote:
> Steve Chen wrote:
> > +	help
> > +	  Enable this if observing longer than expected delays.  This code
> > +	  improves delay accuracy for some CPUs.  However, it can also cause
> > +	  delay duration to be too short for others which leads to stability
> > +	  issues.
> > +
> > +	  In other words, do not enable unless you can guarantee that the
> > +	  processor (or ALL of the processors if building a generic kernel)
> > +	  delays for at least the time requested after enabling.
> > +
> >  endmenu
> 
> It would be very helpful to mention which CPUs are affected.
> Ok, we don't know exactly...
> 
> But Russell has stated that ARM610 and ARM710 benefit from enabling
> the code, and that it specifically must not be enabled for StrongARM.
> 
> Here's an additional paragraph to add on the end:
> 
> 	ARM610 and ARM710 are known to benefit from enabling this option.
> 	It should not be enabled for StrongARMs, because it is known
> 	to produce too short delays on those.
> 
Sure, I can add this paragraph in the next revision.

> Maybe you can adjust the config selectors and default to match?

I'm not sure about this one.  For one thing, in the last e-mail between
you and Russel I saw

>> Btw, do you know where PT110 fits in?  Is it like StrongARM (SA110)?
> No idea.

Not to mention the difficulties to account for all the possible
permutations for kernels that is built for multiple CPUs.  Perhaps we
can start a list of the processors that should have this flag enabled
and the list of processors should have the flag disabled (instead of the
paragraph you suggested).  This way, people can just add to the list as
they experiment with this flag on whatever CPU version that they worked
on.

Regards,

Steve
