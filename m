From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 06 May 2015 11:40:59 +0200
Subject: ARM: EXYNOS: dts: Improvements for 4.2
In-Reply-To: <1430873981-22902-1-git-send-email-k.kozlowski@samsung.com>
References: <1430873981-22902-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5549E1AB.8000400@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/06/2015 02:59 AM, Krzysztof Kozlowski wrote:
> Dear Kukjin,
> 
> I gathered various improvements for upcoming 4.2 merge window.
> Description along with a tag.
> 
> Best regards,
> Krzysztof
> 
> ----------------------------------------------------------------
> The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:
> 
>   Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/krzk/linux.git tags/samsung-dt-for-next-4.2
> 
> for you to fetch changes up to 98155ec454a40212434c83c1388c420a61d62854:
> 
>   ARM: dts: exynos4: add nodes for jpeg codec (2015-05-05 19:19:18 +0900)
> 
> ----------------------------------------------------------------
> Device Tree improvements for Exynos based boards:
> 1. Fix PMIC's RTC alarm on Arndale Octa (S2MPS11 PMIC) and SMDK5250 (MAXIM77686
>    PMIC).
> 2. Fix suspend on Peach Pit Chromebooks prevented by Marvell mwifiex
>    driver.
> 3. Fix hang on Odroid XU3 on MMC card detect.
> 4. Enable the S3C RTC (the clock present on SoC) on various Exynos boards.
> 5. Minor improvements to S3C RTC driver.
> 6. Add nodes for JPEG codec on Exynos4.
> 
> ----------------------------------------------------------------
> Andrzej Hajda (1):
>       ARM: dts: exynos5422-odroidxu3: add mmc detect gpio
> 
> Javier Martinez Canillas (2):
>       ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420

This one is already in your "ARM: EXYNOS: dts: DTS fixes for 4.1" pull
request so it seems is a left over and should not be in this branch?

>       ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards
>

This patch is also rc material IMHO since the mwifiex driver prevents
the system to enter into a suspend state and the driver is enabled in
exynos_defconfig after commit "040464888a1a ("ARM: exynos_defconfig:
Enable Marvell WiFi-Ex support") which landed in v4.1-rc1.

Best regards,
Javier
