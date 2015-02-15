From: horms@verge.net.au (Simon Horman)
Date: Sun, 15 Feb 2015 10:36:29 -0500
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk
 from mp_clk
In-Reply-To: <1424011746-3787-2-git-send-email-ykaneko0929@gmail.com>
References: <1424011746-3787-2-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20150215153628.GB25065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 15, 2015 at 11:49:05PM +0900, Yoshihiro Kaneko wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> 
> HSUSB uses hp_clk for H/W register access.
> HSUSB uses mp_clk for USB-DMAC access.
> The clock is defined for H/W register access.
> 
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

I plan to take this through the renesas tree unless someone objects.
In the mean time, for reference:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> This patch is based on devel branch of Simon Horman's renesas tree.
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 24de994..113edf2 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1,6 +1,7 @@
>  /*
>   * Device Tree Source for the r8a7790 SoC
>   *
> + * Copyright (C) 2015 Renesas Electronics Corporation
>   * Copyright (C) 2013-2014 Renesas Solutions Corp.
>   * Copyright (C) 2014 Cogent Embedded Inc.
>   *
> @@ -1132,7 +1133,7 @@
>  		mstp7_clks: mstp7_clks at e615014c {
>  			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>  			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> -			clocks = <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
> +			clocks = <&mp_clk>, <&hp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
>  				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
>  				 <&zx_clk>;
>  			#clock-cells = <1>;
> -- 
> 1.9.1
> 
