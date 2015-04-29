From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Wed, 29 Apr 2015 14:54:43 +0000 (UTC)
Subject: [OT] Profiling on ARM Linux systems: how?
Message-ID: <mhqrbj$vlu$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This might be a little off-topic. If so I apologize.

I have a problem with excessive CPU usage on an embedded ARM926
system.  There are three main apps, all of which have multiple
threads. The total CPU usage is too high.  I'm trying to figure out
where the CPU time is "going" so we know were to concentrate
optimization efforts.

The "top" utility is useless because it samples at a fixed interval.
Almost all of the threads are driven by timers on fixed cycles (or
data from threads that are). The 'top' sampling method appears to
cause aliasing which renders the numbers shown by top meaningless.

I have written a small "idle" app that I can run with the least
possible priority to get a pretty decent measure of total combined CPU
usage by everything else.  By starting and stopping pieces and
measuring the change in total CPU usage, we get some moderately usable
numbers, but stopping piece A also changes the load on piece B and
piece C, so it's not very accurate.

That method also doesn't let us understand which threads within an
application are using the most CPU time.

It would be helpful if I could just get a reliable measurement of
system vs. user CPU usage.

We've tried and failed to get oprofile working for our platform (at91
running 2.6.33).  If I was confident that oprofile could provide
useful information, I would put some more effort into getting it
running.

I have been able to get systemtap working on our platform and can
trace kernel-space events, but my understanding is that systemtap
doesn't support analysis of user-space processes on ARM.

Any advice?

-- 
Grant Edwards               grant.b.edwards        Yow! Life is a POPULARITY
                                  at               CONTEST!  I'm REFRESHINGLY
                              gmail.com            CANDID!!
