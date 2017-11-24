From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Nov 2017 11:44:47 -0200
Subject: [PATCH] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <20171124112151.2758-1-otavio@ossystems.com.br>
References: <20171124112151.2758-1-otavio@ossystems.com.br>
Message-ID: <CAOMZO5D62MHAbJSsUhTV+HcWeN4AZ_ePE+jRHA=dRzxgmO==LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 9:21 AM, Otavio Salvador
<otavio@ossystems.com.br> wrote:

> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index 4bdf29169d2a..f8b267875e1c 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -276,6 +276,23 @@
>                 compatible = "sst,sst25vf016b", "jedec,spi-nor";
>                 spi-max-frequency = <20000000>;
>                 reg = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               partition at 0 {
> +                       label = "U-Boot";

What about calling it something more generic, like "bootloader"?

U-Boot is not the only bootloader that can run on this board.

You could also consider passing the 'read-only' property like it is
done in imx6sx-nitrogen6sx.dts.

> +                       reg = <0x0 0xc0000>;
> +               };
> +
> +               partition at c0000 {
> +                       label = "U-Boot Environment";

Maybe just 'env' and add  'read-only' property here as well.
