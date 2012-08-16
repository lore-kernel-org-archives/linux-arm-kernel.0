From: stigge@antcom.de (Roland Stigge)
Date: Thu, 16 Aug 2012 15:13:48 +0200
Subject: [PATCH] dma: amba-pl08x: Export pl08x_filter_id
In-Reply-To: <20120816090041.GK18957@n2100.arm.linux.org.uk>
References: <1345107396-27079-1-git-send-email-stigge@antcom.de>
 <20120816090041.GK18957@n2100.arm.linux.org.uk>
Message-ID: <502CF20C.20801@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2012 11:00 AM, Russell King - ARM Linux wrote:
> On Thu, Aug 16, 2012 at 10:56:36AM +0200, Roland Stigge wrote:
>> This patch fixes the following when compiling a driver module that uses
>> amba-pl08x:
>>
>> ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_slc.ko] undefined!
>> ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_mlc.ko] undefined!
>>
>> (drivers/mtd/nand/lpc32xx_* are still in l2-mtd.git)
> 
> It is currently intended that this be passed from platform code into
> drivers via platform data, so that drivers can decide which DMA engine
> they wish to make use of.
> 
> See how all the AMBA drivers work in this regard (because they need to
> support more than just a single DMA engine implementation.)

Thanks for the note!

I'll post respective changes to the MTD SLC and MLC drivers of LPC32xx
(for the MTD subsystem) and the adjustment I'll do in mach-lpc32xx (my
lpc32xx tree for arm-soc).
