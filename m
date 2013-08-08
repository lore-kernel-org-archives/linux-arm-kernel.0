From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 8 Aug 2013 00:32:54 -0700
Subject: [PATCH 03/20] ARM: pxa: ssp: add shortcut for &pdev->dev
In-Reply-To: <1375889649-14638-4-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-4-git-send-email-zonque@gmail.com>
Message-ID: <20130808073253.GA17106@norris.computersforpeace.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:33:52PM +0200, Daniel Mack wrote:
> No functional change, just a cosmetic cleanup.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -77,16 +77,17 @@ static int pxa_ssp_probe(struct platform_device *pdev)
>  	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	struct resource *res;
>  	struct ssp_device *ssp;
> +	struct device *dev = &pdev->dev;
>  	int ret = 0;
>  
>  	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
>  	if (ssp == NULL) {
> -		dev_err(&pdev->dev, "failed to allocate memory");
> +		dev_err(dev, "failed to allocate memory");

Two options here: either remove the message entirely (I believe kzalloc
will complain loudly if the allocation fails) or at least add a newline
at the end of it!

>  		return -ENOMEM;
>  	}
>  	ssp->pdev = pdev;
>  
...

Brian
