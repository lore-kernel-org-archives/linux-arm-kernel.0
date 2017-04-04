From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 04 Apr 2017 11:53:08 +0200
Subject: [PATCH 5/5] ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply
In-Reply-To: <6711393cb78e8f975014e26e4008481828459463.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <6711393cb78e8f975014e26e4008481828459463.1490987945.git.leonard.crestez@nxp.com>
Message-ID: <1491299588.2367.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
> the other imx6qdl-sabresd boards.
> 
> Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
> slipped out of the vendor tree where this is are used for LDO bypass.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qp-sabresd.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
> index b234580..a8a5004 100644
> --- a/arch/arm/boot/dts/imx6qp-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
> @@ -50,8 +50,8 @@
>  	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
>  };
>  
> -&cpu0 {
> -	arm-supply = <&sw2_reg>;
> +&reg_arm {
> +	vin-supply = <&sw2_reg>;
>  };
>  
>  &iomuxc {
