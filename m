From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 30 May 2017 11:10:19 -0700
Subject: [PATCH 1/2] ARM: dts: imx6ul-14x14-evk: Add ksz8081 phy properties
In-Reply-To: <d31aab90fbdecaf4c5f240becb2d0b0efb23f5c3.1496164448.git.leonard.crestez@nxp.com>
References: <cover.1496164448.git.leonard.crestez@nxp.com>
 <d31aab90fbdecaf4c5f240becb2d0b0efb23f5c3.1496164448.git.leonard.crestez@nxp.com>
Message-ID: <46bde649-c9ce-5a87-d4c4-1c1ebc5a8923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2017 10:34 AM, Leonard Crestez wrote:
> Right now mach-imx6ul registers a fixup for the ksz8081 phy. The same
> register values can be set through the micrel phy driver by using dts
> properties.
> 
> This seems preferable and allows cleanly fixing suspend/resume.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Should you have a Fixes: tag for that? Sounds like something you'd want
to backport to stable trees as well, no?

> ---
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> index f18e1f1..d2be8aa 100644
> --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> @@ -120,10 +120,16 @@
>  
>  		ethphy0: ethernet-phy at 2 {
>  			reg = <2>;
> +			micrel,led-mode = <1>;
> +			clocks = <&clks IMX6UL_CLK_ENET_REF>;
> +			clock-names = "rmii-ref";
>  		};
>  
>  		ethphy1: ethernet-phy at 1 {
>  			reg = <1>;
> +			micrel,led-mode = <1>;
> +			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
> +			clock-names = "rmii-ref";
>  		};
>  	};
>  };
> 


-- 
Florian
