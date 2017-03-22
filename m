From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Mar 2017 20:22:21 +0100
Subject: [PATCH 1/3] ARM: sun8i: v3s: add LRADC device node
In-Reply-To: <20170317154343.39921-2-icenowy@aosc.xyz>
References: <20170317154343.39921-1-icenowy@aosc.xyz>
 <20170317154343.39921-2-icenowy@aosc.xyz>
Message-ID: <20170322192221.yhtk6qmzqka4vssd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 11:43:41PM +0800, Icenowy Zheng wrote:
> Allwinner V3s features a LRADC like the ones in older SoCs.
> 
> Add a device tree node for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 71075969e5e6..77bbf5ff9548 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -238,6 +238,13 @@
>  			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		lradc: lradc at 01c22800 {

The node name should reflect the class of the device, so something like adc at ..

> +			compatible = "allwinner,sun4i-a10-lradc-keys";

Please put a SoC-specific compatible there.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/2be98fab/attachment-0001.sig>
