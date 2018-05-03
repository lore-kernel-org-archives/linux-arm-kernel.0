From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 3 May 2018 10:22:44 +0800
Subject: [PATCH V4 8/8] arm64: dts: mt6797: add pwrap support for mt6797
In-Reply-To: <20180502092112.3991-9-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-9-argus.lin@mediatek.com>
Message-ID: <1525314164.14792.43.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-02 at 17:21 +0800, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6797 is a highly integrated SoCs, and it uses
> mt6351 as Power Management IC.
> We need to add pwrap device to communicate with
> mt6351 by SPI.
> The base address of pwrap is 0x1000d000, and IRQ
> number is 178. It also using fixed 26Mhz clock
> as SPI CLK.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> index 4beaa71107d7..485546efc9bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -161,6 +161,20 @@
>  		      <0 0x10220690 0 0x10>;
>  	};
>  
> +	pwrap: pwrap at 1000d000 {
> +		compatible = "mediatek,mt6797-pwrap";
> +		reg = <0 0x1000d000 0 0x1000>;
> +		reg-names = "pwrap";
> +		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clk26m>, <&clk26m>;
> +		clock-names = "spi", "wrap";
> +
> +		pmic: mt6351 {
> +			compatible = "mediatek,mt6351";
> +			interrupt-controller;

the child node can't be added until MT6351 support is added to
dt-binding

> +		};
> +	};
> +
>  	uart0: serial at 11002000 {
>  		compatible = "mediatek,mt6797-uart",
>  			     "mediatek,mt6577-uart";
