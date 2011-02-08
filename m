From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 8 Feb 2011 13:23:58 +0530
Subject: [PATCH v1] davinci: spi: move event queue parameter to platform
	data
In-Reply-To: <1296828552-11765-1-git-send-email-michael.williamson@criticallink.com>
References: <1296828552-11765-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302488B9AFA@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 19:39:12, Michael Williamson wrote:
> For DMA operation, the davinci spi driver needs an event queue number.
> Currently, this number is passed as a IORESOURCE_DMA.  This is not
> correct, as the event queue is not a DMA channel.  Pass the event queue
> via the platform data structure instead.
> 
> On dm355 and dm365, move the eventq assignment for spi0 out of resources
> array and into platform data.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

Tested this on DM355 and DM365 EVMs. Event queue numbers show up
properly in the logs and DMA transfers to on-board SPI EEPROMs
happen correctly.

> ---
> Changes since v0:
>   - combined separate platform patches with driver patch to avoid
>     potential regression if doing a bissect.
>   - fixed up typo per comments.

This typo doesn't seem fixed?

> + * @dma_event_q: DMA event_q to use if SPI_IO_TYPE_DMA is used for any device
> + *		on the bus.

On 2/4/2011 7:03 AM, Sergei Shtylyov wrote:
>> + * @dma_event_q: DMA event_q to use if SPI_IO_TYPE_DMA is used for any device
> 
>    s/event_q/event queue/?

Can you please re-spin with this fixed and my ack included:

Acked-by: Sekhar Nori <nsekhar@ti.com>

With Grant's ack this should probably get merged through
DaVinci tree (since it touches mach-davinci).

Thanks,
Sekhar
