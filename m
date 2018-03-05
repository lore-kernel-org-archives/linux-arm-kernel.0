From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 05 Mar 2018 14:48:13 +0100
Subject: [PATCH] arm: dts: kirkwood: fix error in #sound-dai-cells size
In-Reply-To: <20180301202537.30571-5-robh@kernel.org> (Rob Herring's message
 of "Thu, 1 Mar 2018 14:25:37 -0600")
References: <20180301202537.30571-5-robh@kernel.org>
Message-ID: <87h8pu63c2.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On jeu., mars 01 2018, Rob Herring <robh@kernel.org> wrote:

> dtc now gives the following warning:
>
> arch/arm/boot/dts/kirkwood-t5325.dtb: Warning (sound_dai_property): /sound/simple-audio-card,cpu:sound-dai: property size (4) too small for cell size 1
>
> The binding documentation gives no indication what the cell size should
> be (which should be fixed too), so just assume 0 is fine as that is what
> the consumer has.
>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied on mvebu/dt with the reviewed-by flag from Andrew.

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/kirkwood.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index eb2bf7409655..81c7eda2c442 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -382,7 +382,7 @@
>  
>  		audio0: audio-controller at a0000 {
>  			compatible = "marvell,kirkwood-audio";
> -			#sound-dai-cells = <1>;
> +			#sound-dai-cells = <0>;
>  			reg = <0xa0000 0x2210>;
>  			interrupts = <24>;
>  			clocks = <&gate_clk 9>;
> -- 
> 2.14.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
