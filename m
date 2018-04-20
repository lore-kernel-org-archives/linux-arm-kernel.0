From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Fri, 20 Apr 2018 10:06:46 +0200
Subject: [PATCH 61/61] ASoC: atmel: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-62-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-62-wsa+renesas@sang-engineering.com>
Message-ID: <23044c16-efbf-7920-2a25-338ad46376eb@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/2018 at 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>   sound/soc/atmel/atmel_ssc_dai.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a1e2c5682dcd..4a0275a6505d 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -1002,8 +1002,7 @@ static const struct snd_soc_component_driver atmel_ssc_component = {
>   
>   static int asoc_ssc_init(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ssc_device *ssc = platform_get_drvdata(pdev);
> +	struct ssc_device *ssc = dev_get_drvdata(dev);
>   	int ret;
>   
>   	ret = snd_soc_register_component(dev, &atmel_ssc_component,
> @@ -1033,8 +1032,7 @@ static int asoc_ssc_init(struct device *dev)
>   
>   static void asoc_ssc_exit(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ssc_device *ssc = platform_get_drvdata(pdev);
> +	struct ssc_device *ssc = dev_get_drvdata(dev);
>   
>   	if (ssc->pdata->use_dma)
>   		atmel_pcm_dma_platform_unregister(dev);
> 


-- 
Nicolas Ferre
