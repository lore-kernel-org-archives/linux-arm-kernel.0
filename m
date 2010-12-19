From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 19 Dec 2010 23:23:02 +0100
Subject: [PATCH 0/13] 64-bit sched_clock
In-Reply-To: <20101216130411.GR9937@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
	<20101216130411.GR9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik0zkpUUvrv8YmxGd_=vMaKR42KbJnd4BqHqias@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> I can provide an init_early() method in the machine description which
> setup_arch() can call as the last thing it does - this will happen
> after the ->reserve and ->map_io callbacks, but before interrupts and
> timers have been setup. ?This is the ideal time to setup the
> sched_clock(). ?However, that means digging through lots of arch code
> to sort out what can be moved where, and that's going to be inherently
> unreliable.
>
> I think init_early() has merit in other ways - it'll allow us to remove
> crap from the ->map_io callbacks which is doing stuff like registering
> clk structures and so forth.

I agree. I was contemplating a clock_init() or similar a way back
for setting up clock trees early. We would have to move clock tree
registration in front of the init_sched_clock() call in the init_early()
handler in many cases since the rate often comes from the clock
framework, but this is indeed where it belongs.

So a clear ACK for this approach.

Yours,
Linus Walleij
