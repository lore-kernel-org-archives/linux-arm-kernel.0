From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Mon, 4 Jan 2010 17:36:17 +0200
Subject: [RFC PATCH 2/2] ARM: VFP: preserve the HW context when calling
	signal handlers
In-Reply-To: <20090613170406.GA6926@n2100.arm.linux.org.uk>
References: <c70d85c1a0b20b5f227f34b32db674c7b362d72d.1242734510.git.imre.deak@nokia.com>
	<20090613164035.GE16220@shareable.org>
	<20090613170406.GA6926@n2100.arm.linux.org.uk>
Message-ID: <201001041736.17862.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 June 2009 20:04:06 ext Russell King - ARM Linux wrote:
> On Sat, Jun 13, 2009 at 05:40:35PM +0100, Jamie Lokier wrote:
> > Russell King - ARM Linux wrote:
> > > It seems that people do want access to these registers in signal
> > > handlers, yet there's still the original set of patches from Imre
> > > in the patch system.
> > >
> > > I'm been holding off applying them because of this open question.
> > >
> > > What am I to do with them?  Are people happy with the existing
> > > patches?
> > >
> > > (note that without the patch system, I'd have completely forgotten
> > > about those two patches and so would not be sending this chase-up.)
> >
> > The main thing is that all the machine state which affects user-space
> > which is saved on entering a signal handler, and restored on leaving
> > it, is accessible somehow through the arguments to the signal handler.
>
> I agree that we need something.  However, there seemed to be some kind of
> agreement in this thread that having access to these other registers from
> signal handlers would be a good thing.
>
> So, what I'm asking is, do I:
>
> - merge the current two patches in the patch system, and then at a later
>   date have to change the layout when someone wants access to these other
>   registers, thereby causing an ABI visible change with all the problems
>   that goes with that
>
> or
>
> - wait for a new patch which includes these other registers and not have
>   any ABI visible changes to contend with

Sorry for bumping this old thread, but what is the current status of these
patches?

This bug shows up as image corruption (typically it looks like short
horizontal stripes all over the screen) when using NEON optimized pixman
library and scrolling pages in firefox for example.

X server uses signal handlers for processing input, and they corrupt content
of NEON registers which are heavily used by pixman to process pixel data.

The problem has been already encountered by the maintainers of several
linux distributions (angstrom, ubuntu).

-- 
Best regards,
Siarhei Siamashka
