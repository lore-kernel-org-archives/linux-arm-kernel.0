From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 18 Jan 2018 15:42:43 +0100
Subject: [PATCH -next] dmaengine: stm32-dmamux: Remove unnecessary
 platform_get_resource() error check
In-Reply-To: <1516188430-145326-1-git-send-email-weiyongjun1@huawei.com>
References: <1516188430-145326-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <abcc8970-728f-42c2-3986-44d3de0f8a21@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

On 01/17/2018 12:27 PM, Wei Yongjun wrote:
> devm_ioremap_resource() already checks if the resource is NULL, so
> remove the unnecessary platform_get_resource() error check.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/dma/stm32-dmamux.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
> index d5db0f6..4dbb30c 100644
> --- a/drivers/dma/stm32-dmamux.c
> +++ b/drivers/dma/stm32-dmamux.c
> @@ -253,9 +253,6 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
>  	iomem = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(iomem))
>  		return PTR_ERR(iomem);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
