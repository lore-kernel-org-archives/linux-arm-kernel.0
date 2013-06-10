From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 10:09:47 +0100
Subject: ARM cacheflush syscall with range that spans multiple vma
In-Reply-To: <20130610085948.GP18614@n2100.arm.linux.org.uk>
References: <51B51844.9050108@bitwagon.com>
 <20130610085948.GP18614@n2100.arm.linux.org.uk>
Message-ID: <20130610090947.GC6580@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 09:59:48AM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 09, 2013 at 05:05:24PM -0700, John Reiser wrote:
> > Why does the ARM cacheflush syscall stop after the lowest vma
> > which intersects the user-requested range?  The range could
> > span more than one vma having contiguous addresses, such as
> > two files MAP_SHARED into adjacent pages; or even a region
> > that contains holes (pages not present.)
> 
> Because you're not supposed to use it on large ranges because it's
> an expensive operation.

I posted some patches to address this recently. Obviously it's still
expensive, but it makes the syscall restartable so that you can't DoS the
system.

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git cacheflush

There's WIP code there for a new iovec-based syscall too.

Will
