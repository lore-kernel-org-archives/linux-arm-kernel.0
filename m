From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 9 Aug 2017 12:17:06 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <1502196418-31341-1-git-send-email-biju.das@bp.renesas.com>
References: <1502196418-31341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/8/2017 3:46 PM, Biju Das wrote:

> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch has been tested against Linux-next tag 20170727 and renesas-dev branch.
> This patch depends on https://www.spinics.net/lists/arm-kernel/msg599220.html
> 
>   arch/arm/boot/dts/r8a7743.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> index 14222c72..5c2b140 100644
> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
[...]
> @@ -436,6 +439,58 @@
>   			status = "disabled";
>   		};
>   
> +		i2c6: i2c at e60b0000 {

    I'd use iic0 as the label.

> +			/* doesn't need pinmux */
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "renesas,iic-r8a7743",
> +				     "renesas,rcar-gen2-iic",
> +				     "renesas,rmobile-iic";
> +			reg = <0 0xe60b0000 0 0x425>;
> +			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 926>;
> +			dmas = <&dmac0 0x77>, <&dmac0 0x78>,
> +			       <&dmac1 0x77>, <&dmac1 0x78>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +			resets = <&cpg CPG_MOD 926>;

    CPG_MOD not needed here, it's not a "clocks" prop.

[...]

MBR, Sergei
