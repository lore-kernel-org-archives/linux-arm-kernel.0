From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Dec 2012 20:12:06 +0100
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121213175442.GC14619@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111056.58970.arnd@arndb.de> <20121212165833.6a35a6ec@skate>
 <201212131219.39764.arnd@arndb.de>
 <20121213175442.GC14619@obsidianresearch.com>
Message-ID: <20121213201206.69452b8f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 13 Dec 2012 10:54:42 -0700, Jason Gunthorpe wrote:
> On Thu, Dec 13, 2012 at 12:19:39PM +0000, Arnd Bergmann wrote:
>  
> > Do those ten ports have a shared I/O space window, or does each one
> > have its own 64K? 
> 
> The smallest mbus routing window size is 64k, and you need to use a
> mbus routing window per PEX to decode into IO.

Correct.

> Thomas: Note this complicates my earlier suggestion of just using
> config transactions because this is horribly non-conformant, PCIe
> requires a much finer granularity for the root port bridge, it would
> need some kind of specialness to make the standard Linux resource
> allocator work properly.... :|

Hum, not sure to follow you here. What sort of finer granularity does
PCIe requires?

> By far the easiest thing is to keep them as separate PCI busses and
> require DT to manage each one individually, address ranges and
> all. :(

Does that mean that your earlier suggestion of emulating a PCI-to-PCI
bridge in software is no longer your preferred suggestion?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
