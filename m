From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 07:46:40 +0200
Subject: [PATCH 0/3] making rtc cores from s3c6410 and exynos3250 both work
In-Reply-To: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
Message-ID: <578332C0.4010601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2016 11:23 AM, Randy Li wrote:
> The 8792f7772f4f40ffc68bad5f28311205584b734d would just make those
> platform using rtc core from exynos3250 work but have a huge 
> effect on those platforms using the rtc core from s3c6410.
> These patches would fix this problem.
> 

Which problem? What huge effect? On which platforms? You didn't describe
it...

Your change breaks the ABI and is not compatible with current bindings
documentation.

Best regards,
Krzysztof

> Randy Li (3):
>   Revert "drivers/rtc/rtc-s3c.c: add .needs_src_clk to s3c6410 RTC data"
>   rtc: s3c: add device data for samsung,exynos3250-rtc
>   ARM: dts: exynos: correct the rtc compatible value for exynos5
> 
>  arch/arm/boot/dts/exynos3250.dtsi |  2 +-
>  arch/arm/boot/dts/exynos5.dtsi    |  2 +-
>  drivers/rtc/rtc-s3c.c             | 15 +++++++++++++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
