From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Feb 2018 09:48:22 +0100
Subject: [PATCH v3 3/7] ARM: dts: sun8i: Add PRCM device node for the
 A83T dtsi
In-Reply-To: <20180219081837.15482-4-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-4-mylene.josserand@bootlin.com>
Message-ID: <20180219084822.zudk3w55z75lx5gx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 19, 2018 at 09:18:33AM +0100, Myl?ne Josserand wrote:
> As we found in Sun9i-A80, PRCM is a collection of clock controls,
> reset controls, and various power switches/gates.
> It is used with CPUCFG for SMP bringup and CPU hotplugging.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index e45bab836620..3e7317ec3e43 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -699,6 +699,11 @@
>  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		prcm at 1f01400 {
> +			compatible = "allwinner,sun8i-a83t-prcm";
> +			reg = <0x1f01400 0x400>;
> +		};
> +
>  		r_ccu: clock at 1f01400 {
>  			compatible = "allwinner,sun8i-a83t-r-ccu";
>  			reg = <0x01f01400 0x400>;

These two are exactly the same nodes.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/1adc1504/attachment.sig>
