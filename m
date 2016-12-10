From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 10 Dec 2016 10:21:30 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <20161210091001.GA17896@xo-6d-61-c0.localdomain>
References: <20161206185440.GA4654@yury-N73SV>
 <20161207163210.GB31779@e104818-lin.cambridge.arm.com>
 <DF57E4A6-85C9-44EF-AD03-19EA688D19DB@theobroma-systems.com>
 <12011325.PfzMMUCfyS@wuerfel>
 <20161210091001.GA17896@xo-6d-61-c0.localdomain>
Message-ID: <20161210092130.GA19309@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2016-12-10 10:10:01, Pavel Machek wrote:
> Hi!
> 
> > > Most of these advantages should eventually go away, when struct-reorg makes
> > > it way into the compiler. That said, it?s a marginal (but real) improvement for a
> > > subset of SPEC.
> > > 
> > > In the real world, the importance of ILP32 as an aid to transition legacy code
> > > that is not 64bit clean? and this should drive the ILP32 discussion. That we
> > > get a boost in our SPEC scores is just a nice extra that we get from it 
> > 
> > To bring this back from the philosophical questions of ABI design
> > to the specific point of what file offset width you want for mmap()
> > on 32-bit architectures.
> > 
> > For all I can tell, using mmap() to access a file that is many thousand
> > times larger than your virtual address space is completely crazy.
> 
> Dunno. Wanting to mmap part of a partition does not seem too crazy... I'm pretty
> sure there's some tool out there that uses mmap(), just because mmap() was nicer
> to use then read(). And when the partition is big, the offset may be big.

Actually, if I wrote something like jpegrecover, I'd use mmap() for that (because
otherwise I'd be keeping copy of disk in anonymous memory, increasing memory pressure).

jpegrecover definitely makes sense on partitions...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
