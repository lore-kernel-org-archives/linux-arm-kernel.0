From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Mar 2010 13:29:22 -0000
Subject: [Kgdb-bugreport] [PATCH] ARM: change definition of cpu_relax()
	for ARM11MPCore
In-Reply-To: <4B9817CF.2050807@windriver.com>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>	<20100309162202.GB17251@n2100.arm.linux.org.uk>	<000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>	<20100309164926.GC17251@n2100.arm.linux.org.uk>
	<001001cabfb2$4a75d2c0$df617840$@deacon@arm.com>
	<4B9817CF.2050807@windriver.com>
Message-ID: <001601cac11e$dce7f850$96b7e8f0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

> Do you think you can try the patch below?

Sure - I'll give it a go this afternoon.
 
> It seems we might not need to change to using the atomic_add_return(0,...) because using the
> atomic_inc() and atomic_dec() will end up using the memory barriers.

The fix I posted to the LKML here:

http://lkml.org/lkml/2010/3/9/260

fixed the issue for me, but your patch seems more general [although maybe overkill?].

> I would certainly rather fix kgdb vs mucking with the internals of cpu_relax().

I think that's the general consensus. I was worried about changing the general KGDB
code to fix an ARM specific problem, but it turns out that the problem is an issue of
semantics.

I'll let you know whether your patch fixes the problems for me.

Will
