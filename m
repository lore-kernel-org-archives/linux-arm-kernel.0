From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 3 Jul 2015 15:19:40 +0200 (CEST)
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703105441.GF1521@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
Message-ID: <alpine.DEB.2.11.1507031511180.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jul 2015, Wolfram Sang wrote:
> Hi Simon,
> 
> > I have observed what appears to be a regression while testing next-20150702
> > which seems to be caused by 2951d5c031a3 ("tick: broadcast: Prevent
> > livelock from event handler").
> 
> Does reverting help? I see a similar case with your branch
> renesas-devel-20150629-v4.1 which does not include both commits.

This branch has actually none of the clockevent/tick related changes
which are in next/linus tree. So 2951d5c031a3 is hardly the culprit.

> For this branch, if I select CONFIG_NO_HZ_IDLE and *no* CONFIG_HIGH_RES_TIMERS,

So with high res timers it boots. Can you please provide the output of
/proc/timer_list for that case?

Thanks,

	tglx
