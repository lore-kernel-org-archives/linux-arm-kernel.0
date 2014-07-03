From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 18:57:06 +0100
Subject: [PATCH v4] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <9034CBD80F070943B59700D7F8149ED90182308172@SC-VEXCH4.marvell.com>
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
Message-ID: <20140703175706.GI17372@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 11:39:15AM +0100, Neil Zhang wrote:
> > > > I will prepare another patch to add DT description under PMU since
> > > > there is no generic power domain support for pm notifier if no other
> > > concerns.
> > > > We can change the manner if there is generic power domain support
> > > > for
> > > pm notifier later.
> > > > Thanks.
> > >
> > > No, please don't add any DT bindings for power domains specific to PMU
> > > node.
> > > We can't change the DT bindings once added.
> > >
> > > As I pointed out the DT bindings for generic power domains are under
> > > discussion.
> > > See if you can reuse it, if not help in extending it so that it can be used.
> > >
> > 
> > Sorry for reply later.
> > As I said before the under discussed generic power domain is not suitable for
> > CPU peripherals since they are all known belong to CPU or cluster power
> > domain.
> > If we want to follow the way they are discussion, we need to register core
> > and cluster power provider, and need vfp/gic/pmu etc to require them.
> > Is it really suitable?
> > 
> Do you have any comments?
> If no, I would like to put it under PMU node.

Sudeep is a better person to comment than me, but I'd still rather this was
handled more generically as opposed to a PMU-specific hack. I don't see a
problem including GIC and VFP here, but only when we actually need to
save/restore them (i.e. what the hardware guys went crazy with the power
domains).

Will
