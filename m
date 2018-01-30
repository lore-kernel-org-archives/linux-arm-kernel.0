From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 30 Jan 2018 13:57:12 +0100
Subject: [PATCH v2 2/5] arm64: dts: mt6797: add pwrap support for mt6797
In-Reply-To: <20180129090944.28687-2-argus.lin@mediatek.com>
References: <20180129090944.28687-1-argus.lin@mediatek.com>
 <20180129090944.28687-2-argus.lin@mediatek.com>
Message-ID: <dcb5d00a-2239-b214-70a2-cef2e66570fa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/29/2018 10:09 AM, argus.lin at mediatek.com wrote:
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

For the next round, can you put the dts patch at the end of the series. Binding
description should be the first patch, but actual dts(i) inclusion should be the
last one. It's bike shedding I know, but as you need a new series anyway.

Thanks.

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
> +		};
> +	};
> +
>  	uart0: serial at 11002000 {
>  		compatible = "mediatek,mt6797-uart",
>  			     "mediatek,mt6577-uart";
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank
>  you!
> 
