From: davem@davemloft.net (David Miller)
Date: Mon, 22 Aug 2011 11:47:43 -0700 (PDT)
Subject: of_iomap() matched with plan iounmap()
In-Reply-To: <201108221607.25179.arnd@arndb.de>
References: <201108191426.19152.arnd@arndb.de>
	<20110819.062609.1865751197015675220.davem@davemloft.net>
	<201108221607.25179.arnd@arndb.de>
Message-ID: <20110822.114743.2119393178497975105.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Aug 2011 16:07:25 +0200

> How about renaming the sparc of_ioremap/of_iounmap pair to
> resource_iomap/resource_iounmap? I believe that it is not
> (any more) tied to device tree based probing at all, and also
> could be useful for other subsystems on non-sparc architectures.

Sure, but it would be even nicer if other platforms used pre-computed
resources :-)

It would make OF devices match how PCI devices are managed, and that's
one of the main reasons I implemented it this way.

I know someone is going to say that OF resource resolution is "hard" or
difficult to untangle with how drivers on other platforms work.  But
that situation only exists because other platforms didn't do preresolved
OF resources from the beginning.

Having resource resolution handling and/or knowledge scattered throughout
all of the non-sparc OF drivers is very unwise.
