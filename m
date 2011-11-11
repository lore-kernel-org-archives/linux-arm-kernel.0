From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 11 Nov 2011 14:00:15 -0800
Subject: [PATCH v4 06/10] arm/tegra: prepare pinmux code for multiple
 tegra variants
In-Reply-To: <1321010541-31337-7-git-send-email-pdeschrijver@nvidia.com>
References: <1321010541-31337-1-git-send-email-pdeschrijver@nvidia.com>
 <1321010541-31337-7-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17408058C6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Friday, November 11, 2011 4:22 AM:
> This patch modifies the pinmux code to be useable for multiple tegra variants.
> Some tegra20 specific constants will be replaced by variables which will be
> initialized to the appropriate value at runtime.

> diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c

> +#ifdef CONFIG_OF
> +#include <linux/of_platform.h>
> +#endif

No need to ifdef the include.

> +#ifdef CONFIG_OF
> +	match = of_match_device(tegra_pinmux_of_match, &pdev->dev);
> +#endif

There's already a dummy of_match_device that returns NULL if !CONFIG_OF,
so you can avoid this ifdef. (at least in next-20111111).

-- 
nvpublic
