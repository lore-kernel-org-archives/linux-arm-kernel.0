From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Jan 2017 22:00:15 -0200
Subject: [PATCH v8 3/3] ARM: dts: imx6q-evi: support cyclone-ps-spi
In-Reply-To: <c429cec34a880c0d5438091f436a5946a4db3fc0.1485211400.git.stillcompiling@gmail.com>
References: <cover.1485211400.git.stillcompiling@gmail.com>
 <c429cec34a880c0d5438091f436a5946a4db3fc0.1485211400.git.stillcompiling@gmail.com>
Message-ID: <CAOMZO5AmQhjGOa2NaFn0Az4Xnza8jmK=9gpPJpnkmAvN_zxzeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 8:51 PM, Joshua Clayton
<stillcompiling@gmail.com> wrote:
> Add support for Altera cyclone V FPGA connected to an spi port
> to the evi devicetree file
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
> index 24fe093..a0cbb2d 100644
> --- a/arch/arm/boot/dts/imx6q-evi.dts
> +++ b/arch/arm/boot/dts/imx6q-evi.dts
> @@ -82,6 +82,15 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
>         status = "okay";
> +
> +       fpga_spi: cyclonespi at 0 {
> +               compatible = "altr,fpga-passive-serial";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +               pinctrl-0 = <&pinctrl_fpgaspi>;
> +               nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +               nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;

Your binding doc says that 'confd-gpios ' is a required property, but
you did not put it here.

Either it is missing here or you should mention that it is optional in
the binding doc.
