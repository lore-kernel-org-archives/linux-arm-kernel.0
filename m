From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2011 16:07:25 +0200
Subject: of_iomap() matched with plan iounmap()
In-Reply-To: <20110819.062609.1865751197015675220.davem@davemloft.net>
References: <20110818170226.GA16721@huya.qualcomm.com>
	<201108191426.19152.arnd@arndb.de>
	<20110819.062609.1865751197015675220.davem@davemloft.net>
Message-ID: <201108221607.25179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 August 2011, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 19 Aug 2011 14:26:18 +0200
> 
> > We could of course change all existing users of of_iounmap on sparc to use
> > the simpler prototype, because it also just calls iounmap.
> 
> Check again, on sparc64 it needs the resource to release it.
> 
> Only the 32-bit version on sparc evaluates to just a plain iounmap().

Ok, I see.

On Friday 19 August 2011, David Brown wrote:
> What if we left the SPARC calls alone, and changed of_iomap() into
> of_dt_iomap() and could then make of_dt_iounmap().  Or, it could just
> be of_dt_map(), and of_dt_unmap().

I think at some point in the future, we will have a mass-renaming
of of_* to dt_* or similar, which would result in a silly name.

Also, the of_iomap() name is modeled after pci_iomap/pci_iomap.

How about renaming the sparc of_ioremap/of_iounmap pair to
resource_iomap/resource_iounmap? I believe that it is not
(any more) tied to device tree based probing at all, and also
could be useful for other subsystems on non-sparc architectures.

	Arnd
