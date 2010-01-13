From: imre.deak@nokia.com (Imre Deak)
Date: Wed, 13 Jan 2010 18:01:42 +0200
Subject: [RFC PATCH 2/2] ARM: VFP: preserve the HW context when
	callingsignal handlers
In-Reply-To: <1263397782.32612.56.camel@pc1117.cambridge.arm.com>
References: <c70d85c1a0b20b5f227f34b32db674c7b362d72d.1242734510.git.imre.deak@nokia.com>
	<201001041615.26490.siarhei.siamashka@nokia.com>
	<20100104142549.GF9107@n2100.arm.linux.org.uk>
	<201001041718.55150.siarhei.siamashka@nokia.com>
	<20100106174759.GB28921@localhost>
	<1263397782.32612.56.camel@pc1117.cambridge.arm.com>
Message-ID: <20100113160142.GB11726@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 04:49:42PM +0100, ext Catalin Marinas wrote:
> On Wed, 2010-01-06 at 17:47 +0000, Imre Deak wrote:
> > On Mon, Jan 04, 2010 at 04:18:54PM +0100, Siamashka Siarhei (Nokia-D/Helsinki) wrote:
> > > On Monday 04 January 2010 16:25:49 ext Russell King - ARM Linux wrote:
> > > > On Mon, Jan 04, 2010 at 04:15:26PM +0200, Siarhei Siamashka wrote:
> > > > > On Saturday 13 June 2009 20:04:06 ext Russell King - ARM Linux wrote:
> > > > > > - wait for a new patch which includes these other registers and not
> > > > > > have any ABI visible changes to contend with
> > > > >
> > > > > Sorry for bumping this old thread, but what is the current status of
> > > > > these patches?
> > > >
> > > > What happened was that the 2nd option was decided upon, and then the
> > > > thread died, and probably everyone forgot about it.
> > > >
> > > > So, I'm doing exactly what I said I'd do in the second option.  I'm just
> > > > still waiting some six months on...
> > >
> > > OK, it's understandable. The issue just got a bit more popular now than it
> > > used to be six months ago.
> > >
> > > > If someone comes up with a tested patch, then its something we should
> > > > sort out.
> > >
> > > Thanks for clarifying the situation.
> > 
> > Jamie, you raised the question of FP emulation in user space; could you
> > provide the VFP registers needed for that in addition to the already saved
> > ones? With that info I could update the patch so it's acceptable for everyone.
> 
> I think you need to save all of FPSCR, FPEXC, FPINST, FPINST2. The
> information in the latter 2 registers is only relevant if corresponding
> bits in FPEXC are set (like EX and FP2V). A signal handler could decide
> whether to use them or not.

Thanks for the info, I'll try to update my patches based on this.

--Imre
