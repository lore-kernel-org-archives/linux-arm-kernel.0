From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 05 May 2014 19:26:12 +0200
Subject: [PATCH 1/6] dmaengine: Add fly-by transfer flag to slave
 configuration structure
In-Reply-To: <1397574817-15559-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1397574817-15559-2-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <5367C9B4.9010805@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 05:13 PM, Laurent Pinchart wrote:
> Fly-by transfer mode cuts down the number of bus transactions by letting
> the slave drive or latch the memory data bus during memory transactions
> instead of performing a dedicated transaction to read data from or write
> data to the slave.
>
> Support for fly-by mode by adding a new flag field to struct
> dma_slave_config.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>   include/linux/dmaengine.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c5c92d5..ae99153 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -304,6 +304,17 @@ enum dma_slave_buswidth {
>   };
>
>   /**
> + * enum dma_slave_flags - DMA slave configuration flags
> + * @DMA_SLAVE_FLAG_FLY_BY - perform DMA transfers for the slave in fly-by mode.
> + *   Instead of performing a bus transaction to read (write) data from (to) the
> + *   slave, let the slave drive (latch) the memory bus data signals during the
> + *   memory write (read) transaction.
> + */

Is there any reason not to use fly-by mode for memory to peripheral or 
peripheral to memory transfers, if fly-by mode is available? And if not how 
should generic drivers using the DMAengine API decide when to use fly-by mode 
and when not?

- Lars
