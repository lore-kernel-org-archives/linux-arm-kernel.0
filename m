From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 10 May 2012 11:41:36 +0100
Subject: Handling of modular boards
In-Reply-To: <20120504220944.GT14230@opensource.wolfsonmicro.com>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
 <20120504203357.6B79B206451@gemini.denx.de>
 <20120504220944.GT14230@opensource.wolfsonmicro.com>
Message-ID: <20120510104136.GA30103@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 11:09:45PM +0100, Mark Brown wrote:
> On Fri, May 04, 2012 at 10:33:57PM +0200, Wolfgang Denk wrote:
> 
> > On the other hand, some of the issues we're trying to solve here
> > for the kernel are also present in the boot loader, so this needs to
> > do this anyway - whether by inserting new or modifying (enabling or
> > disabling) existing properties in the DT is not really relevant here.
> 
> FWIW if the bootloader can usefully handle this stuff I think that's a
> good approach but there is substantial variation in quality of
> implementation between bootloaders and even when the bootloader is a
> good one it's not always practical to update it or the data it relies
> on.

I agree, the list of devices should be in the device-tree handed to
whatever OS is being booted. It isn't a Linux specific problem that
we're looking at here.

Any operating system, pre-OS test suite, etc. is going going to need
this information, and in my view the bootloader should be doing whatever
is needed to create a device-tree to passed through to the next loaded
system.

Also, having the information available to $bootloader means the user
can verify the presence of the peripherals before the OS is loaded.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
