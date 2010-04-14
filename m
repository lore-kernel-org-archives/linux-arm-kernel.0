From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 14 Apr 2010 17:34:22 +1000
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100409111105.GA2804@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100408153111.GA2598@debian>
	<20100408182715.GF31407@n2100.arm.linux.org.uk>
	<20100409111105.GA2804@n2100.arm.linux.org.uk>
Message-ID: <1271230462.13059.142.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-04-09 at 12:11 +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 08, 2010 at 07:27:15PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 08, 2010 at 09:02:56PM +0530, Rabin Vincent wrote:
> > > On Thu, Mar 25, 2010 at 11:32:48PM +0000, Russell King - ARM Linux wrote:
> > > > The patch below is the combined patch; individual patches can be found
> > > > in the arm:lmb patches on the website or the lmb branch of my git tree;
> > > > this should be considered unstable.
> > > 
> > > Something like the following is needed to make initrds work after this
> > > patch:
> > 
> > This to me looks like a very large patch for what is a small problem -
> > that is the assignment of initrd_start/initrd_size got lost along the
> > way.
> > 
> > I'd much rather have the smaller patch; keep the initrd parameters in
> > the physical address space for as long as possible, and only convert
> > them to the virtual address space once we've finished mm initialisation.
> 
> Here's a revised version which should resolve the initrd problem.

BTW. I'm doing some cleanup of lmb, you can take a peek at my WIP in
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git branch
"lmb".

It shouldn't break your stuff, though you will probably need to add a
call to lmb_set_current_limit() in the right place instead of setting
LMB_REAL_LIMIT to lowmem_end_addr.

Anyway, it's still WIP, but feel free to comment, and if there's
something else you want me to do, cleanup or change in the core LMB, let
me know.

Cheers,
Ben.
