From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 11:45:52 -0600
Subject: [PATCH v3] ARM: tegra: expose chip ID and revision
In-Reply-To: <1363168080-12697-1-git-send-email-dahuang@nvidia.com>
References: <1363168080-12697-1-git-send-email-dahuang@nvidia.com>
Message-ID: <5140BB50.8080004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 03:48 AM, Danny Huang wrote:
> Expose Tegra chip ID and revision in /sys/devices/soc for user mode
> usage

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

>  static void __init tegra_dt_init(void)
>  {
> +	struct device *parent = NULL;
> +	struct soc_device *soc_dev;
> +	struct soc_device_attribute *soc_dev_attr;

Since Russell asked you to redo the patch anyway, I'd prefer that
variables be declared in the order they're used. So, soc_dev_attr, then
soc_dev, then parent.
