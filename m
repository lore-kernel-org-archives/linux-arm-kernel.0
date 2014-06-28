From: nsz@port70.net (Szabolcs Nagy)
Date: Sat, 28 Jun 2014 18:37:36 +0200
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627231224.GY32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627224017.GU23102@port70.net>
 <20140627231224.GY32514@n2100.arm.linux.org.uk>
Message-ID: <20140628163734.GV23102@port70.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [2014-06-28 00:12:24 +0100]:
> On Sat, Jun 28, 2014 at 12:40:17AM +0200, Szabolcs Nagy wrote:
> > but cp15 barrier is deprecated on armv7+
> 
> Can you _please_ read all my replies and stop cherry picking what you
> want?  There's many of you, and only one of me - please do me the
> effort of fully reading my replies before replying on points I've
> already included.

I've read it, we knew about uname, /proc and the TLS HWCAP flag,
and i thought it's clear that uname is inappropriate for determining
isa features because we don't know the arm naming scheme used in the
future..

so the situation is

- dmb vs cp15 dispatch needs extra uname syscall and fragile string
parsing at program startup

- there is no reasonable way to determine kuser page availability
on armv6k+ if pax kernel needs to be supported (asking the system
integrator or using process_vm_readv are not reasonable)

- there is no reasonable way to determine if the system is smp and
needs barriers (parsing /proc/cpuinfo is not reasonable)
