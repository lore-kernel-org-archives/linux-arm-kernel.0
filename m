From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 10 Mar 2015 14:05:41 +0100
Subject: [PATCH 0/3] clockevents: Manage device's state separately for core
In-Reply-To: <CAKohpok+bfVVm-6fW5+tJCOKQA+dY=8zHykdyJEcUNbgGQyrcQ@mail.gmail.com>
References: <cover.1425037853.git.viresh.kumar@linaro.org>
 <CAKohpok+bfVVm-6fW5+tJCOKQA+dY=8zHykdyJEcUNbgGQyrcQ@mail.gmail.com>
Message-ID: <20150310130541.GA26185@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 27 February 2015 at 17:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi Thomas/Ingo,
> >
> > This is in response to the suggestions Ingo gave [1] on the shortcomings of
> > clockevents core's state machine.
> >
> > This first separates out the RESUME functionality from other states as its a
> > special case. Then it defines a new enum to map possible states of a clockevent
> > device.
> >
> > Ideally it should only be available for the core, but as bL switcher is using it
> > today, it is exposed in clockchips.h. That dependency will go away after
> > applying the Thomas's work (Sent out be Peter) and then we can move this enum to
> > somewhere in kernel/time/.
> >
> > The last patch moves the legacy check to the legacy code.
> >
> > Please see if this meets your expectation or if you have some suggestions on it.
> >
> > Rebased of tip/master as there were some dependencies:
> > 575daeea39a3 Merge branch 'tools/kvm'
> >
> > This along with migration of few clockevents drivers is pushed here:
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git clkevt/manage-state
> >
> > --
> > Viresh
> >
> > [1] https://lkml.org/lkml/2015/2/20/107
> >
> > Viresh Kumar (3):
> >   clockevents: Handle tick device's resume separately
> >   clockevents: Manage device's state separately for the core
> >   clockevents: Don't validate dev->mode against CLOCK_EVT_MODE_UNUSED
> >     for new interface
> 
> Ingo,
> 
> Gentle reminder ping...

Yeah, so I'd like PeterZ to ACK/NAK this approach before I move 
forward with the patches - but he's on the road right now, so it
will take a week I suspect.

Thanks,

	Ingo
