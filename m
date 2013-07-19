From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 17:23:15 -0700
Subject: [PATCH v4 00/17] 64-bit friendly generic sched_clock()
In-Reply-To: <51E88170.3080505@linaro.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <51E88170.3080505@linaro.org>
Message-ID: <20130719002315.GF27430@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18, John Stultz wrote:
> On 07/18/2013 04:21 PM, Stephen Boyd wrote:
> >This patchset adds support for 64 bit counters in the generic
> >sched_clock code and converts drivers over to use it. Based
> >on v3.11-rc1.
> >
> >Changes since v3:
> >  * Move to use seqcount to fix issues with 64-bit cyc counters
> >  * Move to hrtimer to fix underflow/overflow errors in wraparound
> >    calculation
> >  * Use of 1 hour in clocks_calc_mult_shift
> >  * Converted over drivers in drivers/clocksource
> 
> I've not been able to take a deep review yet, but this looks pretty
> much like what we discussed last week, so I'm happy with it so far.
> Has this gotten much testing (on both 32 and 64bit systems?)

I've tested it on a couple 32 bit systems. I'll ask around for
some 64 bit system testing.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
