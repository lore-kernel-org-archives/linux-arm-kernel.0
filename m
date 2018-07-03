From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 3 Jul 2018 17:15:40 +0100
Subject: [PATCH 6/7 v5] bus: fsl-mc: set coherent dma mask for devices on
 fsl-mc bus
In-Reply-To: <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
Message-ID: <79ac0aab-9620-b6ed-f3ee-0553a733a044@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/18 14:49, Nipun Gupta wrote:
> of_dma_configure() API expects coherent_dma_mask to be correctly
> set in the devices. This patch does the needful.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index fa43c7d..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   		mc_dev->icid = parent_mc_dev->icid;
>   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>   		dev_set_msi_domain(&mc_dev->dev,
>   				   dev_get_msi_domain(&parent_mc_dev->dev));
>   	}
> 
