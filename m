From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 06 Jun 2015 14:57:37 +0200
Subject: [PATCH v2 4/4] VFIO: platform: Calxeda xgmac reset module
In-Reply-To: <1433516792-16397-5-git-send-email-eric.auger@linaro.org>
References: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>
 <1433516792-16397-5-git-send-email-eric.auger@linaro.org>
Message-ID: <1433595457.10861.77.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-05 at 17:06 +0200, Eric Auger wrote:
> --- /dev/null
> +++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c

> +static int __init vfio_platform_calxedaxgmac_init(void)
> +{
> +	return 0;
> +}
> +
> +static void __exit vfio_platform_calxedaxgmac_exit(void)
> +{
> +}
> +
> +module_init(vfio_platform_calxedaxgmac_init);
> +module_exit(vfio_platform_calxedaxgmac_exit);

Just a nit: I think it's OK to leave out these functions if they both do
nothing. See delete_module in kernel/module.c.


Paul Bolle
