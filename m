From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 5 Aug 2016 17:53:44 +0200
Subject: [PATCH V3 1/6] perf/core: Adding PMU driver specific configuration
In-Reply-To: <CANLsYkzK+mNRYiGn0SLQ5kA0+xxi6OGVbNL4F3LLRBTgSkssxQ@mail.gmail.com>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-2-git-send-email-mathieu.poirier@linaro.org>
 <20160804165821.GT6862@twins.programming.kicks-ass.net>
 <CANLsYkzK+mNRYiGn0SLQ5kA0+xxi6OGVbNL4F3LLRBTgSkssxQ@mail.gmail.com>
Message-ID: <20160805155344.GV6879@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 09:35:05AM -0600, Mathieu Poirier wrote:
> On 4 August 2016 at 10:58, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Jul 28, 2016 at 03:42:18PM -0600, Mathieu Poirier wrote:
> >> This patch somewhat mimics the work done on address filters to
> >> add the infrastructure needed to pass PMU specific HW
> >> configuration to the driver before a session starts.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> >> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> >> index c66a485a24ac..90fbc5fd3925 100644
> >> --- a/include/uapi/linux/perf_event.h
> >> +++ b/include/uapi/linux/perf_event.h
> >> @@ -407,6 +407,7 @@ struct perf_event_attr {
> >>  #define PERF_EVENT_IOC_ID            _IOR('$', 7, __u64 *)
> >>  #define PERF_EVENT_IOC_SET_BPF               _IOW('$', 8, __u32)
> >>  #define PERF_EVENT_IOC_PAUSE_OUTPUT  _IOW('$', 9, __u32)
> >> +#define PERF_EVENT_IOC_SET_DRV_CONFIGS       _IOW('$', 10, char *)
> >
> > Please also do a manpages patch.
> 
> Patch 3/6 in this set documents the new option
> (tools/perf/Documentation/perf-record.tx).  Is this what you were
> looking for?  If not please expand on the information you want to see
> added add and where.

Since you add an IOCTL (with preferably more structure than present in
this patch, see the other email) this needs to be documented in the
syscall manpage.

  http://git.kernel.org/cgit/docs/man-pages/man-pages.git/tree/man2/perf_event_open.2

  http://www.man7.org/linux/man-pages/man2/perf_event_open.2.html
