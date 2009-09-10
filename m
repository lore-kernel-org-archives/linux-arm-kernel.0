From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 10 Sep 2009 14:49:42 +0900
Subject: Samsung S3C6410 / SmartQ / 2D acceleration / Xorg
In-Reply-To: <200909021203.n82C3USg020804@chronolytics.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<200909021203.n82C3USg020804@chronolytics.com>
Message-ID: <20090910054942.GB5797@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear David,

> I have a fairly decent SmartQ5/7 config and mach-smartq init file.  Much of
> this work (that I can test) can be back ported to the smdk6410 (that I can't
> test. :-)

So you're hacking on the SmartQ devices?  I recently discovered that they exist and I was
very intrigued in buying one. 

Maybe you can tell me if you or anyone else in the community that is hacking on
those devices have yet figured out 

1) where the testpads/connector for the serial console is
2) where the testpads/connector for the JTAG console is

I've also seen that somebody has been working on an accelerated (EXA) xorg
driver for the 6410, using the samsung-provided 2d driver.  I want to try
that work and play with it, also as a basis to help me to decide what would be
a good way to go ahead for a more standard Linux grephics stack on the 6410 and
related devices.

> I have a "port" to next-s3c of the exiting sansumg-ap-2.6 media drivers.
> They load.  It is a start anyway...  Another downside to these drivers is
> that their memory is statically allocated a boot-time.  I have asked Ben to
> consider taking this "port" into next-s3c as a basis for common work since it
> won't get better until people can work it.

would you mind sharing those drivers or any other work you have in a git tree
that I can have public read access to?

Also, generally speaking, what git tree would you recommend for playing with
the SmartQ devices?

> I am not sure the g2d driver is particular useful for a accel X driver.  The
> fifo mechanism with polling might work better than an ioctl-like interrupt
> blit-only based one.  It seems kinda expensive to trap the the kernel for
> every 2d-op.  Kinda like MSWindows then.  :-)

yes, a regular userspace Xorg EXA driver makes probably much more sense.
If the polling turns out to waste too many cycles, we can still think of some
interrupt-to-userspace delivery mechanism where we don't need to busy-wait
in the Xorg driver.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
