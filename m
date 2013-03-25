From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Mon, 25 Mar 2013 16:45:47 +0530
Subject: [PATCH v8 10/14] ARM: tegra: Define Tegra114 CAR binding
In-Reply-To: <1363956029-31873-11-git-send-email-pdeschrijver@nvidia.com>
References: <1363956029-31873-1-git-send-email-pdeschrijver@nvidia.com>
 <1363956029-31873-11-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <515031E3.40007@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013 06:09 PM, Peter De Schrijver wrote:
> The device tree binding models Tegra114 CAR (Clock And Reset) as a single
> monolithic clock provider.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---

<snip>

> +  263	cclk_lp
> +  264	dfll_ref
> +  265	dfll_soc
> +

Peter,

Please remove following clock IDs from binding.

> +Mux clocks
> +
> +  300	audio0_mux
> +  301	audio1_mux
> +  302	audio2_mux
> +  303	audio3_mux
> +  304	audio4_mux
> +  305	spdif_mux
> +  306	clk_out_1_mux
> +  307	clk_out_2_mux
> +  308	clk_out_3_mux
> +  309	dsia_mux
> +  310	dsib_mux
> +
> +Example SoC include file:
> +
> +/ {
> +	tegra_car: clock {
> +		compatible = "nvidia,tegra114-car";
> +		reg = <0x60006000 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	usb at c5004000 {
> +		clocks = <&tegra_car 58>; /* usb2 */
> +	};
> +};
> +
> +Example board file:
> +
> +/ {
> +	clocks {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		osc: clock at 0 {
> +			compatible = "fixed-clock";
> +			reg = <0>;
> +			#clock-cells = <0>;
> +			clock-frequency = <12000000>;
> +		};
> +
> +		clk_32k: clock at 1 {
> +			compatible = "fixed-clock";
> +			reg = <1>;
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +	};
> +
> +	&tegra_car {
> +		clocks = <&clk_32k> <&osc>;
> +	};
> +};
