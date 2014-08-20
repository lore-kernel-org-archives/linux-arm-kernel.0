From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Aug 2014 13:50:48 -0600
Subject: [PATCH v3 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
In-Reply-To: <1407320706-17440-5-git-send-email-mperttunen@nvidia.com>
References: <1407320706-17440-1-git-send-email-mperttunen@nvidia.com>
 <1407320706-17440-5-git-send-email-mperttunen@nvidia.com>
Message-ID: <53F4FC18.90804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2014 04:25 AM, Mikko Perttunen wrote:
> This adds support for the Tegra SOCTHERM thermal sensing and management
> system found in the Tegra124 system-on-chip. This initial driver supports
> temperature polling for four thermal zones.

Since both the Tegra DT patches and this driver all rely on a new header 
added by patch 1/4, I guess this whole series needs to be applied in one 
branch. I think it makes sense to apply it to the Tegra since it's 
likely to have more conflicts there and fewer in the thermal 
maintainer's tree. It can be applied in a topic branch that can be 
merged into the thermal maintainer's tree if required to resolve 
conflicts there.

Rui, Eduardo, do you agree?

> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c

> +static struct of_device_id tegra_soctherm_of_match[] = {
> +	{ .compatible = "nvidia,tegra124-soctherm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
> +
> +static int thermctl_temp_offsets[] = {
> +	SENSOR_TEMP1, SENSOR_TEMP2, SENSOR_TEMP1, SENSOR_TEMP2
> +};
> +
> +static int thermctl_temp_shifts[] = {
> +	16, 16, 0, 0
> +};

Can any/all of those be const?

I don't pretend to know anything about the soctherm HW, but I see no 
gross issues in the code structure, so,
Acked-by: Stephen Warren <swarren@nvidia.com>
