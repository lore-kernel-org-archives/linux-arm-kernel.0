From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 22 Jan 2015 13:25:07 +0100
Subject: [alsa-devel] [PATCH v3 3/4] ARM: dts: set clock out parent to
 XUSBXTI
In-Reply-To: <1421925482-15861-4-git-send-email-ideal.song@samsung.com>
References: <1421925482-15861-1-git-send-email-ideal.song@samsung.com>
 <1421925482-15861-4-git-send-email-ideal.song@samsung.com>
Message-ID: <54C0EC23.9070209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/15 12:18, Inha Song wrote:
> This patch set clock out parent to XUSBXTI.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index b8168f1..020bbaf 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -141,6 +141,8 @@
>  	pmu_system_controller: system-controller at 10020000 {
>  		compatible = "samsung,exynos4210-pmu", "syscon";
>  		reg = <0x10020000 0x4000>;
> +		assigned-clocks = <&pmu_system_controller 0>;
> +		assigned-clock-parents =  <&clock CLK_XUSBXTI>;
>  	};

Looks good, except it needs to be done only for the Trats2 board, i.e.
the PMU device node including these properties should be added to
exynos4412-trats2.dts.  I think it's fine to make it a one patch including
all dts changes.


-- 
Regards,
Sylwester
