From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Sep 2013 15:16:24 -0700
Subject: [PATCH V3 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
References: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
 <1380046016-5811-1-git-send-email-abrestic@chromium.org>
Message-ID: <52420F38.6030004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/13 11:06, Andrew Bresticker wrote:
> +static int __init exynos_audss_clk_init(void)
> +{
> +	return platform_driver_register(&exynos_audss_clk_driver);
> +}
> +core_initcall(exynos_audss_clk_init);
> +
> +static void __init exynos_audss_clk_exit(void)

__exit?

> +{
> +	platform_driver_unregister(&exynos_audss_clk_driver);
> +}
> +module_exit(exynos_audss_clk_exit);
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
