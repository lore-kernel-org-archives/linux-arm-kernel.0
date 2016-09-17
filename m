From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Sat, 17 Sep 2016 23:05:39 +0530
Subject: [RFC PATCH 00/10] ARM: dts: exynos: Fix invalid GIC interrupt
 flags
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <CAGOxZ50WiEVGNKf_1_8DQiKruxY=0813dko18fPfuRqxeyud0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Sat, Sep 17, 2016 at 1:12 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> Marek (internally), Geert and Alban reported errors like:
>         genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
> The patchset fixes this issue.
>
> Tested on:
> 1. Exynos4412: Odroid U3,
> 2. Exynos5410: Odroid XU,
> 3. Exynos5422: Odroid XU3.
>

Tested on Exynos5800 based peach-pi board, so fpr patch 06/10

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>


> Other platforms not tested so testing would be highly appreciated.
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (10):
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4210
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4x12
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4415
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos3250
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5250
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in
>     exynos5410/exynos542x
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5260
>   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5440
>

In general these patches looks good, feel free to add my review-by tag
for this series.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 20 +++++--
>  arch/arm/boot/dts/exynos3250.dtsi         | 93 +++++++++++++++++-------------
>  arch/arm/boot/dts/exynos4.dtsi            | 94 ++++++++++++++++---------------
>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 20 +++++--
>  arch/arm/boot/dts/exynos4210.dtsi         | 36 ++++++++----
>  arch/arm/boot/dts/exynos4415-pinctrl.dtsi | 20 +++++--
>  arch/arm/boot/dts/exynos4415.dtsi         | 92 +++++++++++++++++-------------
>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 20 +++++--
>  arch/arm/boot/dts/exynos4x12.dtsi         | 48 ++++++++++------
>  arch/arm/boot/dts/exynos5.dtsi            | 60 ++++++++++++++------
>  arch/arm/boot/dts/exynos5250.dtsi         | 80 +++++++++++++-------------
>  arch/arm/boot/dts/exynos5260.dtsi         | 39 ++++++++-----
>  arch/arm/boot/dts/exynos5410.dtsi         | 26 ++++-----
>  arch/arm/boot/dts/exynos5420.dtsi         | 78 ++++++++++++-------------
>  arch/arm/boot/dts/exynos5440.dtsi         | 48 ++++++++++------
>  arch/arm/boot/dts/exynos54xx.dtsi         | 34 +++++------
>  16 files changed, 485 insertions(+), 323 deletions(-)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
