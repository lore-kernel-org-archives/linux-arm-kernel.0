From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 00:12:24 +0100
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627224017.GU23102@port70.net>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627224017.GU23102@port70.net>
Message-ID: <20140627231224.GY32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 12:40:17AM +0200, Szabolcs Nagy wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [2014-06-27 23:17:44 +0100]:
> > I think you're are missing one obvious solution to this which you can do:
> > you are passed the HWCAP fields in the ELF auxinfo.  This will tell you
> > if the CPU has TLS support or not.  If it has TLS support, then you don't
> > need to use the kuser helpers, and you know that it is a CPU which is ARM
> > architecture v6k or later, and it has things like the CP15 barrier
> > instructions.  If you want to know that the CPU supports the DMB
> > instruction rather than the CP15 barrier instruction, then you have to
> > check the uname details, or read /proc/cpuinfo (but I'd rather you
> > didn't.)
> > 
> 
> but cp15 barrier is deprecated on armv7+

Can you _please_ read all my replies and stop cherry picking what you
want?  There's many of you, and only one of me - please do me the
effort of fully reading my replies before replying on points I've
already included.

I said just after you stopped reading the above quoted text:

"If you want to know that the CPU supports the DMB instruction rather
 than the CP15 barrier instruction, then you have to check the uname
 details"

That's because it's an _instruction_ _set_ _architecture_ issue, and
you can get that from uname.  If uname indicates v7, then you're running
on a CPU which has deprecated the CP15 barrier operations.  If it
indicates v6, then you're running on a CPU which has them but has no
DMB instruction etc.  If it's earlier than v6, you have no barrier
instructions what so ever.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
