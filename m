From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 30 Apr 2018 14:38:35 +0200
Subject: [PATCH 02/17] arm64: dts: marvell: fix CP110 ICU node size
In-Reply-To: <20180421135537.24716-3-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Sat, 21 Apr 2018 15:55:22 +0200")
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-3-miquel.raynal@bootlin.com>
Message-ID: <87r2mwc1is.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On sam., avril 21 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
> specification).
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This patch looks like a fix, could you resubmit it with the approriate
flags?

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 48cad7919efa..9fa41c54f69c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -146,7 +146,7 @@
>  
>  		CP110_LABEL(icu): interrupt-controller at 1e0000 {
>  			compatible = "marvell,cp110-icu";
> -			reg = <0x1e0000 0x10>;
> +			reg = <0x1e0000 0x440>;
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
>  			msi-parent = <&gicp>;
> -- 
> 2.14.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
