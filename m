From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 16 Mar 2015 19:27:30 +0100
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
Message-ID: <55072092.9040207@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 12/03/2015 19:31, Russell King wrote:
> Add the PMU description to the Dove DT file.  The PMU provides multiple
> features, including an interrupt, reset, power and isolation controller.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/dts/dove.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index a5441d5482a6..43d4ebf414be 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -380,6 +380,15 @@
>  				status = "disabled";
>  			};
>  
> +			pmu: power-management at d0000 {
> +				compatible = "marvell,dove-pmu";
> +				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;

Here you overlap some other nodes such as the thermal one (from 0xd001c to 0xd0028),
the clock gate one (from 0xd0038 to 0xd003c), the gpio one, the pinctrl one ...

Could you be more specific?

Thanks,

Gregory

> +				interrupts = <33>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				#reset-cells = <1>;
> +			};
> +
>  			thermal: thermal-diode at d001c {
>  				compatible = "marvell,dove-thermal";
>  				reg = <0xd001c 0x0c>, <0xd005c 0x08>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
