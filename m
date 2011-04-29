From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 30 Apr 2011 08:37:17 +1000
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104292029.50680.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<20110429075958.GV17290@n2100.arm.linux.org.uk>
	<20110429093209.1926c732@jbarnes-desktop>
	<201104292029.50680.arnd@arndb.de>
Message-ID: <1304116637.2513.252.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-29 at 20:29 +0200, Arnd Bergmann wrote:
> 
> If that is the case, we can probably work around this by turning the
> entire
> linear mapping (except for the kernel binary) into nonexecutable mode,
> if we don't do that already.
> This is desirable for security purposes anyway 

You'd still have an "edge" problem if you use large pages for the linear
mapping, you can't obviously make part of the kernel text NX and you'd
have to make sure you 'exclude' from those GPU allocations whatever
overlaps with your last executable large page.

In a way, it's a similar problem I have with bolted memory on BookE
where I can't restrict GPU allocations to memory that isn't bolted :-)

Cheers,
Ben.
