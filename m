From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Oct 2012 12:19:06 +0100
Subject: alignment faults in 3.6
In-Reply-To: <20121012110750.GE21164@n2100.arm.linux.org.uk>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com> <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <yw1xhaq0nefg.fsf@unicorn.mansr.com>
 <20121012110750.GE21164@n2100.arm.linux.org.uk>
Message-ID: <20121012111906.GF21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 12:07:50PM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 12, 2012 at 12:00:03PM +0100, M?ns Rullg?rd wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > On Fri, Oct 12, 2012 at 08:11:42AM +0000, Arnd Bergmann wrote:
> > >> On Thursday 11 October 2012, M?ns Rullg?rd wrote:
> > >> > > But, the IP header is expected to be aligned.
> > >> > 
> > >> > Everything tells the compiler the struct is perfectly aligned.  When the
> > >> > buggy driver passes a misaligned pointer, bad things happen.
> > >> 
> > >> Would it be appropriate to add a WARN_ON_ONCE() in the alignment fault path
> > >> then?
> > 
> > I think that's an excellent idea.
> 
> Well, I get the last word here and it's no.
> 
> > >> If all alignment faults in the kernel are caused by broken drivers,
> > >> that would at least give us some hope of finding those drivers while
> > >> at the same time not causing much overhead in the case where we need
> > >> to do the fixup in the meantime.
> > >
> > > No.  It is my understanding that various IP option processing can also
> > > cause the alignment fault handler to be invoked, even when the packet is
> > > properly aligned, and then there's jffs2/mtd which also relies upon
> > > alignment faults being fixed up.
> > 
> > As far as I'm concerned, this is all hearsay, and I've only ever heard
> > it from you.  Why can't you let those who care fix these bugs instead?
> 
> You know, I'm giving you the benefit of my _knowledge_ which has been
> built over the course of the last 20 years.  I've been in these
> discussions with networking people before.  I ended up having to develop
> the alignment fault handler because of those discussions.

Correction: San Mehat at Corel Inc had to develop it, but I was involved
in those discussions over it nevertheless, as I was the person who merged
the code and then subsequently maintained it.
