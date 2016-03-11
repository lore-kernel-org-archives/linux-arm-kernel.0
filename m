From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 11 Mar 2016 10:45:52 +0100
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160311062607.GP11154@localhost>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160309120627.67612b1d@bbrezillon>
 <20160311062607.GP11154@localhost>
Message-ID: <20160311104552.23e06a16@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Mar 2016 11:56:07 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Wed, Mar 09, 2016 at 12:06:27PM +0100, Boris Brezillon wrote:
> > On Tue, 8 Mar 2016 08:25:47 +0530
> > Vinod Koul <vinod.koul@intel.com> wrote:
> > > 
> > > Why does dmaengine need to wait? Can you explain that
> > 
> > I don't have an answer for that one, but when I set WAIT_CYCLES to 1
> > for the NAND use case it does not work. So I guess it is somehow
> > related to how the DRQ line is controlled on the device side...
> 
> Is the WAIT cycle different for different usages or same for all
> usages/channels?
> 

In Allwinner BSP they adapt it on a per slave device basis, but since
DMA channels are dynamically allocated, you can't know in advance which
physical channel will be attached to a specific device.

Another option I considered was adding a new cell to the sun4i DT
binding to encode these WAIT_CYCLES and BLOCK_SIZE information. But I'm
not sure adding that to the DT is a good idea (not to mention that it
would break DT ABI again, and given the last discussions on this topic,
I'm not sure it's a good idea :-/).


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
