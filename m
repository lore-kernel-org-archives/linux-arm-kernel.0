From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 14 May 2010 21:02:54 +0530
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100514152208.GU3428@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100505150209.GC2606@n2100.arm.linux.org.uk>
	<20100513174023.GB13001@n2100.arm.linux.org.uk>
	<20100513211951.GH3428@atomide.com>
	<20100513215825.GC13001@n2100.arm.linux.org.uk>
	<20100513220139.GO3428@atomide.com>
	<20100513221229.GD13001@n2100.arm.linux.org.uk>
	<20100514152208.GU3428@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C558B316@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Friday, May 14, 2010 8:52 PM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; Tomi Valkeinen
> Subject: Re: [RFC] Initial attempt to make ARM use LMB
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 15:07]:
> > On Thu, May 13, 2010 at 03:01:39PM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 14:53]:
> > > > On Thu, May 13, 2010 at 02:19:51PM -0700, Tony Lindgren wrote:
> > > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10:35]:
> > > > > > And here's a patch which converts the OMAP FB code to use lmb_reserve
> > > > > > instead of poking about with bootmem stuff.  Untested, so I'd like to
> > > > > > hear back whether it works.
> > > > >
> > > > > Did a quick test with the following patches picked from your lmb
> > > > > branch on top of omap for-next branch:
> > > > >
> > > > > ARM: Remove useless linux/bootmem.h includes
> > > > > ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
> > > > > ARM: initial LMB trial
> > > > > ARM: Move platform LMB memory reservations out of generic code
> > > > >
> > > > > and then this patch.
> > > > >
> > > > > It does not boot.. It seems to be related to the patch
> > > > > "ARM: initial LMB trial". If I only apply the first two patches
> > > > > above the system boots.
> > > >
> > > > Hmm, I'm sure it worked for me when I tested it out.  Could you try
> > > > booting with lmb=debug please?
> > >
> > > No other output with that it seems.
> >
> > Hang on, you didn't pick up ARM: Move memory mapping into mmu.c ?
> 
> Hmm, looks like I did not send a reply yesterday.. Here's a
> second attempt.
> 
> Yeah, that missing patch was it. Compiles and boots now:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Did you get the frame buffer with lmb ??
