From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 07 Dec 2016 09:22:48 -0800
Subject: [PATCH v5 3/5] [media] davinci: vpif_capture: fix start/stop
 streaming locking
In-Reply-To: <5753609.tAY8Gxp3ld@avalon> (Laurent Pinchart's message of "Wed,
 07 Dec 2016 16:47:34 +0200")
References: <20161207050826.23174-1-khilman@baylibre.com>
 <20161207050826.23174-4-khilman@baylibre.com>
 <5753609.tAY8Gxp3ld@avalon>
Message-ID: <m2eg1jejrr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:

> Hi Kevin,
>
> Thank you for the patch.
>
> On Tuesday 06 Dec 2016 21:08:24 Kevin Hilman wrote:
>> Video capture subdevs may be over I2C and may sleep during xfer, so we
>> cannot do IRQ-disabled locking when calling the subdev.
>> 
>> The IRQ-disabled locking is meant to protect the DMA queue list
>> throughout the rest of the driver, so update the locking in
>> [start|stop]_streaming to protect just this list.
>> 
>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> I would also add a comment to document the irqlock field as protecting the 
> dma_queue list only. Something like
>
> -	/* Used in video-buf */
> +	/* Protects the dma_queue field */
> 	spinlock_t irqlock;
>
> With that,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

OK, will update the comment.  Thanks for the review,

Kevin
