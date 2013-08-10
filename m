From: mark.rutland@arm.com (Mark Rutland)
Date: Sat, 10 Aug 2013 15:13:43 +0100
Subject: [PATCH 1/2] ARM: dts: AM4372: cpu(s) node per latest binding
In-Reply-To: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
Message-ID: <20130810141342.GD18085@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 02:46:13PM +0100, Afzal Mohammed wrote:
> Update AM4372 cpu node to the latest cpus/cpu bindings for ARM.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index ddc1df7..4635e7f 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -22,8 +22,12 @@
>  	};
>  
>  	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		cpu at 0 {
>  			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			reg = <0>;
>  		};
>  	};
>  

This looks sane to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>
