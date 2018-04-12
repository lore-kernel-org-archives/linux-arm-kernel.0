From: cphealy@gmail.com (Chris Healy)
Date: Thu, 12 Apr 2018 07:14:39 -0700
Subject: [PATCH 1/3] ARM: dts: imx6: RDU2: bump SoC/PU operating points by
 25mV
In-Reply-To: <20180412131556.11073-1-l.stach@pengutronix.de>
References: <20180412131556.11073-1-l.stach@pengutronix.de>
Message-ID: <CAFXsbZqO+jewUYsKtzHsmRJFedYp48TK9u5Aq36ips=5Y1BawQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Chris Healy <cphealy@gmail.com>

On Thu, Apr 12, 2018 at 6:15 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This bumps the SoC/PU domain operating points by 25mV, giving a total
> of 75mV margin to the minimum required voltages. This gets rid of
> brown-outs seen due to voltage drop-out on the board.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 72f52fcecee1..4bc14b8e9a66 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -263,6 +263,17 @@
>         };
>  };
>
> +&cpu0 {
> +       fsl,soc-operating-points = <
> +               /* ARM kHz  SOC-PU uV */
> +               1200000 1300000
> +               996000  1275000
> +               852000  1275000
> +               792000  1200000
> +               396000  1200000
> +       >;
> +};
> +
>  &reg_arm {
>         vin-supply = <&sw1a_reg>;
>  };
> --
> 2.16.3
>
