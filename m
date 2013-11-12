From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 13:23:13 -0700
Subject: [PATCH v10 4/7] ARM: tegra: add support for Trusted Foundations
In-Reply-To: <1383819106-1400-5-git-send-email-acourbot@nvidia.com>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
 <1383819106-1400-5-git-send-email-acourbot@nvidia.com>
Message-ID: <52828E31.8010408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 03:11 AM, Alexandre Courbot wrote:
> Register the firmware operations for Trusted Foundations if the device
> tree indicates it is active on the device.

> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c

>  void __init tegra_init_early(void)
>  {
> +	of_register_trusted_foundations();
>  	tegra_cpu_reset_handler_init();
>  	tegra_apb_io_init();
>  	tegra_init_fuse();

Your other bugfix patch for 3.13 moved tegra_cpu_reset_handler_init().
Should the call to of_register_trusted_foundations() move with it when
this is applied, or should it just stay right at the start of
tegra_init_early()? Either way is fine; just let me know which way to
fix up the conflict when this gets applied.
