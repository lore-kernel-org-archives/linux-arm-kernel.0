From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 8 Jun 2011 16:23:31 +0800
Subject: [PATCH,RFC] mmp clockevent handling race
In-Reply-To: <20110608070114.GG11275@wantstofly.org>
References: <20110607140456.GE11275@wantstofly.org>
	<alpine.LFD.2.00.1106071416230.2142@xanadu.home>
	<1307499937.8890.2.camel@Lily>
	<BANLkTi=MhX97=pXTFfJfO8=E=2Q98YdC6A@mail.gmail.com>
	<20110608070114.GG11275@wantstofly.org>
Message-ID: <BANLkTikLFXb=xBnVbs-d_SvfFF8RMABnPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The diff indeed looks somewhat confusing -- it makes more sense if
> you look at the final thing (below).
>
>
>> Using two timers isn't a bad idea. Yet if it has to disable timer0 when
>> modifying timer1's next triggering event, it doesn't seem to solve the
>> real problem with two timers.
>
> This isn't needed -- timer A can keep running as clocksource timer while
> timer B is used as a clockevent timer and stopped and restarted all the
> time. ?(In my version, timer 0 is used as clockevent timer and timer 1
> as clocksource timer, but this can be done either way 'round of course.)

My only concern at first is the disabling of the counter, and since it's not
going to affect the clock source counter, it's completely fine to me.

>
> If there's consensus that this is the right way to go, I'll split the
> patch up into logical bits.
>

There's apparently no better way to handle this. And BTW - is it really
necessary to introduce FEAT_PERIODIC, esp. when NO_HZ is enabled.
There is some overhead of ONESHOT, not really sure how much that is.
Would it be better to split the changes into two, one for the fix using
two timers, and one to add PERIODIC?
