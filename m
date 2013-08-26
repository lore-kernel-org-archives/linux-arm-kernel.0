From: bcousson@baylibre.com (Benoit Cousson)
Date: Mon, 26 Aug 2013 10:36:16 +0200
Subject: [PATCH v2] ARM: dts: add AM33XX EDMA support
In-Reply-To: <1377505784-9820-1-git-send-email-bigeasy@linutronix.de>
References: <1377505784-9820-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <521B1380.3030908@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- minus all the TI emails which are not working anymore :-(

I've just sent my previous email too soon...

Now the patch is different :-) I'll take that one.

Thanks,
Benoit


On 26/08/2013 10:29, Sebastian Andrzej Siewior wrote:
> From: Matt Porter <mdp@ti.com>
>
> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> Documentation/devicetree/bindings/dma/ti-edma.txt
>
> Joel: Drop DT entries that are non-hardware-description for now as discussed in [1]
>
> [1] https://patchwork.kernel.org/patch/2226761/
>
> Signed-off-by: Matt Porter <mporter@ti.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Could someone please pick this up?
>
> v1..v2:
> 	- s/edma@/dma-controller@/
>
>   arch/arm/boot/dts/am33xx.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..784f774 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -96,6 +96,18 @@
>   			reg = <0x48200000 0x1000>;
>   		};
>
> +		edma: dma-controller at 49000000 {
> +			compatible = "ti,edma3";
> +			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> +			reg =	<0x49000000 0x10000>,
> +				<0x44e10f90 0x10>;
> +			interrupts = <12 13 14>;
> +			#dma-cells = <1>;
> +			dma-channels = <64>;
> +			ti,edma-regions = <4>;
> +			ti,edma-slots = <256>;
> +		};
> +
>   		gpio0: gpio at 44e07000 {
>   			compatible = "ti,omap4-gpio";
>   			ti,hwmods = "gpio1";
>
