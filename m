From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 22 May 2014 09:58:36 +0530
Subject: [PATCH 3/4] clk: samsung: Add driver to control CLKOUT line on
 Exynos SoCs
In-Reply-To: <1400604211-9447-4-git-send-email-t.figa@samsung.com>
References: <1400604211-9447-1-git-send-email-t.figa@samsung.com>
 <1400604211-9447-4-git-send-email-t.figa@samsung.com>
Message-ID: <537D7CF4.6050305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2014 10:13 PM, Tomasz Figa wrote:
> This patch introduces a driver that handles configuration of CLKOUT pin
> of Exynos SoCs that can be used to output certain clocks from inside of
> the SoC to a dedicated output pin.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/pmu.txt        |  30 ++++
>  drivers/clk/samsung/Makefile                       |   1 +
>  drivers/clk/samsung/clk-exynos-clkout.c            | 153 +++++++++++++++++++++
>  3 files changed, 184 insertions(+)
>  create mode 100644 drivers/clk/samsung/clk-exynos-clkout.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> index b562634..5ed94a9 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -11,8 +11,38 @@ Properties:
>  
>   - reg : offset and length of the register set.
>  
> + - #clock-cells : must be <1>, since PMU requires once cell as clock specifier.

s/once/one

> +		The single specifier cell is used as index to list of clocks
> +		provided by PMU, which is currently:
> +			0 : SoC clock output (CLKOUT pin)

Will it make more sense if we add a macro for this clock number that
would be referred in the device tree files?

> +Example of clock consumer :
> +
> +usb3503: usb3503 at 08 {
> +	/* ... */
> +	clock-names = "refclk";
> +	clocks = <&pmu_system_controller 0>;
> +	/* ... */
>  };

-- 
Tushar Behera
