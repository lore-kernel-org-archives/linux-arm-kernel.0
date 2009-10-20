From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 20 Oct 2009 23:27:55 +0200
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic
In-Reply-To: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
Message-ID: <63386a3d0910201427i1dd8c789i1c9bceeea250d98c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/20 Thomas Gleixner <tglx@linutronix.de>:

> On Sun, 18 Oct 2009, Linus Walleij wrote:
>> This moves the clocksource_set_clock() and clockevent_set_clock()
>> from the MIPS timer code into clockchips and clocksource where
>> it belongs.
> (...)
> Please do not make that functions inline. They are too large and there
> is no benefit of inlining them.

I think there is, because these functions in MIPS if I'm not misreading it, are
used once each in one and one spot only in the clocksource/clockevent
set-up at boot time for each platform in which they are currently used.

Further these spots tend to be __init or even __cpuinit code segments,
so they will be discarded and if we inline the code it will be discarded
after boot as well.

If you foresee that the code will be used in other ways under other
circumstances, I will make them non-inlined of course, but I have a
hard time seeing that.

OK?

Linus Walleij
