From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 16 Apr 2018 20:13:53 +0200
Subject: [PATCH v3 1/2] ARM: dts: exynos: Move syscon poweroff and
 restart nodes under the PMU
In-Reply-To: <20180416181126.15629-1-krzk@kernel.org>
References: <20180416181126.15629-1-krzk@kernel.org>
Message-ID: <20180416181353.hqk76z3gagextyph@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 08:11:25PM +0200, Krzysztof Kozlowski wrote:
> The PMU node is the actual block responsible for power management,
> including typical Exynos on/off/restart procedures.  Therefore the
> syscon poweroff and restart nodes logically belong to it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Previously was "Fix missing missing reg warning for syscon restart
> nodes" to fix DTC warnings like:
> 
>     arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
>         Node /soc/syscon-poweroff missing or empty reg/ranges property
>     arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
>         Node /soc/syscon-reboot missing or empty reg/ranges property
> 
> but this warnings are gone in v4.17-rc1 since 9130ba884640
> ("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987")
> ---
>  arch/arm/boot/dts/exynos-syscon-restart.dtsi | 28 ++++++++++++----------------
>  arch/arm/boot/dts/exynos3250.dtsi            |  2 +-
>  arch/arm/boot/dts/exynos4.dtsi               |  3 ++-
>  arch/arm/boot/dts/exynos5.dtsi               |  1 -
>  arch/arm/boot/dts/exynos5250.dtsi            |  1 +
>  arch/arm/boot/dts/exynos5410.dtsi            |  1 +
>  arch/arm/boot/dts/exynos5420.dtsi            |  1 +
>  7 files changed, 18 insertions(+), 19 deletions(-)

I forgot to include Marek's tested-by tag (given previously):
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards,
Krzysztof
