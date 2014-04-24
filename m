From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 24 Apr 2014 18:07:03 +0200
Subject: [PATCH 1/4] ARM: dts: exynos4: add PMU syscon node
In-Reply-To: <1397479700-15864-2-git-send-email-chanho61.park@samsung.com>
References: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
 <1397479700-15864-2-git-send-email-chanho61.park@samsung.com>
Message-ID: <535936A7.9050003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

On 14.04.2014 14:48, Chanho Park wrote:
> This patch adds a PMU(Power Management Unit) syscon node. This
> should be required for USB Phy syscon regmap I/F.
>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kamil Debski <k.debski@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 2f8bcd0..e565b86 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -110,6 +110,11 @@
>   		reg = <0x10010000 0x400>;
>   	};
>
> +	pmu_reg: syscon at 10020000 {
> +		compatible = "samsung,exynos4-pmureg", "syscon";

This compatible string doesn't seem to be defined in [1], please add it 
there,

[1] Documentation/devicetree/bindings/arm/samsung/pmu.txt

Otherwise looks good, so after fixing that you may add my

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
