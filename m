From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Feb 2014 11:37:39 -0800
Subject: Weird sched_clock behaviour during boot with -rc1
In-Reply-To: <52F524A3.3070400@linaro.org>
References: <20140204183641.GA25127@mudshark.cambridge.arm.com>
 <52F1518B.9010109@linaro.org>
 <20140204220045.GC20528@codeaurora.org>
 <52F524A3.3070400@linaro.org>
Message-ID: <20140207193739.GC12815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07, John Stultz wrote:
> On 02/04/2014 02:00 PM, Stephen Boyd wrote:
> >>
> > That would work, but why can't we just hold the write seqlock
> > during the registration? We would need to make a lockeless
> > version of update_sched_clock() but that doesn't look too hard.
> > It might actually turn out nicer because we call
> > update_sched_clock() here just to set the epoch_cyc but we have
> > to reset the epoch_ns back to 0 to start the count off right.
> >
> > How about this? The only concern is calling read_sched_clock()
> > inside the seqlock, but I don't think that's a concern and if it
> > is we can call it outside the lock at the beginning of this
> > function.
> 
> So whats the story here? Are we waiting on an ack from Will or would you
> rather go with Josh's approach?

An acked-by/tested-by from Will would be good. I'll cook up a
patch right now to do everything that has been mentioned in this
thread.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
