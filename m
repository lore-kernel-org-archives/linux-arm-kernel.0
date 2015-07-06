From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 06 Jul 2015 08:13:28 +0200
Subject: [PATCH 16/41] clocksource: pxa: Migrate to new 'set-state'
 interface
In-Reply-To: <20150705033719.GC7510@linux> (Viresh Kumar's message of "Sun, 5
 Jul 2015 09:07:19 +0530")
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <cover.1434622147.git.viresh.kumar@linaro.org>
 <3aa5c1a740911258698769cbbb8f60ee02178848.1434622147.git.viresh.kumar@linaro.org>
 <87h9pk9bfe.fsf@belgarion.home> <20150705033719.GC7510@linux>
Message-ID: <878uatak53.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Hi Robert,
>
> On 04-07-15, 17:42, Robert Jarzmik wrote:
>> > +	/* initializing, released, or preparing for suspend */
>> > +	timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
>> > +	timer_writel(OSSR_M0, OSSR);
>> > +	return 0;
>> For consistency, please leave an empty line before that return statement.
>
> Its already applied by Daniel now, and the change is too trivial to
> request for an update to his tree. Maybe we should leave it as is for
> now.
If it's applied it's indeed too late.

>> > +	.set_state_shutdown	= pxa_osmr0_shutdown,
>> > +	.set_state_oneshot	= pxa_osmr0_shutdown,
>> A bit weird to have a "set_state_oneshot" function to point to a function called
>> "X_shutdown".
>
> What's weird (or looks weird) is that we stop the timer when requested
> to switch to oneshot mode. But that's what we really wanted, because
> set_next_event is the one that will program the timer in oneshot mode.
Ok, thanks for the explanation.

Cheers.

-- 
Robert
