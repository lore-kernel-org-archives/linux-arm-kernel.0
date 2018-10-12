From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Oct 2018 16:45:34 +0100
Subject: livelock with hrtimer cpu_base->lock
In-Reply-To: <63fae7b2ef8dc4cc67928329cf7fcb60@codeaurora.org>
References: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
 <20181010164919.GA16512@arm.com>
 <63fae7b2ef8dc4cc67928329cf7fcb60@codeaurora.org>
Message-ID: <20181012154534.GA11387@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 05:55:28AM -0700, Sodagudi Prasad wrote:
> On 2018-10-10 09:49, Will Deacon wrote:
> >On Tue, Oct 09, 2018 at 01:56:14PM -0700, Sodagudi Prasad wrote:
> >>This is regarding - thread "try to fix contention between expire_timers
> >>and
> >>try_to_del_timer_sync".
> >>https://lkml.org/lkml/2017/7/28/172
> >>
> >>I think this live lockup issue was discussed earlier but the final set
> >>of
> >>changes were not concluded.
> >
> >Well we basically need a way to pick a value for CPU_RELAX_WFE_THRESHOLD.
> >Do you have any ideas? It could be determined at runtime if necessary.
> >
> 
> Please share what are values need to be tried for CPU_RELAX_WFE_THRESHOLD.
> 
>  It would be great if it can be determined from runtime.  Please let me know
> if any testing need to be done with dynamic detection patch.

I was actually hoping you'd have some ideas about how to write the patch. I
don't have a good feel for how to determine this threshold, and you have
hardware that needs it...

One avenue of exploration might be to tune the fallback to WFE based on
what percentage of the eventstream period we've been polling, e.g. 50%.

Will
