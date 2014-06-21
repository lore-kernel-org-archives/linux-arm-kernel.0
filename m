From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Jun 2014 00:11:29 +0100
Subject: A clockevent IRQ delivery question
In-Reply-To: <CAJgR-Bgn=5Ln53faiTP4hM5TLvCLu655HXY3w=5uwvTgxA9PxA@mail.gmail.com>
References: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
 <53A446C0.10200@linaro.org>
 <CAJgR-Bj+tgCpKTT7FxM-1JMvN7CKUgpaikfbXPQx5ep6+7W2mA@mail.gmail.com>
 <20140620152335.GT32514@n2100.arm.linux.org.uk>
 <CAJgR-BiLiskWsFOK2Nr7ysTktkkAJnz8p4HJBb_YJReN3KzQXw@mail.gmail.com>
 <CAJgR-Bgn=5Ln53faiTP4hM5TLvCLu655HXY3w=5uwvTgxA9PxA@mail.gmail.com>
Message-ID: <20140621231129.GZ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 05:44:59PM -0500, Jon Loeliger wrote:
> On Fri, Jun 20, 2014 at 10:31 AM, Jon Loeliger <loeliger@gmail.com> wrote:
> > OK, I'll leave things as they stand in my port for now
> > as that appears to be working even if not ideal yet!
> 
> Do I need to do some form of IRQ broadcast to ensure all CPUs are
> receiving the timer ticks?  How do I set that up?  Pointer to an example?

Let me get this straight...

This SoC you're strugging with is a dual-core A9 system which decided to
omit the TWD (which is part of the ARM SMP spec) and subsituted their
own timers?

If that's true, then I have to ask... why do we care about this SoC?
If vendors are going to go off and blatently do something different for
no reason after ARM Ltd have tried to standardise stuff, then I think
our position should be we don't want to know.

Why?  Because of the additional support burden - not only in extra code
to sort out their (probably) screwed timer implementation which is yet
again different from everything else that we've seen so far, but also
because (and I don't mean this personally towards you) of the additional
support necessary to get the damned thing to work in the first place.

I guess the more we bend over backwards to allow this kind of thing,
the more people will think that it's an acceptable way forward.  The
only way to stop this is for people to say no to it.

So, the question is: does your SoC have the ARM TWD timers, and if it
does, why can you not use those?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
