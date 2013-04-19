From: k.debski@samsung.com (Kamil Debski)
Date: Fri, 19 Apr 2013 10:44:29 +0200
Subject: [PATCH -next] [media] s5p-mfc: fix error return code in
 s5p_mfc_probe()
In-Reply-To: <CAPgLHd_TwmtoaE7T7e3fRKh4NTGhOYjQZv0G7nt-iSVMLz3XEQ@mail.gmail.com>
References: <CAPgLHd_TwmtoaE7T7e3fRKh4NTGhOYjQZv0G7nt-iSVMLz3XEQ@mail.gmail.com>
Message-ID: <015501ce3cda$1cdfa900$569efb00$%debski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

Thank you for your patch.

Best wishes,
Kamil Debski

> From: Wei Yongjun [mailto:weiyj.lk at gmail.com]
> Sent: Thursday, April 18, 2013 5:18 AM
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling case
> instead of 0, as returned elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Kamil Debski <k.debski@samsung.com>

> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index e810b1a..a5853fa 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -1110,7 +1110,8 @@ static int s5p_mfc_probe(struct platform_device
> *pdev)
>  	}
> 
>  	if (pdev->dev.of_node) {
> -		if (s5p_mfc_alloc_memdevs(dev) < 0)
> +		ret = s5p_mfc_alloc_memdevs(dev);
> +		if (ret < 0)
>  			goto err_res;
>  	} else {
>  		dev->mem_dev_l = device_find_child(&dev->plat_dev->dev,
