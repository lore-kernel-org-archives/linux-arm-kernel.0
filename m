From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 10 Mar 2011 11:41:37 +0000
Subject: [PATCH 2/8] macb: detect hclk presence from platform data
In-Reply-To: <20110310101554.GD11273@n2100.arm.linux.org.uk>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-3-git-send-email-jamie@jamieiles.com>
	<20110310101554.GD11273@n2100.arm.linux.org.uk>
Message-ID: <20110310114137.GC6198@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 10:15:54AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 10, 2011 at 10:10:37AM +0000, Jamie Iles wrote:
> > Rather than detecting whether we need to do a clk_get() and enable on
> > the "hclk" based on the kernel configuration, add an extra field to the
> > platform data.  This makes it cleaner to add more supported
> > architectures without lots of ifdeffery.
> 
> Why not have the platform provide a dummy hclk if no real hclk exists?

Yes, that would be much better.  In that case, this patch can be 
replaced with the two below.  I'll repost the series with the other 
patches refreshed, but I'd like someone with AT91 knowledge to check 
that at91_clock_associate() is doing what I think it is first.

This also means that the driver doesn't need a conditional on ARCH_AT91 
for the pclk name.

Jamie
