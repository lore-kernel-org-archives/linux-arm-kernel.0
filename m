From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 07 Apr 2015 12:42:52 +0300
Subject: [PATCH 07/14] media: omap3isp: remove unused clkdev
In-Reply-To: <20150405142034.GG4027@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <36620233.VbNiGUfDRt@avalon> <20150405142034.GG4027@n2100.arm.linux.org.uk>
Message-ID: <1894989.AGoQvgsks0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sunday 05 April 2015 15:20:34 Russell King - ARM Linux wrote:
> On Sat, Apr 04, 2015 at 12:44:35AM +0300, Laurent Pinchart wrote:
> > Hi Russell,
> > 
> > Thank you for the patch;
> > 
> > On Friday 03 April 2015 18:12:58 Russell King wrote:
> > > No merged platform supplies xclks via platform data.  As we want to
> > > slightly change the clkdev interface, rather than fixing this unused
> > > code, remove it instead.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > with one caveat though : it conflicts with patches queued for v4.1 in the
> > media tree. I'll post a rebased version in a reply to your e-mail. How
> > would you like to handle the conflict ?
> 
> How bad is the conflict?

It's not too bad, it's mostly a context-related conflict. There are two 
additional lines to remove (plus the associated comment) from isp_xclk_init(), 
as your patch makes a loop now terminate with if (condition) continue;. Those 
two lines could be removed later, keeping them doesn't break anything.

-- 
Regards,

Laurent Pinchart
