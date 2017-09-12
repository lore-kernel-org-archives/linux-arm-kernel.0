From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Sep 2017 00:19:39 +0300
Subject: [PATCH 10/11] arm64: dts: renesas: initial Eagle board device tree
In-Reply-To: <20170912210543.810219167@cogentembedded.com>
References: <20170912210543.810219167@cogentembedded.com>
Message-ID: <d6f9d5ef-4864-3ffb-9406-acd65bff10aa@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2017 11:37 PM, Sergei Shtylyov wrote:

> Add the initial device  tree for  the R8A77970 SoC based Eagle board.
> The board has 1 debug serial port (SCIF0); include support for it,
> so that the serial console can work.
> 
> Based on the original (and large) patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
[...]
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -0,0 +1,45 @@
[...]
> +&extal_clk {
> +	clock-frequency = <16666666>;
> +};
> +
> +&extalr_clk {
> +	clock-frequency = <32768>;
> +};
> +

    Forgot to specify SCIF_CLK -- it's populated.

> +&scif0 {
> +	status = "okay";
> +};

MBR, Sergei
