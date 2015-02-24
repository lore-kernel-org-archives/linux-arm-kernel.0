From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 24 Feb 2015 15:54:07 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <54EC5C69.2010909@linaro.org>
References: <20150220093659.GA23469@gmail.com>
 <20150220113753.GP5029@twins.programming.kicks-ass.net>
 <20150220114136.GA27483@gmail.com>
 <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
 <20150220132220.GB28882@gmail.com>
 <CAKohpokEV7EatQROgzQBWPRPFEn8OsMo5EHa+q1FMwBESwiU3w@mail.gmail.com>
 <20150220140432.GA31928@gmail.com>
 <CAKohponv=aR7Ae_z7zbnDDeJ-mCFwdxB3wR-O4boBeMKYdUJLA@mail.gmail.com>
 <20150223163706.GA12551@gmail.com> <54EC5C69.2010909@linaro.org>
Message-ID: <20150224145407.GA26609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* viresh kumar <viresh.kumar@linaro.org> wrote:

> On Monday 23 February 2015 10:07 PM, Ingo Molnar wrote:>
> > * Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > Ok, could we rename it to something like DETACHED?
> >
> > 'UNUSED' really gives me the wrong impression - it's what
> > we do for unused fields, unused ABI enumertion constants,
> > etc.
> 
> Sure.
> 
> >>> Also, I'd suggest to rename all 'modes' to true state
> >>> machine naming: STATE_INITIALIZED, STATE_SHUT_DOWN,
> >>> STATE_PERIODIC, STATE_RESUMED, etc.: if these are enums
> >>> for
> >>
> >> I thought so initially and it looked like the diff will
> >> be huge as all the variables for the enum, i.e. 'mode',
> >> need to be renamed to 'state'..
> >>
> >> But, if you are okay with it then I would be happy to do
> >> that..
> >
> > Well, how does the diffstat look like?
> >
> > But if the conversion was scripted (i.e. is relatively
> > secure from typos) then that's still fine IMO. Peter?
> 
> Here is the diff:

And here's the diffstat:

 arch/arm/common/bL_switcher.c |    8 +--
 include/linux/clockchips.h    |   48 ++++++++++++------
 kernel/time/clockevents.c     |  109 ++++++++++++++++++++++++------------------
 kernel/time/tick-broadcast.c  |   22 ++++----
 kernel/time/tick-common.c     |    9 +--
 kernel/time/tick-internal.h   |    1 
 kernel/time/tick-oneshot.c    |    6 +-
 kernel/time/timer_list.c      |   16 +++---
 8 files changed, 129 insertions(+), 90 deletions(-)

Not too bad I think.

Thanks,

	Ingo
