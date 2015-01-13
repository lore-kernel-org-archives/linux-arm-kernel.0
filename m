From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Jan 2015 23:05:32 +0530
Subject: [PATCH RESEND] dmaengine: drop owner assignment from
 platform_drivers
In-Reply-To: <1421167621-24786-1-git-send-email-wsa@the-dreams.de>
References: <1421167621-24786-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20150113173532.GA15411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 05:46:48PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.
> 
Applied, thanks

-- 
~Vinod
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/dma/at_xdmac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index b60d77a22df6..1c4c96b7e2bf 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1507,7 +1507,6 @@ static struct platform_driver at_xdmac_driver = {
>  	.remove		= at_xdmac_remove,
>  	.driver = {
>  		.name		= "at_xdmac",
> -		.owner		= THIS_MODULE,
>  		.of_match_table	= of_match_ptr(atmel_xdmac_dt_ids),
>  		.pm		= &atmel_xdmac_dev_pm_ops,
>  	}
> -- 
> 2.1.3
> 

-- 
