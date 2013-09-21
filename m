From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Sep 2013 17:17:28 +0200
Subject: [PATCH 5/6] clk: exynos-audss: add support for Exynos 5420
In-Reply-To: <1379711637-5226-5-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379711637-5226-5-git-send-email-abrestic@chromium.org>
Message-ID: <1407151.hAbz8S9ABE@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Friday 20 of September 2013 14:13:56 Andrew Bresticker wrote:
> The AudioSS block on Exynos 5420 has an additional clock gate for the
> ADMA bus clock.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  Documentation/devicetree/bindings/clock/clk-exynos-audss.txt | 7
> +++++-- drivers/clk/samsung/clk-exynos-audss.c                       |
> 8 ++++++++ include/dt-bindings/clk/exynos-audss-clk.h                  
> | 3 ++- 3 files changed, 15 insertions(+), 3 deletions(-)
[snip]
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +					"samsung,exynos5420-audss-clock")) 
{

I don't really like using such string based conditions in the code, but I 
guess it's just a matter of preference.

I'd introduce an enum to represent supported variants and put them into 
the OF match table or maybe even a struct that would have a bool named 
has_adma_clock, true for Exynos5420 variant.

Best regards,
Tomasz
