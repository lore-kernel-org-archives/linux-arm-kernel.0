From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 19 Oct 2012 16:54:55 -0700
Subject: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
In-Reply-To: <1350655227.2768.11.camel@twins> (Peter Zijlstra's message of
 "Fri, 19 Oct 2012 16:00:27 +0200")
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
 <20121018055136.GF11137@arwen.pp.htv.fi>
 <1350655227.2768.11.camel@twins>
Message-ID: <87391ahvao.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, 2012-10-18 at 08:51 +0300, Felipe Balbi wrote:
>> > So the primary question remains: is RT runtime supposed to include the
>> > time spent suspended?  I suspect not. 
>> 
>> you might be right there, though we need Thomas or Peter to answer :-s 
>
> re, sorry both tglx and I have been traveling, he still is, I'm trying
> to play catch-up :-)
>
> Anyway, yeah I'm somewhat surprised the clock is 'running' when the
> machine isn't. From what I could gather, this is !x86 hardware, right?
>
> x86 explicitly makes sure our clocks are 'stopped' during suspend, see
> commit cd7240c0b900eb6d690ccee088a6c9b46dae815a.
>
> Can you do something similar for ARM?

So I did the same thing for my ARM SoC, and it definitley stops the RT
throttling.  

However, it has the undesriable (IMO) side effect of making timed printk
output rather unhelpful for debugging suspend/resume since printk time
stays constant throughout suspend/resume no matter how long you
sleep. :(

So does that mean we have to choose between useful printk times during
suspend/resume or functioning IRQ threads during suspend/resume ?

Kevin
