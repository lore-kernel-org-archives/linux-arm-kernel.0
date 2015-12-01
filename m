From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Dec 2015 09:24:46 -0800
Subject: [RFC PATCH] clocksource: ti-32k: convert to platform device
In-Reply-To: <565DD4FA.3000308@ti.com>
References: <1448040129-23869-1-git-send-email-grygorii.strashko@ti.com>
 <87h9kgcz1k.fsf@saruman.tx.rr.com> <5658B8B2.5030505@ti.com>
 <20151130162815.GA2517@atomide.com> <565DB7F7.4020702@ti.com>
 <20151201160707.GQ23396@atomide.com> <565DD4FA.3000308@ti.com>
Message-ID: <20151201172445.GV23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151201 09:13]:
> On 12/01/2015 06:07 PM, Tony Lindgren wrote:
> >
> >Or am I forgetting some other dependency with our system timers?
> 
> both counter32 and GP timer have to be enabled through sysc registers.
> They are in "Force idle" state after reset.

That's fine, those are within the timer address space. I'd rather
leave out the hwmod dependency from the system timers at the cost
of a system timer specific minimal init function.

Regards,

Tony
