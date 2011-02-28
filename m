From: John.Linn@xilinx.com (John Linn)
Date: Mon, 28 Feb 2011 07:22:15 -0700
Subject: [PATCH V4 0/4] ARM: Basic Xilinx Support
In-Reply-To: <20110228111949.GC2754@pulham.picochip.com>
References: <0d410c20-32b4-46d6-9639-249a2816cbe9@VA3EHSMHS005.ehs.local>
	<20110228111949.GC2754@pulham.picochip.com>
Message-ID: <091b12f3-f266-4727-8166-962af92872d3@VA3EHSMHS022.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jamie Iles [mailto:jamie at jamieiles.com]
> Sent: Monday, February 28, 2011 4:20 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org; linux at arm.linux.org.uk;
> catalin.marinas at arm.com; glikely at secretlab.ca; jamie at jamieiles.com;
arnd at arndb.de
> Subject: Re: [PATCH V4 0/4] ARM: Basic Xilinx Support
> 
> On Fri, Feb 18, 2011 at 11:14:37AM -0700, John Linn wrote:
> >
> > V4
> >
> > I incorporated more feedback from Jamie Iles. It was
> > primariy cleanup with the only significant change
> > being a move to using raw_read/write in the uncompressor
> > uart code.
> >
> > The other changes were minor updates so that the patch
> > set applies to linux-next.
> >
> > This patch set is now tested against the linux-next branch
> > from pub/scm/linux/kernel/git/sfr/linux-next.git.
> 
> Hi John,
> 
> I've just tried a quick dummy build of this series (with a fudge in
> mach-types to get it building) and I see a couple of minor sparse
> warnings:
> 
> arch/arm/mach-xilinx/common.c:54:13: warning: symbol
> 'xilinx_system_init' was not declared. Should it be static?
> arch/arm/mach-xilinx/common.c:68:13: warning: symbol 'xilinx_irq_init'
> was not declared. Should it be static?
> arch/arm/mach-xilinx/common.c:110:13: warning: symbol 'xilinx_map_io'
> was not declared. Should it be static?
> arch/arm/mach-xilinx/timer.c:290:18: warning: symbol
'xttcpss_sys_timer'
> was not declared. Should it be static?
> 
> I think all of these can be resolved by including "common.h" in both
> timer.c and common.c.

Will have a look at it.  Easy enough to fix and verify.

> 
> I've put a couple of nitpicks for the individual patches, sorry I
didn't
> spot them before.  Otherwise,

No problem, appreciate your time, patience and input.

Thanks,
John

> 
> Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> 
> Jamie


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
