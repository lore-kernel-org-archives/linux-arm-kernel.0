From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 1 Apr 2016 14:10:34 +0200
Subject: [PATCH] arm64: KVM: Add braces to multi-line if statement in
 virtual PMU code
In-Reply-To: <20160401113625.GC3604@arm.com>
References: <1459509142-13524-1-git-send-email-will.deacon@arm.com>
 <20160401113040.GD20224@cbox> <20160401113625.GC3604@arm.com>
Message-ID: <20160401121034.GA22170@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 12:36:25PM +0100, Will Deacon wrote:
> On Fri, Apr 01, 2016 at 01:30:40PM +0200, Christoffer Dall wrote:
> > On Fri, Apr 01, 2016 at 12:12:22PM +0100, Will Deacon wrote:
> > > The kernel is written in C, not python, so we need braces around
> > > multi-line if statements. GCC 6 actually warns about this, thanks to the
> > > fantastic new "-Wmisleading-indentation" flag:
> > 
> > We should rewrite the kernel in python!
> 
> Oh man, you made me look and I found this:
> 
> https://mail.python.org/pipermail/python-list/2004-October/283327.html

Haha, the reply saying "Great idea, go for it!" is hilarious.

> 
> but, today's certainly the day for whacky suggestions.
> 

I wanted to have sent you and Catalin my Linux in EL2 patch set today,
but it was still too messy and hacked up for that to be funny,
unfortunately.

> > >  | virt/kvm/arm/pmu.c: In function ?kvm_pmu_overflow_status?:
> > >  | virt/kvm/arm/pmu.c:198:3: warning: statement is indented as if it were guarded by... [-Wmisleading-indentation]
> > >  |    reg &= vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> > >  |    ^~~
> > >  | arch/arm64/kvm/../../../virt/kvm/arm/pmu.c:196:2: note: ...this ?if? clause, but it is not
> > >  |   if ((vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
> > >  |   ^~
> > > 
> > > As it turns out, this particular case is harmless (we just do some &=
> > > operations with 0), but worth fixing nonetheless.
> > > 
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > Thanks for the patch.
> 
> No problem. I timed it nicely with your pull request.
> 
Yeah, I figure I will just add it to the next pull request, unless
anyone objects to that.

-Christoffer
