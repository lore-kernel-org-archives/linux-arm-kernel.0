From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 04 Nov 2014 16:12:49 +0300
Subject: [PATCH 03/10] ARM: shmobile: r8a7790: Add DU node to device tree
In-Reply-To: <3ac6a83c09cbb74ebb3d3e7e6e40e1ead3ff9d01.1415058552.git.horms+renesas@verge.net.au>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
 <3ac6a83c09cbb74ebb3d3e7e6e40e1ead3ff9d01.1415058552.git.horms+renesas@verge.net.au>
Message-ID: <5458D0D1.9080403@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/4/2014 4:50 AM, Simon Horman wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Add the DU device with a disabled state. Boards that want to enable the
> DU need to specify the output topology.

    OK, but you're also adding VSP1 device node and don't mention that at all.
Haven't you squashed 2 distinct patches by chance?

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> [horms+renesas at verge.net.au: resolved minor conflict]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 90 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 90 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index d0e1773..b7c59b7 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -600,6 +600,96 @@
>   		status = "disabled";
>   	};
>
> +	vsp1 at fe920000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe920000 0 0x8000>;
> +		interrupts = <0 266 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
> +
> +		renesas,has-sru;
> +		renesas,#rpf = <5>;
> +		renesas,#uds = <1>;
> +		renesas,#wpf = <4>;
> +	};
> +
> +	vsp1 at fe928000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe928000 0 0x8000>;
> +		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
> +
> +		renesas,has-lut;
> +		renesas,has-sru;
> +		renesas,#rpf = <5>;
> +		renesas,#uds = <3>;
> +		renesas,#wpf = <4>;
> +	};
> +
> +	vsp1 at fe930000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe930000 0 0x8000>;
> +		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
> +
> +		renesas,has-lif;
> +		renesas,has-lut;
> +		renesas,#rpf = <4>;
> +		renesas,#uds = <1>;
> +		renesas,#wpf = <4>;
> +	};
> +
> +	vsp1 at fe938000 {
> +		compatible = "renesas,vsp1";
> +		reg = <0 0xfe938000 0 0x8000>;
> +		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
> +
> +		renesas,has-lif;
> +		renesas,has-lut;
> +		renesas,#rpf = <4>;
> +		renesas,#uds = <1>;
> +		renesas,#wpf = <4>;
> +	};
[...]

WBR, Sergei
