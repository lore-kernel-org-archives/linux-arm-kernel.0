From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 17:25:57 +0000
Subject: Status of the following patch (clocksource sched_clock) ?
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
Message-ID: <20111219172557.GH14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 05:21:58PM +0000, Karicheri, Muralidharan wrote:
> I am running into a clocksource wrap around issue due to which
> sched_clock() returned value is wrapped around at clocksource
> timeout rate. I see this issue is addressed in 
> http://www.spinics.net/lists/arm-kernel/msg122716.html

Your interpretation of that patch is wrong.  The patch you refer to is
consolidating what's already there.

> Could someone tell me what is the status of this patch? I want to try
> it on my target platform which is a davinci variant. 

Dead.

Just make sure you use the sched_clock infrastructure already provided
on ARM and provided you give it the correct information - and set it up
early enough (in init_early) you will not have any sched_clock() wraps.
This is because a timer will be set to automatically update things
before any wrap occurs.
