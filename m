From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 May 2015 20:01:01 +0800
Subject: [PATCH] imx27: dt: only map 1 Kbyte for fec registers
In-Reply-To: <1431204870-17233-1-git-send-email-tremyfr@gmail.com>
References: <1431204870-17233-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20150511120101.GA25495@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 10:54:30PM +0200, Philippe Reynes wrote:
> According to the imx27 documentation, fec has a 1 Kbyte
> memory space map, spitted in two regions of 512 bytes.
> The first one for control/status registers, and the
> second one for event/statistic registers. So, we don't
> need to map 16 Kbyte for registers, 1 Kbyte is enough.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 6951b66..56bb917 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -533,7 +533,7 @@
>  
>  			fec: ethernet at 1002b000 {
>  				compatible = "fsl,imx27-fec";
> -				reg = <0x1002b000 0x4000>;
> +				reg = <0x1002b000 0x400>;

No.  Per MCIMX27RM.pdf, Table 2-7. AIPI2 Memory Map, it should be 4KiB.

Shawn

>  				interrupts = <50>;
>  				clocks = <&clks IMX27_CLK_FEC_IPG_GATE>,
>  					 <&clks IMX27_CLK_FEC_AHB_GATE>;
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
