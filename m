From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 03 Jul 2015 15:45:41 +0100
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703143703.GB19284@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana> <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana> <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
Message-ID: <5596A015.1030709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/15 15:37, Wolfram Sang wrote:
>
>> So this is a single core machine and uses the em_sti timer w/o the
>> broadcast nonsense. In Simons case it looks like em_sti is used as
>> broadcast device.
>
> We use the same board. Just my kernel has SMP=n.
>

If it's UP build, then GENERIC_CLOCKEVENTS_BROADCAST is disabled. You
may be hitting the issue I reported[1] and is still under discussion.

Regards,
Sudeep

[1] https://lkml.org/lkml/2015/6/25/271
