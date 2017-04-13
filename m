From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 15:20:06 -0500
Subject: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
References: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Message-ID: <20170413202006.k4qs3rttftzrcb43@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 02:51:35PM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> V2:
> - Added more *-by tags.
> - Included TI DT and example files as well.
> 
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 20 +++----
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
>  Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
>  arch/arm/boot/dts/am4372.dtsi                      | 10 ++--
>  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
>  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
>  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
>  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
>  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
>  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
>  arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
>  arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  8 +--
>  arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
>  arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
>  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
>  arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
>  20 files changed, 295 insertions(+), 295 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
