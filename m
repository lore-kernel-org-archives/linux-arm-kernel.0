From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Feb 2015 20:39:41 +0300
Subject: [PATCH v2] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk
 from mp_clk
In-Reply-To: <1424360575-6482-1-git-send-email-horms+renesas@verge.net.au>
References: <1424360575-6482-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <54E61FDD.3060700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/19/2015 06:42 PM, Simon Horman wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

> HSUSB uses hp_clk rather than mp_clk for H/W register access.

> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> [horms: updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v2 [Simon Horman]
> - Updated changelog to remove information about USB-DMAC clock which
>    did not relate to the patch. I will follow up on weather the

    s/weather/whether/.

>    USB-DMAC clock should be mp_clk as the deleted portion of the
>    changelog stated.
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 24de994..113edf2 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1,6 +1,7 @@
>   /*
>    * Device Tree Source for the r8a7790 SoC
>    *
> + * Copyright (C) 2015 Renesas Electronics Corporation

    One-liner is hardly enough for the copyright claim. Greg KH even used to 
say that roughly a third part of a file changed was worth it, IIRC.

>    * Copyright (C) 2013-2014 Renesas Solutions Corp.
>    * Copyright (C) 2014 Cogent Embedded Inc.
>    *
> @@ -1132,7 +1133,7 @@
>   		mstp7_clks: mstp7_clks at e615014c {
>   			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>   			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> -			clocks = <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
> +			clocks = <&mp_clk>, <&hp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
>   				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
>   				 <&zx_clk>;
>   			#clock-cells = <1>;

WBR, Sergei
