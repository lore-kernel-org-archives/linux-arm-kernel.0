From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 25 Feb 2010 16:03:44 +0000
Subject: QUERY: How to call board specific initialization function
	before map_io or timer_init
In-Reply-To: <22dbbef21002250507s12664df5q36e50a8f9e0bc3b9@mail.gmail.com>
References: <22dbbef21002250507s12664df5q36e50a8f9e0bc3b9@mail.gmail.com>
Message-ID: <20100225160344.GG30679@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 06:37:37PM +0530, viresh kumar wrote:
> Hello,
> 
> I need to call my board specific initialization routine before
> timer_init or map_io is called.
> I tried to see that in earlier architectures and found most of
> architecture call machine
> specific init function from map_io or init_irq or init_machine.
> 
> Situation: I need to register my clock framework with
> arch/arm/common/clkdev framework
> before actually initializing timer. So i can't do this in
> "init_machine" as timer_init is called
> before that.

One method would be to use an init call from <linux/init.h> which is
called before these are done (you'll have to work out which one is
suitable for yourself).

Either that or ensure that your boards always call a specific
routine in their init sequence to ensure clocks are registered before
the timer needs them.

If I remeber correctly, map_io() is actually called before the timers
are initialised, so you could add your clocks there.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
