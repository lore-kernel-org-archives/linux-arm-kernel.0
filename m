From: balbi@ti.com (Felipe Balbi)
Date: Mon, 20 Jul 2015 11:44:08 -0500
Subject: [PATCH] irqchip: omap-intc: improve IRQ handler
In-Reply-To: <alpine.DEB.2.11.1507151435480.18576@nanos>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150119213458.GK18552@atomide.com>
 <20150715064923.GA17550@atomide.com>
 <alpine.DEB.2.11.1507151435480.18576@nanos>
Message-ID: <20150720164408.GB31951@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 02:36:54PM +0200, Thomas Gleixner wrote:
> On Wed, 15 Jul 2015, Tony Lindgren wrote:
> > Felipe,
> > 
> > * Tony Lindgren <tony@atomide.com> [150119 13:41]:
> > > * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > > > as it turns out the current IRQ number will
> > > > *always* be available from SIR register which
> > > > renders the reads of PENDING registers as plain
> > > > unnecessary overhead.
> > > > 
> > > > In order to catch any situation where SIR reads
> > > > as zero, we're adding a WARN() to turn it into
> > > > a very verbose error and users actually report
> > > > it.
> > > > 
> > > > With this patch average running time of
> > > > omap_intc_handle_irq() reduced from about 28.5us
> > > > to 19.8us as measured by the kernel function
> > > > profiler.
> > > > 
> > > > Tested with BeagleBoneBlack Rev A5C.
> > > > 
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > 
> > > Jason, looks like this is not showing up in Linux next. The
> > > same for the changes I did for dm81xx.
> > 
> > Can you please resend this to Jason? Looks like this
> > is still not merged.
> 
> Please send it to me asap and please cc lkml on irqchip patches.

building and testing again. Will resend shortly

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/268ccb9a/attachment.sig>
