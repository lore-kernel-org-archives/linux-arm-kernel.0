From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Dec 2015 20:33:40 +0530
Subject: [PATCH v5 04/11] ARM: STi: STiH407: Provide generic (safe) DVFS
 configuration
In-Reply-To: <1449585124-15596-5-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20151208150340.GI3692@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-12-15, 14:31, Lee Jones wrote:
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 81f8121..9fa1e58 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -22,15 +22,29 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0>;
> +
>  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
>  			cpu-release-addr = <0x94100A4>;
> +
> +					 /* kHz     uV   */
> +			operating-points = <1500000 0
> +					    1200000 0
> +					    800000  0
> +					    500000  0>;
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <1>;
> +
>  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
>  			cpu-release-addr = <0x94100A4>;
> +
> +					 /* kHz     uV   */
> +			operating-points = <1500000 0
> +					    1200000 0
> +					    800000  0
> +					    500000  0>;

Why didn't you move to opp-v2 ?

-- 
viresh
