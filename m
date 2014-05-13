From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 May 2014 19:45:03 +0100
Subject: [PATCH v4] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <9034CBD80F070943B59700D7F8149ED9A0875730@SC-VEXCH4.marvell.com>
References: <1398133596-29170-1-git-send-email-zhangwm@marvell.com>
 <20140422103642.GF7484@arm.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE5507A3B59B@SC-VEXCH4.marvell.com>
 <20140423170821.GJ5649@arm.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE5507A3C1F1@SC-VEXCH4.marvell.com>
 <5360FB07.5030407@arm.com>
 <6106CAF835F351419ADA79E4836E6EC71B6A53C826@SC-VEXCH4.marvell.com>
 <9034CBD80F070943B59700D7F8149ED9A0875730@SC-VEXCH4.marvell.com>
Message-ID: <20140513184503.GF16388@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 11:22:09AM +0100, Neil Zhang wrote:
> > > The device tree bindings for power domains is under discussion [1]
> > 
> > Thanks for the information.
> > But it currently for device only, core related stuff are not supported.
> > And is it really good to register power provider for core and let vfp / pmu etc
> > to get it?
> > 
> 
> What's your suggestion about it?
> Is it OK that I add it under the PMU node?

I don't really mind. I just want to avoid re-inventing the wheel in a
PMU-specific way and having to maintain that code forever because it ended
up in our DT description.

Will
