From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 30 May 2017 16:23:45 +0800
Subject: [PATCH v13 0/9] coresight: enable debug module
In-Reply-To: <CANLsYkyvcg6deYAHUCqmz=gAHeph1XkG0FrYV4cVrkLHS=CXEg@mail.gmail.com>
References: <1495727836-30094-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkyvcg6deYAHUCqmz=gAHeph1XkG0FrYV4cVrkLHS=CXEg@mail.gmail.com>
Message-ID: <20170530082345.GB7177@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 29, 2017 at 10:41:17AM -0600, Mathieu Poirier wrote:
> On 25 May 2017 at 09:57, Leo Yan <leo.yan@linaro.org> wrote:
> > ARMv8 architecture reference manual (ARM DDI 0487A.k) Chapter H7 "The
> > Sample-based Profiling Extension" has description for sampling
> > registers, we can utilize these registers to check program counter
> > value with combined CPU exception level, secure state, etc. So this is
> > helpful for CPU lockup bugs, e.g. if one CPU has run into infinite loop
> > with IRQ disabled; the 'hang' CPU cannot switch context and handle any
> > interrupt, so it cannot handle SMP call for stack dump, etc.
> >
> > This patch series is to enable coresight debug module with sample-based
> > registers and register call back notifier for PCSR register dumping
> > when panic happens, so we can see below dumping info for panic; and
> > this patch series has considered the conditions for access permission
> > for debug registers self, so this can avoid access debug registers when
> > CPU power domain is off; the driver also try to figure out the CPU is
> > in secure or non-secure state.
> 
> I have queued patches 1 to 7 to my tree.  I can't do anything about
> patches 8 and 9 because they haven't been ack'ed.  From here you can
> either chase them to get an ACK or send a separate patch to them
> directly.

Thanks a lot, Mathieu. I will ping Wei and Andy/David saperately.

> Thanks,
> Mathieu
