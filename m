From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 14 Jun 2014 20:55:21 +0400
Subject: [PATCH v3 13/19] ARM: shmobile: r8a7791: Add CMT devices to DT
In-Reply-To: <1402763021-4067-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1402763021-4067-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <539C7E79.7080504@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2014 08:23 PM, Laurent Pinchart wrote:

> Add the CMT0 and CMT1 counters to the r8a7791 device tree and make them
> disabled by default.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7791.dtsi | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 380d058..b56a995 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -189,6 +189,40 @@
>   			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
>
> +	cmt0: timer at ffca0000 {
> +		compatible = "renesas,cmt-48-gen2";
> +		reg = <0 0xffca0000 0 0x1004>;
> +		interrupt-parent = <&gic>;

    This prop inherited from the root node, no need to specify it here.

> +		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
> +		clock-names = "fck";
> +
> +		renesas,channels-mask = <0x60>;
> +
> +		status = "disabled";
> +	};
> +
> +	cmt1: timer at e6130000 {
> +		compatible = "renesas,cmt-48-gen2";
> +		reg = <0 0xe6130000 0 0x1004>;
> +		interrupt-parent = <&gic>;

    Likewise.

WBR, Sergei
