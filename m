From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Feb 2015 14:24:51 -0800
Subject: [PATCH] ARM: EXYNOS: Don't use LDREX and STREX after disabling
 cache coherency
In-Reply-To: <1424093802-5488-1-git-send-email-k.kozlowski@samsung.com>
References: <1424093802-5488-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54E3BFB3.5030801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/15 05:36, Krzysztof Kozlowski wrote:
> During CPU shutdown the exynos_cpu_power_down() is called after
> disabling cache coherency and it uses LDREX and STREX instructions (by
> calling of_machine_is_compatible() -> kobject_get() -> kref_get()).
>
> The LDREX and STREX should not be used after disabling the cache
> coherency so just use soc_is_exynos().
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: adc548d77c22 ("ARM: EXYNOS: Use MCPM call-backs to support S2R on exynos5420")
> Cc: <stable@vger.kernel.org>
> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Looks good to me.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
