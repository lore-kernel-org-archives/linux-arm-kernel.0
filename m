From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 16:55:51 +0000
Subject: Hit BUG_ON in dma-mapping.c:425
In-Reply-To: <4D24A108.2080609@atmel.com>
References: <4D24A108.2080609@atmel.com>
Message-ID: <20110105165551.GE8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 05:49:12PM +0100, Nicolas Ferre wrote:
> Hi,
> 
> While running mtd_stresstest on a dataflash (atmel_spi 
> + mtd_dataflash drivers) I hit the BUG_ON directive that 
> is at the beginning of ___dma_single_cpu_to_dev() function.
> This function is called from the SPI driver that do a 
> dma_map_single() before DMA operations on the buffer 
> transmitted from upper layers.
> 
> It seems that this address is above "high_memory" limit because 
> it is allocated by vmalloc (in mtd_stresstest.c:285)...

Well, its telling you is that you're not allowed to DMA to vmalloc
addresses.  Whether that's the fault of the map driver or not is a
question for mtd folk.
