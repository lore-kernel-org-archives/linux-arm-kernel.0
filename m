From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 10 Nov 2014 14:53:29 +0200
Subject: [PATCH] ASoC: davinvi-mcasp: Balance pm_runtime_enable() on probe
 failure
In-Reply-To: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
References: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
Message-ID: <5460B549.40203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2014 02:45 PM, Anil Kumar wrote:
> If probe fails then we need to call pm_runtime_disable() to balance
> out the previous pm_runtime_enable() call.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
> ---
> :100644 100644 0eed9b1... 99c747d... M	sound/soc/davinci/davinci-mcasp.c
>  sound/soc/davinci/davinci-mcasp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 0eed9b1..99c747d 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1235,6 +1235,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (IS_ERR_VALUE(ret)) {
>  		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
>  	}
>  
> 


-- 
P?ter
