From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 05 May 2011 15:55:39 -0400 (EDT)
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <20110505150634.GC19806@kw.sim.vm.gnt>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<20110503205056.GA13075@gentoodev.compulab.local>
	<BANLkTimQM_J2ZbDjAewUsp+XSEP+x+eniA@mail.gmail.com>
	<BANLkTinybLSF418PsocXR6dwuaksv_+UCQ@mail.gmail.com>
	<20110504080924.GX19806@kw.sim.vm.gnt>
	<alpine.LFD.2.00.1105040940410.24613@xanadu.home>
	<20110505150634.GC19806@kw.sim.vm.gnt>
Message-ID: <alpine.LFD.2.00.1105051549430.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 May 2011, Simon Guinot wrote:

> Hi Nicolas,
> 
> On Wed, May 04, 2011 at 09:51:27AM -0400, Nicolas Pitre wrote:
> > On Wed, 4 May 2011, Simon Guinot wrote:
> > 
> > > Hi Hirundo,
> > > 
> > > On Wed, May 04, 2011 at 10:54:52AM +0800, Hirundo Cam wrote:
> > > > Hi Mike and Simon,
> > > > 
> > > > I've send a machine submit to arm-linux, it generated the mach-types as
> > > > 
> > > > [stripped]
> > > > mx51_moray		MACH_MX51_MORAY		MX51_MORAY		3484
> > > > thales_cbc		MACH_THALES_CBC		THALES_CBC		3485
> > > > bluepoint		MACH_BLUEPOINT		BLUEPOINT		3486
> > > > dir665			MACH_DIR665		DIR665			3487
> > > > 
> > > > Is this correct for the DIR665 board using mv88f6281 chips?
> > > 
> > > It looks correct.
> > 
> > It may look correct, but I'll ask that you hang to it for a while as 
> > there is a desire to stop the addition of such board specific files to 
> > the kernel and move towards a solution such as device tree instead to 
> > represent those board details.
> 
> For my curiosity, how a device tree kernel will deal with ATAGs ?

The kernel may use either.  The DTB is meant to supersede ATAGs.

> Is there a compatibility layer planned ?
> 
> I mean... For now, the boards on market are not providing a device tree
> capable bootloader. Without a compatibility layer, the kernel support
> for this boards can't rely on device tree.

There is a patch allowing for you to simply concatenate the appropriate 
DTB data to the kernel zImage.  With this the existing bootloaders can 
be used unchanged.


Nicolas
