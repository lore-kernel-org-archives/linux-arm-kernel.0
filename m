From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Aug 2018 13:42:14 -0300
Subject: [PATCH 1/1] ARM: dts: imx6ul: Add weim node
In-Reply-To: <20180824163605.12521-1-sebastien.szymanski@armadeus.com>
References: <20180824163605.12521-1-sebastien.szymanski@armadeus.com>
Message-ID: <CAOMZO5Bx5S7vEV5swqdcyaZUdEr7U0xgBzvvdq9gr07EPA=x=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?bastien,

On Fri, Aug 24, 2018 at 1:32 PM S?bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Add weim node for i.MX6UL SOC.
>
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 47a3453a4211..7b00efd93d18 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -912,6 +912,17 @@
>                                 reg = <0x021b0000 0x4000>;
>                         };
>
> +                       weim: weim at 21b8000 {
> +                               #address-cells = <2>;
> +                               #size-cells = <1>;
> +                               compatible = "fsl,imx6ul-weim", "fsl,imx6q-weim";
> +                               reg = <0x021b8000 0x4000>;
> +                               interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;

Looks good.

Only a minor nit: for consistency please use:
interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
