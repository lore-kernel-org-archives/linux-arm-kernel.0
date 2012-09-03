From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 3 Sep 2012 04:27:14 +0000
Subject: Without MACH_ option Early printk (DEBUG_LL)
In-Reply-To: <alpine.LFD.2.02.1208311422450.1784@xanadu.home>
References: <5040D03B.2050304@ti.com>
 <20120831171336.GA6978@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A83EA9EC8B@DBDE01.ent.ti.com>
 <alpine.LFD.2.02.1208311422450.1784@xanadu.home>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DC099@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 31, 2012 at 23:53:32, Nicolas Pitre wrote:
> On Fri, 31 Aug 2012, Hiremath, Vaibhav wrote:
> > On Fri, Aug 31, 2012 at 22:43:36, Russell King - ARM Linux wrote:
> > > On Fri, Aug 31, 2012 at 08:24:51PM +0530, Vaibhav Hiremath wrote:

> > > > AM335X EVM (based on AM33XX device) only supports DT boot mode and
> > > > doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
> > > > baseport submission we had aligned that, we won't create separate EVM
> > > > options, killing the board file all-together.
> > > > 
> > > > Having said that, the early printk option (DEBUG_LL) is broken, the
> > > > auto-generated file "./include/generated/mach-types.h" still refers to
> > > > CONFIG_MACH_AM335XEVM option,
> > > machine types are entirely meaningless for DT based systems.
> > > 
> > > > Can you comment on this? Based on that I will submit the patch.
> > > 
> > > Pointless.  You can't use machine_is_am335xevm() when you're using DT.
> > > 
> > 
> > They how do you recommend to resolve early prink issue (required during 
> > decompression)?
> 
> Right now the best you can do is to have empty stubs that display 
> nothing.

Won't having compile time selection of debug uart over machine based
runtime detection help here ?

Regards
Afzal
