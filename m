From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 22 Jan 2017 01:38:07 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <20170122170523.3b4b1235@xhacker>
References: <1485072424.14066.2.camel@crowfest.net>
 <9647813.NZ2c5cYUSH@localhost>	<1485075528.14345.1.camel@crowfest.net>
 <20170122170523.3b4b1235@xhacker>
Message-ID: <1485077887.1308.2.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-01-22 at 17:05 +0800, Jisheng Zhang wrote:
> On Sun, 22 Jan 2017 00:58:48 -0800 Michael Zoran wrote:
> 
> > On Sun, 2017-01-22 at 09:52 +0100, Alexander Stein wrote:
> > > Hi Michael,
> > > 
> > > On Sunday, January 22, 2017, 12:07:04 AM CET Michael Zoran
> > > wrote:??
> > > > I'm not sure if this if the correct place to be asking
> > > > this.???The
> > > > RPI
> > > > 3 running ARM64 is slowly reaching the point of being about to
> > > > seriously run a 32 bit vender OS like Raspbian.??When running
> > > > Raspbian,
> > > > I'm seeing a very large number(thousands) of kernel log
> > > > messages
> > > > about
> > > > deprecated instructions especially setend and barrier
> > > > instuctions.
> > > > This can be very annoying and is completely filling the kernel
> > > > log.
> > > > 
> > > > I'm considering submitting a patch to add a Kconfig option to
> > > > disable
> > > > these warnings with the default being to keep the warnings
> > > > enabled.??I
> > > > was wondering if such a patch could be seriously considered.??
> > > 
> > > Could you please provide an example of those warning an what is
> > > trigging?
> > > those?
> > > 
> > > Thanks and best regards,
> > > Alexander??
> > 
> > Sure, here is a snipped from dmesg.??I think this is happening
> > because
> > the entire Raspbian OS is compiled with a custom gcc compiler that
> > is
> > targeting arm6+VFP.
> 
> IMHO, this is the root cause. I didn't see below warnings from dmesg
> with
> armhf debian and ubuntu If the underlying HW is armv8 compatible, it
> doesn't make sense to target the compiler to armv6
> 
> 

Advanced users can install a different OS. Beginners can't and will
need a single OS image for simple install.

Does anybody know if these instructions are detected at runtime?  I'm
also looking into an issue with Mathmatica due to broken OS detection. 
It appears that arm64 is currently missing some of the CPU spoofing
that happens on other architectures...

 
