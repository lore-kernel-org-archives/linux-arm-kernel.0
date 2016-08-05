From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 5 Aug 2016 17:54:42 +0200
Subject: [PATCH V3 1/6] perf/core: Adding PMU driver specific configuration
In-Reply-To: <CANLsYkwNwtYHZ+BLt7iuB919zbCUUs2thfkU-bMH-+e5eMxAxg@mail.gmail.com>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-2-git-send-email-mathieu.poirier@linaro.org>
 <20160804165951.GU6862@twins.programming.kicks-ass.net>
 <CANLsYkwNwtYHZ+BLt7iuB919zbCUUs2thfkU-bMH-+e5eMxAxg@mail.gmail.com>
Message-ID: <20160805155442.GW6879@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 09:41:15AM -0600, Mathieu Poirier wrote:
> On 4 August 2016 at 10:59, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Jul 28, 2016 at 03:42:18PM -0600, Mathieu Poirier wrote:
> >> This patch somewhat mimics the work done on address filters to
> >> add the infrastructure needed to pass PMU specific HW
> >> configuration to the driver before a session starts.
> >
> > I'm thinking we want to specify a syntax and validate the string matches
> > the syntax in the generic code.
> 
> The syntax is checked in the lexer making sure that nothing other than
> @cfg or @cfg=config is sent to the kernel.  From there validation is
> done in the PMU driver that implements the set_drv_configs()
> interface.
> 
> I am not sure to get you point here - can I ask you to provide more details?

What keeps random userspace from sending malformed strings in? There's
more userspace than just the perf tool.

The kernel needs to validate structure.
