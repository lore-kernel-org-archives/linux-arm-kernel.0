From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 9 Jul 2013 09:35:18 -0700
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy
 timer driver
In-Reply-To: <51DC34AD.30009@wwwdotorg.org>
References: <51DAF895.1020700@wwwdotorg.org>
 <20130709005837.GC830@codeaurora.org>
 <51DC34AD.30009@wwwdotorg.org>
Message-ID: <20130709163518.GD830@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09, Stephen Warren wrote:
> On 07/08/2013 06:58 PM, Stephen Boyd wrote:
> > On 07/08, Stephen Warren wrote:
> >> CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
> >> commit 0647065 "clocksource: Add generic dummy timer driver" in
> >> linux-next. Reverting that commit solves the issue.
> > 
> > We found some breakage during boot that has been fixed by two
> > commits in linus' tree already. Do you know if you have these two
> > patches
> > 
> > 1f73a9806bdd07a5106409bbcab3884078bd34fe
> > 07bd1172902e782f288e4d44b1fde7dec0f08b6f
> 
> I didn't before since I was using next-20130705, but I just tried
> next-20130709 which does have those two commits, and I still see the issue.
> 

Ok can you get the output of /proc/timer_list and send it back
please? I assume you have TWD and those should all be in the
per-cpu slots and the broadcast timer should be your tegra specific
timer.

The odd thing is that you're seeing periodic mode for the
broadcast which doesn't make any sense. I would expect oneshot
mode and tick_handle_oneshot_broadcast to be the handler.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
