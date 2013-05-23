From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 13:50:33 +0100
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
In-Reply-To: <201305231409.02359.arnd@arndb.de>
References: <519DCBEF.3090208@asianux.com> <201305231259.43750.arnd@arndb.de>
 <20130523112401.GO18614@n2100.arm.linux.org.uk>
 <201305231409.02359.arnd@arndb.de>
Message-ID: <20130523125033.GP18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 02:09:02PM +0200, Arnd Bergmann wrote:
> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> > This is the problem you guys are missing - unreachable() means "we lose
> > control of the CPU at this point".
> 
> I'm absolutely aware of this. Again, the current behaviour of doing nothing
> at all isn't very different from undefined behavior when you get when you
> get to the end of a function returning a pointer without a "return" statement,
> or when you return from a function that has determined that it is not safe
> to continue.

Running off the end of a function like that is a different kettle of fish.
The execution path is still as the compiler intends - what isn't is that
the data returned is likely to be random trash.

That's _quite_ different from the CPU starting to execute the contents
of a literal data pool.
