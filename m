From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 16 Apr 2018 20:14:24 +0200
Subject: [PATCH v3 2/2] arm64: dts: exynos: Move syscon poweroff and
 restart nodes under the PMU
In-Reply-To: <20180416181126.15629-2-krzk@kernel.org>
References: <20180416181126.15629-1-krzk@kernel.org>
 <20180416181126.15629-2-krzk@kernel.org>
Message-ID: <20180416181424.chmge5fxd6mecvww@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 08:11:26PM +0200, Krzysztof Kozlowski wrote:
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
>     arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (simple_bus_reg):
>         Node /soc/syscon-reboot missing or empty reg/ranges property
> 
> but this warnings are gone in v4.17-rc1 since 9130ba884640
> ("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987")
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
>  arch/arm64/boot/dts/exynos/exynos7.dtsi    | 12 ++++++------
>  2 files changed, 13 insertions(+), 13 deletions(-)

I forgot to include Marek's tested-by tag (given previously):
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards,
Krzysztof
