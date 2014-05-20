From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 13:17:17 +0100
Subject: [PATCH v6 3/4] ARM: dts: Add STiH407 SoC support
In-Reply-To: <1400579192-17620-4-git-send-email-maxime.coquelin@st.com>
References: <1400579192-17620-1-git-send-email-maxime.coquelin@st.com>
 <1400579192-17620-4-git-send-email-maxime.coquelin@st.com>
Message-ID: <20140520121717.GL24991@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The STiH407 is advanced multi-HD AVC processor with 3D graphics acceleration
> and 1.5-GHz ARM Cortex-A9 SMP CPU.
> 
> Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/stih407-clock.dtsi   |  40 +++
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 615 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/stih407.dtsi         | 263 ++++++++++++++
>  3 files changed, 918 insertions(+)
>  create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
>  create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/stih407.dtsi
> 
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> new file mode 100644
> index 0000000..ae8068c
> --- /dev/null
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (C) 2014 STMicroelectronics R&D Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/ {
> +	clocks {
> +		/*
> +		 * Fixed 30MHz oscillator inputs to SoC
> +		 */
> +		CLK_SYSIN: CLK_SYSIN {

I thought we weren't using upper case clk names anymore?

> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <30000000>;
> +			clock-output-names = "CLK_SYSIN";
> +		};
> +
> +		/*
> +		 * ARM Peripheral clock for timers
> +		 */
> +		arm_periph_clk: arm_periph_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <600000000>;
> +		};
> +
> +		/*
> +		 * Bootloader initialized system infrastructure clock for
> +		 * serial devices.
> +		 */
> +		CLK_EXT2F_A9: clockgenC0 at 13 {

Or camel? 

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
