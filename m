From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 26 Mar 2014 07:12:27 -0300
Subject: [PATCH] ARM: machine_power_off should not return
In-Reply-To: <20140326005115.GW7528@n2100.arm.linux.org.uk>
References: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
 <20140325224554.GC12185@arch.cereza>
 <20140326005115.GW7528@n2100.arm.linux.org.uk>
Message-ID: <20140326101227.GC941@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks for the reply!

On Mar 26, Russell King - ARM Linux wrote:
> On Tue, Mar 25, 2014 at 07:45:55PM -0300, Ezequiel Garcia wrote:
> > 
> > Without this patch we got the heartbeat's reboot_notifier called twice while
> > testing the recent hibernation patches, which was unexpected and produced a
> > kernel panic: https://lkml.org/lkml/2014/3/19/363
> 
> I don't see why we should make this change.  kernel/reboot.c handles
> this function returning, so other places should do too.
> 
> Even on x86, this function can return:
> 
[..]
> 
> Therefore, I'd say... it's a bug in the hibernation code - or we probably
> have many buggy architectures.  I'd suggest fixing the hibernation code
> rather than stuffing some workaround like an endless loop into every
> architecture.
> 

Which is exactly what Sebastian did first:

https://lkml.org/lkml/2014/3/20/605

But Pavel asked to fix ARM's machine_power_off instead.

Also, looking at the other architectures, it seems this API is not well
defined: some of them have an infinite loop, some don't. So it's hard to
say the function is supposed to return or not.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
