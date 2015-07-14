From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 14 Jul 2015 09:48:35 +0900
Subject: [PATCHv6] ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
In-Reply-To: <1436833441-8405-1-git-send-email-parkch98@gmail.com>
References: <1436833441-8405-1-git-send-email-parkch98@gmail.com>
Message-ID: <55A45C63.2030907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.07.2015 09:24, Chanho Park wrote:
> The odroid-xu3 board which is based on exynos5422 not exynos5800 is
> booted from cortex-a7 core unlike exynos5800. The odroid-xu3's cpu order
> is quite strange. cpu0 and cpu5-7 are cortex-a7 cores and cpu1-4 are
> cortex-a15 cores. To correct this mis-odering, I added exynos5422-cpus.dtsi
> and reversing cpu orders from exynos5420. Now, cpu0-3 are cortex-a7 and
> cpu4-7 are cortex-a15.
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanho Park <parkch98@gmail.com>
> ---
> Change from v4:
>  - Resend patch with correct signed-off
> 
> Changes from v4:
>  - Remove temporal patch in e-mail body
> 
> Changes from v3:
>  - include this exynos5422-cpus.dtsi in the exynos5422-odroidxu3-common.dtsi
> 
> Changes from v2:
>  - drop inclusion of exynos5420.dtsi from exynos5422-cpus.dtsi
>  - drop compatibles from exynos5422-cpus.dtsi
> 
> Changes from v1:
>  - rename exynos5422.dtsi to exynos5422-cpus.dtsi
>  - include the dtsi file top of the exynos5422-odroidxu3.dts
> 
> Secondary cpu booting problem[1] is not resolved yet. Need more investigations
> to work booting 8 cores correctly.
> 
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg45525.html
> 
>  arch/arm/boot/dts/exynos5422-cpus.dtsi             | 81 ++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5422-cpus.dtsi

Thanks, applied to my tree. I'll send it to Kukjin for v4.3 unless he
picks it also.

Best regards,
Krzysztof
