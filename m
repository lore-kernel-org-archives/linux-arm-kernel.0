From: drake@endlessm.com (Daniel Drake)
Date: Mon, 21 Jul 2014 13:51:59 +0100
Subject: [PATCH v2 1/2] clk: samsung: exynos4: Enable ARMCLK down feature
In-Reply-To: <1405694193-29643-1-git-send-email-k.kozlowski@samsung.com>
References: <1405694193-29643-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAD8Lp45UtZ_aao2ScUUjRq9AfnxGq9GuT24SLzY-koeBfTTDCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 3:36 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Enable ARMCLK down feature on all Exynos4 SoCs. The frequency of
> ARMCLK will be reduced upon entering idle mode (WFI or WFE).
>
> The feature behaves like very fast cpufreq ondemand governor. In idle
> mode this reduces energy consumption on full frequency chosen by
> cpufreq governor by approximately:
>  - Trats2:  6.5% (153 mA -> 143 mA)
>  - Trats:  33.0% (180 mA -> 120 mA)
>  - Gear1:  27.0% (180 mA -> 130 mA)
>
> The patch uses simillar settings as Exynos5250 (clk-exynos5250.c),
> except it disables clock up feature and on Exynos4412 ARMCLK down is
> enabled for all 4 cores.
>
> Tested on Trats board (Exynos4210), Trats2 board (Exynos4412) and
> Samsung Gear 1 (Exynos4212).
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested on ODROID-U2, seems to be working. I don't have a way of
measuring the power usage, but the system seems as stable as before.

Tested-by: Daniel Drake <drake@endlessm.com>
