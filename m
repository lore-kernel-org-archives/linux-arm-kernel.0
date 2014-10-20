From: zhangwm@marvell.com (Neil Zhang)
Date: Mon, 20 Oct 2014 01:46:17 -0700
Subject: [PATCH v4] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <20140703175706.GI17372@arm.com>
References: <20140423170821.GJ5649@arm.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE5507A3C1F1@SC-VEXCH4.marvell.com>
 <5360FB07.5030407@arm.com>
 <6106CAF835F351419ADA79E4836E6EC71B6A53C826@SC-VEXCH4.marvell.com>
 <9034CBD80F070943B59700D7F8149ED9A0875730@SC-VEXCH4.marvell.com>
 <20140513184503.GF16388@arm.com>
 <9034CBD80F070943B59700D7F8149ED9A087573F@SC-VEXCH4.marvell.com>
 <537337F3.4080300@arm.com>
 <9034CBD80F070943B59700D7F8149ED9A0875776@SC-VEXCH4.marvell.com>
 <9034CBD80F070943B59700D7F8149ED90182308172@SC-VEXCH4.marvell.com>
 <20140703175706.GI17372@arm.com>
Message-ID: <9034CBD80F070943B59700D7F8149ED9024EB81CD8@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: 2014?7?4? 1:57
> To: Neil Zhang
> Cc: Sudeep Holla; 'linux at arm.linux.org.uk'; 'linux-arm-
> kernel at lists.infradead.org'; 'linux-kernel at vger.kernel.org';
> 'devicetree at vger.kernel.org'
> Subject: Re: [PATCH v4] ARM: perf: save/restore pmu registers in pm
> notifier
> 
> On Mon, Jun 30, 2014 at 11:39:15AM +0100, Neil Zhang wrote:
> > > > > I will prepare another patch to add DT description under PMU
> > > > > since there is no generic power domain support for pm notifier
> > > > > if no other
> > > > concerns.
> > > > > We can change the manner if there is generic power domain
> > > > > support for
> > > > pm notifier later.
> > > > > Thanks.
> > > >
> > > > No, please don't add any DT bindings for power domains specific
> to
> > > > PMU node.
> > > > We can't change the DT bindings once added.
> > > >
> > > > As I pointed out the DT bindings for generic power domains are
> > > > under discussion.
> > > > See if you can reuse it, if not help in extending it so that it
> can be used.
> > > >
> > >
> > > Sorry for reply later.
> > > As I said before the under discussed generic power domain is not
> > > suitable for CPU peripherals since they are all known belong to CPU
> > > or cluster power domain.
> > > If we want to follow the way they are discussion, we need to
> > > register core and cluster power provider, and need vfp/gic/pmu etc
> to require them.
> > > Is it really suitable?
> > >
> > Do you have any comments?
> > If no, I would like to put it under PMU node.
> 
> Sudeep is a better person to comment than me, but I'd still rather this
> was handled more generically as opposed to a PMU-specific hack. I don't
> see a problem including GIC and VFP here, but only when we actually
> need to save/restore them (i.e. what the hardware guys went crazy with
> the power domains).
> 

Long time no follow up for this loop.
Sorry that I will pick it again.

Will,
I prefer to check always-on field under PMU node to check whether we need
Save/restore them.

Here is a sample for arch timer which also add under itself.
What do you think?

commit 82a5619410d4c4df65c04272db198eca5a867c18
Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Tue Apr 8 10:04:32 2014 +0100

    clocksource: arch_arm_timer: Fix age-old arch timer C3STOP detection issue


> Will

Best Regards,
Neil Zhang
