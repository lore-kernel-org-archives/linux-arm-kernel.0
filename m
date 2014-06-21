From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jun 2014 14:36:34 +0800
Subject: [PATCH 1/2] ARM: dts: i.MX25: Fix gpt4 timer per clock.
In-Reply-To: <1402664146-14314-1-git-send-email-denis@eukrea.com>
References: <1402664146-14314-1-git-send-email-denis@eukrea.com>
Message-ID: <20140621063632.GE6818@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Alexander

On Fri, Jun 13, 2014 at 02:55:45PM +0200, Denis Carikli wrote:
> Without that fix, the board freeze during boot.
> 
> This appeared after the following commit:
>   496f065 ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index bb74d95..98783f5 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -312,7 +312,7 @@
>  			gpt4: timer at 53f84000 {
>  				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
>  				reg = <0x53f84000 0x4000>;
> -				clocks = <&clks 9>, <&clks 45>;
> +				clocks = <&clks 9>, <&clks 47>;

So this changes the clock from esdhc1_ipg_per to gpt_ipg_per.  It looks
to me this is a bug fix on its own.  I need some help to understand why
the bug is only seen after Alexander's of_clk_get_by_name() patch.

Shawn

>  				clock-names = "ipg", "per";
>  				interrupts = <1>;
>  			};
> -- 
> 1.7.9.5
> 
