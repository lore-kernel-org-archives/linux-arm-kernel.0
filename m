From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 28 Mar 2015 17:37:05 +0100
Subject: [PATCH] clk: samsung: exynos4: Disable ARMCLK down feature on
 Exynos4210 SoC
In-Reply-To: <1430933.sM2tQimLcT@amdc1032>
References: <1430933.sM2tQimLcT@amdc1032>
Message-ID: <CAJKOXPc_M=rY0aYpE_bhfa6Ku-E09UZ5YXXF3uH9ENTbPJsqMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-27 17:27 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> Commit 42773b28e71d ("clk: samsung: exynos4: Enable ARMCLK
> down feature") enabled ARMCLK down feature on all Exynos4
> SoCs.  Unfortunately on Exynos4210 SoC ARMCLK down feature
> causes a lockup when ondemand cpufreq governor is used.
> Fix it by limiting ARMCLK down feature to Exynos4x12 SoCs.
>
> This patch was tested on:
> - Exynos4210 SoC based Trats board
> - Exynos4210 SoC based Origen board
> - Exynos4412 SoC based Trats2 board
> - Exynos4412 SoC based Odroid-U3 board
>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Fixes: 42773b28e71d ("clk: samsung: exynos4: Enable ARMCLK down feature")
> Cc: <stable@vger.kernel.org> # v3.17+
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
