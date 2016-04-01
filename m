From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Apr 2016 12:36:25 +0100
Subject: [PATCH] arm64: KVM: Add braces to multi-line if statement in
 virtual PMU code
In-Reply-To: <20160401113040.GD20224@cbox>
References: <1459509142-13524-1-git-send-email-will.deacon@arm.com>
 <20160401113040.GD20224@cbox>
Message-ID: <20160401113625.GC3604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 01:30:40PM +0200, Christoffer Dall wrote:
> On Fri, Apr 01, 2016 at 12:12:22PM +0100, Will Deacon wrote:
> > The kernel is written in C, not python, so we need braces around
> > multi-line if statements. GCC 6 actually warns about this, thanks to the
> > fantastic new "-Wmisleading-indentation" flag:
> 
> We should rewrite the kernel in python!

Oh man, you made me look and I found this:

https://mail.python.org/pipermail/python-list/2004-October/283327.html

but, today's certainly the day for whacky suggestions.

> >  | virt/kvm/arm/pmu.c: In function ?kvm_pmu_overflow_status?:
> >  | virt/kvm/arm/pmu.c:198:3: warning: statement is indented as if it were guarded by... [-Wmisleading-indentation]
> >  |    reg &= vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> >  |    ^~~
> >  | arch/arm64/kvm/../../../virt/kvm/arm/pmu.c:196:2: note: ...this ?if? clause, but it is not
> >  |   if ((vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
> >  |   ^~
> > 
> > As it turns out, this particular case is harmless (we just do some &=
> > operations with 0), but worth fixing nonetheless.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks for the patch.

No problem. I timed it nicely with your pull request.

Will
