From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Nov 2013 09:16:22 +0900
Subject: [PATCH 0/3] ARM: shmobile: Lager reference serial port support
In-Reply-To: <3965826.mx1T873Bg9@avalon>
References: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131031053144.GP1603@verge.net.au> <3965826.mx1T873Bg9@avalon>
Message-ID: <20131101001621.GC6818@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ CC Magnus ]

On Thu, Oct 31, 2013 at 01:21:23PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 31 October 2013 14:31:44 Simon Horman wrote:
> > On Tue, Oct 29, 2013 at 04:23:10PM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set implements serial port support for the Lager reference
> > > board, and adds early debugging support for the r8a7790 SoC.
> > > 
> > > The code is available in my git tree at
> > > 
> > >         git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/serial-lager
> > > 
> > > The branch is based on a merge of renesas-devel-20131016, v3.12-rc7 and
> > > multiarch drivers, clk-prepare, r8a7790 CCF and sh-sci OF patches I've
> > > posted earlier today.
> > > 
> > > Laurent Pinchart (3):
> > >   ARM: shmobile: r8a7790: Add early debugging support
> > 
> > The patch above could be applied now, right?
> 
> That's correct. It will be useless though, as DEBUG_LL can only be used on 
> multiarch.

I will wait, especially in the light of the point you raise below.

> Given that the SCIF/SCIFA/SCIFB port operate similarly, I wonder whether it 
> wouldn't make more sense to add a generic DEBUG_SHMOBILE_SCIF implementation 
> instead. We could then have sub-options to select the exact SoC type and port 
> number, and compute the base address from that.

That makes a lot of sense to me.
Perhaps Magnus has an opinion?

> > If so, Magnus, could you review it?
> > 
> > >   ARM: shmobile: r8a7790: Add serial ports to the device tree
> > >   ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
> > 
> > I would like to ask you to repost these patches once their
> > pre-requisites have been merged.
> 
> Sure, no problem.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
