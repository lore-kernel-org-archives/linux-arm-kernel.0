From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 26 Jul 2018 21:20:25 +0530
Subject: [PATCH v7 5/5] arm64: dts: actions: Set UART clock reference
 from CMU
In-Reply-To: <20180719090649.12460-6-sravanhome@gmail.com>
References: <20180719090649.12460-1-sravanhome@gmail.com>
 <20180719090649.12460-6-sravanhome@gmail.com>
Message-ID: <20180726155025.GA5220@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Thu, Jul 19, 2018 at 11:06:49AM +0200, Saravanan Sekar wrote:
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Will you be queuing up the dts patches through actions tree?

Thanks,
Mani

>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index ef79d7905f44..c08808ca3346 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -28,12 +28,6 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
>  	};
> -
> -	uart3_clk: uart3-clk {
> -		compatible = "fixed-clock";
> -		clock-frequency = <921600>;
> -		#clock-cells = <0>;
> -	};
>  };
>  
>  &timer {
> @@ -42,5 +36,5 @@
>  
>  &uart3 {
>  	status = "okay";
> -	clocks = <&uart3_clk>;
> +	clocks = <&cmu CLK_UART3>;
>  };
> -- 
> 2.14.4
> 
