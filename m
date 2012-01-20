From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 12:24:02 +0000
Subject: Making allyesconfig work
In-Reply-To: <20120120120856.GC30612@arm.com>
References: <20120120115108.GJ1068@n2100.arm.linux.org.uk>
 <20120120120856.GC30612@arm.com>
Message-ID: <20120120122402.GN1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 12:08:56PM +0000, Catalin Marinas wrote:
> On Fri, Jan 20, 2012 at 11:51:08AM +0000, Russell King - ARM Linux wrote:
> > There's also the troublesome T() macro, which conflicts with a bunch
> > of other drivers.  (I've added Catalin to the To: line for this
> > reason.)
> 
> This macro is used in asm/uaccess.h and asm/futex.h, so I think it would
> be difficult to hide it completely. But I'm happy to rename it to
> something else (IIRC, T stands for "Translated").

We should do something, because T() is just too risky for causing these
kinds of conflicts.  We're not going to be able to get the driver code
changed for this.  People will rightfully object - and it was something
originally spotted by Al Viro in November... allegedly rude works were
muttered (not publically) over it!
