From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 00:29:43 +0100
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1109261901550.2718@xanadu.home>
References: <alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261514330.2718@xanadu.home>
	<alpine.LFD.2.00.1109261606210.2718@xanadu.home>
	<20110926223839.GB23680@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261901550.2718@xanadu.home>
Message-ID: <20110926232943.GD23680@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 07:03:12PM -0400, Nicolas Pitre wrote:
> On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> 
> > On Mon, Sep 26, 2011 at 04:10:03PM -0400, Nicolas Pitre wrote:
> > > On Mon, 26 Sep 2011, Nicolas Pitre wrote:
> > > 
> > > > On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> > > > 
> > > > > This also gives additional merge conflicts elsewhere, and while git
> > > > > rerere makes some of them easy, the quantity is going to be a right
> > > > > pain to deal with on a repeated basis.
> > > > 
> > > > Again, I'm perfectly willing to use a different base for this series and 
> > > > fix the conflicts myself if you give me one.
> > > 
> > > Nevermind, I see that you merged it anyway.
> > > 
> > > You may consider the rerere.autoupdate config option if you want Git to 
> > > automatically pick the conflict resolution without you manually 
> > > confirming them all the time.
> > 
> > rerere doesn't deal with modified/deleted conflicts though.
> 
> True.  That can be considered a limitation worth fixing.

Well.  Now I'm not impressed, having investigated the reason behind
some of these conflicts.

The reason I'm getting the modify/delete conflict is because you've
made the same change to arch/arm/mach-prima2/include/mach/memory.h
as the one which you already submitted to me.

commit e922fe6625fb4700f041e5984ba6c09a1cadae65
Author:     Nicolas Pitre <nicolas.pitre@linaro.org>
AuthorDate: Wed Sep 21 20:52:40 2011 +0100
Commit:     Russell King <rmk+kernel@arm.linux.org.uk>
CommitDate: Mon Sep 26 12:31:09 2011 +0100

    ARM: 7093/1: mach-prima2: move ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
    
    The branch that contained the ARM_DMA_ZONE_SIZE removal missed prima2.
    
    Original comment:
    
      Restrict DMA-able region to workaround silicon limitation.
      The limitation restricts buffers available for DMA to SD/MMC
      hardware to be below 256MB.
    
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

vs

commit 98b0124f0e2b88ec74cbd9345cf6195e527ce251
Author:     Nicolas Pitre <nicolas.pitre@linaro.org>
AuthorDate: Fri Sep 2 21:05:10 2011 -0400
Commit:     Nicolas Pitre <nico@fluxnic.net>
CommitDate: Tue Sep 6 17:25:54 2011 -0400

    ARM: mach-prima2: move ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
    
    Original comment:
    
      Restrict DMA-able region to workaround silicon limitation.
      The limitation restricts buffers available for DMA to SD/MMC
      hardware to be below 256MB.
    
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

I've no idea why you submitted this change to me if you'd already merged
it into your own tree - this is total madness and is just making more
work for me with no reason.

A little more discipline and communication (such as asking me to drop
the duplicate commit _first_) would be nice.
