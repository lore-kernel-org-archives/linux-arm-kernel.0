From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 Mar 2012 12:45:56 +0100
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Message-ID: <4F5F3374.8000506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 11:33 PM, Russell King - ARM Linux :
> [v2 - more or less same description.  Including lakml in cc for the full
> set]
> 
> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:
> 
> - moving the 'last completed cookie' into struct dma_chan - everyone
>   has this in their driver private channel data structure
> 
> - consolidate allocation of cookies to DMA descriptors
> 
> - common way to update 'last completed cookie' value
> 
> - standard way to implement tx_status callback and update the residue
> 
> - consolidate initialization of cookies
> 
> - update implementations differing from the majority of DMA engine drivers
>   to behave the same as the majority implementation in respect of cookies
> 
> What this means is that we get to the point where all DMA engine drivers
> will hand out cookie value '2' as the first, and incrementing cookie
> values up to INT_MAX, returning to cookie '1' as the next cookie.
> 
> Think of this patch series as round 1...  I am hoping over time that more
> code can be consolidated between the DMA engine drivers and end up with a
> consistent way to handle various common themes in DMA engine hardware
> (like physical channel<->peripheral request signal selection.)
> 
> Overall, the diffstat looks like this:
> 
>  arch/arm/include/asm/hardware/iop_adma.h |    2 -
>  drivers/dma/amba-pl08x.c                 |   38 ++++---------
>  drivers/dma/at_hdmac.c                   |   48 ++++------------
>  drivers/dma/at_hdmac_regs.h              |    2 -

For at_hdmac Atmel DMA driver:

Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks a lot Russell.

Best regards,
-- 
Nicolas Ferre
