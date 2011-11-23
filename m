From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 23 Nov 2011 07:58:08 +0100
Subject: [PATCH 07/17] ASoC: Tegra DAS: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-8-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-8-git-send-email-swarren@nvidia.com>
Message-ID: <20111123065808.GB5255@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> module_platform_drive saves some boiler-plate code.
> 
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/tegra/tegra_das.c |   45 +++++++++---------------------------------
>  1 files changed, 10 insertions(+), 35 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_das.c b/sound/soc/tegra/tegra_das.c
[...]
> @@ -208,32 +208,18 @@ static int __devinit tegra_das_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -err_release:
> -	release_mem_region(res->start, resource_size(res));
> -err_free:
> -	kfree(das);
> +err:
>  	das = NULL;
> -exit:
>  	return ret;
>  }
>  
>  static int __devexit tegra_das_remove(struct platform_device *pdev)
>  {
> -	struct resource *res;
> -
>  	if (!das)
>  		return -ENODEV;
>  
> -	platform_set_drvdata(pdev, NULL);
> -
[...]

Setting the driver data to NULL may still be a good idea.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/36c981fe/attachment.sig>
