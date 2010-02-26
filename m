From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 26 Feb 2010 09:59:26 +0530
Subject: QUERY: How to call board specific initialization function before
	map_io or timer_init
In-Reply-To: <20100225160344.GG30679@trinity.fluff.org>
References: <22dbbef21002250507s12664df5q36e50a8f9e0bc3b9@mail.gmail.com>
	<20100225160344.GG30679@trinity.fluff.org>
Message-ID: <22dbbef21002252029k54236940wf51e599a169e360e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Situation: I need to register my clock framework with
>> arch/arm/common/clkdev framework
>> before actually initializing timer. So i can't do this in
>> "init_machine" as timer_init is called
>> before that.
>
> One method would be to use an init call from <linux/init.h> which is
> called before these are done (you'll have to work out which one is
> suitable for yourself).
>

I tried few of them but timer_init or map_io are getting called before my
routine is called.

> Either that or ensure that your boards always call a specific
> routine in their init sequence to ensure clocks are registered before
> the timer needs them.
>
> If I remeber correctly, map_io() is actually called before the timers
> are initialised, so you could add your clocks there.

I can add my init routine to map_io's implementation, but i think
map_io is not supposed to be implemented that way. map_io should
be called to statically map devices memory. It is not for hardware
specific initializations.

Is my understanding correct?


regards,
viresh kumar
