From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 04 Apr 2017 11:52:21 +0200
Subject: [PATCH 4/5] ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
In-Reply-To: <48ebd72d94b5be37318f57e47c8ba5c6ab606470.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <48ebd72d94b5be37318f57e47c8ba5c6ab606470.1490987945.git.leonard.crestez@nxp.com>
Message-ID: <1491299541.2367.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> Setting the supply is optional but beneficial, it will cause PMIC
> voltages to be dynamically changed with cpu frequency.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 63bf95e..58055ce 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -548,6 +548,18 @@
>  	status = "okay";
>  };
>  
> +&reg_arm {
> +       vin-supply = <&sw1a_reg>;
> +};
> +
> +&reg_pu {
> +       vin-supply = <&sw1c_reg>;
> +};
> +
> +&reg_soc {
> +       vin-supply = <&sw1c_reg>;
> +};
> +
>  &snvs_poweroff {
>  	status = "okay";
>  };
