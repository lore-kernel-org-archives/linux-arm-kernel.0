From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 23 Oct 2014 00:06:13 +0300
Subject: [PATCH v3 09/59] dmaengine: Remove the need to declare
 device_control
In-Reply-To: <1413992653-21963-10-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413992653-21963-10-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1564848.hByj3lEMqB@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Wednesday 22 October 2014 17:43:23 Maxime Ripard wrote:
> In order to migrate the drivers without triggering a BUG_ON for the
> converted drivers, which would cause bisectability issues, we need to
> remove that check before removing the device_control function entirely.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/dmaengine.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9b2cd74b8f2e..98e9431f85ec 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -820,8 +820,6 @@ int dma_async_device_register(struct dma_device *device)
> !device->device_prep_dma_sg);
>  	BUG_ON(dma_has_cap(DMA_CYCLIC, device->cap_mask) &&
>  		!device->device_prep_dma_cyclic);
> -	BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
> -		!device->device_control);
>  	BUG_ON(dma_has_cap(DMA_INTERLEAVE, device->cap_mask) &&
>  		!device->device_prep_interleaved_dma);

-- 
Regards,

Laurent Pinchart
