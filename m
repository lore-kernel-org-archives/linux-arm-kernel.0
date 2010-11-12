From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 12 Nov 2010 11:37:45 +0100
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <alpine.LFD.2.00.1011121130350.2900@localhost6.localdomain6>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
	<20101112095739.GH18358@pengutronix.de>
	<4CDD120A.2050401@stericsson.com>
	<alpine.LFD.2.00.1011121130350.2900@localhost6.localdomain6>
Message-ID: <4CDD18F9.5090005@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> On Fri, 12 Nov 2010, Linus Walleij wrote:
>> Uwe Kleine-K?nig wrote:
>>
>>> Instead of implementing sched_clock for each architecture seperatly,
>>> wouldn't it be nice to have a generic sched_clock that uses the
>>> architecture's clocksource?  I tried to implement that some time ago,
>>> but tglx shoot it down because of locking problems.
>> I was and still am a big fan of this approach, I am willing to help
>> testing it if you want to dust off this patch set...
> 
> sched_clock is not necessarily the same as the current clocksource.

IIRC Uwe:s approach was that if and only if you would want to use
the clocksource for sched_clock() you provide a special flag on
the clocksource, and it will be attempted to be used for sched_clock().

Incidentally the dual use of a single free-running timer as both
single clocksource and sched_clock() baseline seem to creep up in
a lot of embedded platforms...

Yours,
Linus Walleij
