From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 13 Sep 2017 10:00:11 +0200
Subject: [PATCH 4/4] arm64/syscalls: Move address limit check in loop
In-Reply-To: <CAGXu5jLXSxoFLnP-YHab0raYjt8nY_tfnCYmE1_9XOAio4MRCw@mail.gmail.com>
References: <1504798247-48833-1-git-send-email-keescook@chromium.org>
 <1504798247-48833-5-git-send-email-keescook@chromium.org>
 <20170912182727.GB27652@arm.com>
 <CAGXu5jLXSxoFLnP-YHab0raYjt8nY_tfnCYmE1_9XOAio4MRCw@mail.gmail.com>
Message-ID: <20170913080011.cxydu4ptal53okzm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> On Tue, Sep 12, 2017 at 11:27 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Kees,
> >
> > On Thu, Sep 07, 2017 at 08:30:47AM -0700, Kees Cook wrote:
> >> From: Thomas Garnier <thgarnie@google.com>
> >>
> >> A bug was reported on ARM where set_fs might be called after it was
> >> checked on the work pending function. ARM64 is not affected by this bug
> >> but has a similar construct. In order to avoid any similar problems in
> >> the future, the addr_limit_user_check function is moved at the beginning
> >> of the loop.
> >>
> >> Fixes: cf7de27ab351 ("arm64/syscalls: Check address limit on user-mode return")
> >> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  arch/arm64/kernel/signal.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > What's the plan for this series? It looks like somehow an old v2 of the
> > original series made it into mainline, so I'd like to see these fixes get
> > in ASAP. I'm still slightly nervous about pathological setting of the
> > FSCHECK flag due to e.g. a PMU IRQ causing a livelock in do_notify_resume,
> > but that's at least less likely with this fix :/
> 
> Hi! I resent this to Ingo to pick up for -tip. I think he's waiting
> for -rc1, IIUC. Ingo, can you comment on timing for this getting sent
> to Linus?

Will accelerate them - didn't realize the urgency.

Thanks,

	Ingo
