From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 23 Apr 2012 20:57:20 +0530
Subject: [RFC 0/8] DMA engine conversion
In-Reply-To: <CAMQu2gyQ3928VQ9Q9Y0mNiacB+br2oGezGCvhLXikbOTi-JR3Q@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <20120423114615.GB25053@n2100.arm.linux.org.uk>
 <CAMQu2gyQ3928VQ9Q9Y0mNiacB+br2oGezGCvhLXikbOTi-JR3Q@mail.gmail.com>
Message-ID: <4F9574D8.1000104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012 06:02 PM, Shilimkar, Santosh wrote:
>> conversion process is fairly straight forward - it's more or less:
>> > 1. add struct dma_chan * pointer to the private structure.
>> > 2. add allocation/freeing functions for the DMA engine channels.
>> > 3. convert the callbacks to match the DMA engine callback prototype.
>> > 4. add code to set the DMA engine channel configuration appropriately
>> >   (avoiding any unnecessary calls) via dmaengine_slave_config().
>> > 5. add code to queue the transfer via dmaengine_prep_slave_sg() and
>> >   dmaengine_submit().
>> > 6. omap_start_dma() becomes dma_async_issue_pending().
>> >
>> >  drivers/spi/spi-omap2-mcspi.c |  186 +++++++++++++++++++++++++++++++++-------
>> >  1 files changed, 153 insertions(+), 33 deletions(-)
> The patch seems to be fine to me.
>
> Am looping Shubro in case he has any comment on "why element sync was used ?"
> and also to test the patch with more peripherals connected over SPI.
>
> Regards
> Santosh
Tested on omap4 ethernet and omap3 touchscreen
also did a spidev test.

Tested-by: Shubhrajyoti <shubhrajyoti at ti.com <mailto:shubhrajyoti@ti.com>>
