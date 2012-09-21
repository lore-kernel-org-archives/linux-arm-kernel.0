From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Sep 2012 19:50:54 +0100
Subject: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
 arm/common
In-Reply-To: <20120921183446.GH16522@beef>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-2-git-send-email-mporter@ti.com>
 <20120921092923.GA31374@n2100.arm.linux.org.uk>
 <1BAFE6F6C881BF42822005164F1491C33EA8AA3C@DBDE01.ent.ti.com>
 <20120921094205.GC31374@n2100.arm.linux.org.uk> <20120921183446.GH16522@beef>
Message-ID: <20120921185054.GE31374@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 02:34:46PM -0400, Matt Porter wrote:
> On Fri, Sep 21, 2012 at 10:42:05AM +0100, Russell King wrote:
> > Here's the pertinant question: "is it platform data?"  Looking at the
> > file, it appears to be internal data structures and register definitions
> > for the driver itself.  Therefore, it isn't platform data, and it
> > shouldn't be living separately from the driver.
> > 
> > If the driver itself only makes use of the data structures, the data
> > structures should be defined either within the driver, or a header file
> > co-located next to the driver itself.  The same goes for register
> > definitions too.
> > 
> > The only structure that I can find which isn't internal to the driver
> > is struct edma_soc_info, struct edma_rsv_info, and the enum dma_event_q.
> > Those can go to include/linux/platform_data, but the rest should not.
> 
> Ok, but is it ok to keep the actual private EDMA API portion in
> arch/arm/include/asm/mach/? It's not a problem to move the internal
> portions to a local include and that pdata to the appropriate place.

Move the platform data parts to include/linux/platform_data.
Move the driver specific parts to be either in the .c file for the
driver, or in a .h file _along_ _side_ the .c file.

Private data for drivers should be kept as close to the driver as
possible, whether that be in the same .c file as the driver itself,
or a header co-located with the .c file.
