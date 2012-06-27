From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Jun 2012 20:45 +0200
Subject: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
In-Reply-To: <1854687.1eeiLuW4oH@avalon>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
 <1854687.1eeiLuW4oH@avalon>
Message-ID: <2606265.VPQJMxIymh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 June 2012 20:05:27 Laurent Pinchart wrote:
> On Wednesday 27 June 2012 10:36:04 Paul Walmsley wrote:
> > On Wed, 27 Jun 2012, Laurent Pinchart wrote:
> > > I think you've missed drivers/media/video/omap3isp/isp.c. Should I send
> > > a
> > > patch for that ? Do these changes depend on anything not yet in mainline
> > > that I should apply to my tree for testing ?
> > 
> > What would be ideal is if omap3isp could be converted to runtime PM for
> > its internal IP block control. Almost all of the other OMAP on-chip oC
> > drivers have been converted. Please let us know if more information or
> > assistance is needed with this.
> 
> How does that integrate with the clock framework ?

OK, I think I've found the information. I'll give this a try.

What is still not clear to me is how runtime PM and system PM interact. For 
instance the OMAP3 ISP driver disables its clocks in the system PM suspend 
handler, and restarts them in the system PM resume handler. How do I port that 
to runtime PM, can I just call pm_runtime_put() and pm_runtime_get_sync() in 
the system PM handlers ?

-- 
Regards,

Laurent Pinchart
