From: Dave.Martin@arm.com (Dave P. Martin)
Date: Wed, 21 Apr 2010 17:07:10 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <20100421124317.GA9408@desktop>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421124317.GA9408@desktop>
Message-ID: <000101cae16c$b2d08cd0$4044010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: anfei [mailto:anfei.zhou at gmail.com] 
> Sent: 21 April 2010 13:43
> To: Dave P Martin
> Cc: 'Russell King - ARM Linux'; Jamie Lokier; Ben Dooks; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: kernel virtual memory access (from app) does not 
> generatesegfault

[...]

> > > The difference between instruction faults and data faults 
> is that we 
> > > always interpret instruction faults on pre-ARMv6 CPUs as a 
> > > 'translation fault' rather than a permission fault since 
> they can't 
> > > tell us what the problem was.
> > 
> > Note that my observations were on an armv7 kernel.  Should we still 
> > hit the same bit of code in this case, or have I 
> misdiagnosed the problem?
> > 
> You said your kernel is .28, so it seems too old and this 
> commit may fix
> it: 
> commit d25ef8b86e6a58f5476bf6e4a8da730b335f68fa
> 	ARM: 5728/1: Proper prefetch abort handling on ARMv6 and ARMv7
> 

Just to clarify, this problem was not specific to 2.6.28.  I also see the
same issue on the 2.6.31 Ubuntu lucid kernel.

So I guess I did misdiagnose the problem, though the affected code did look
worth tweaking anyway--- the suggested fixes looked sensible to me.

I see this patch didn't hit mainline before 2.6.32; I'll suggest to the
Ubuntu folks that they merge this, but I guess it's not critical for them
--- I don't think they've seen any real-life instances of this problem yet.

Cheers
---Dave
