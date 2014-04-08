From: marex@denx.de (Marek Vasut)
Date: Wed, 9 Apr 2014 00:24:30 +0200
Subject: ethaddr0 alias for imx6
In-Reply-To: <534429E9.1050202@digi.com>
References: <534429E9.1050202@digi.com>
Message-ID: <201404090024.30624.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 08, 2014 at 06:55:05 PM, Hector Palacios wrote:
> Hello,
> 
> I think I'm missing a commit similar to
> 8c41d57395ff5b9b16724786c7c4b4c4081510cc to add the ethernet0 alias so
> that U-Boot can fixup the MAC in the device tree for iMX6. Like this:
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
> b/arch/arm/boot/dts/imx6qdl.dtsi index b48a128e519d..b3ec952eada6 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -15,6 +15,7 @@
> 
>   / {
>          aliases {
> +               ethernet0 = &fec;
>                  flexcan0 = &flexcan1;
>                  flexcan1 = &flexcan2;
>                  gpio0 = &gpio1;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index b937a4a94202..2afd45c67996 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -13,6 +13,7 @@
> 
>   / {
>          aliases {
> +               ethernet0 = &fec;
>                  serial0 = &uart1;
>                  serial1 = &uart2;
>                  serial2 = &uart3;
> 
> Has this changed recently and is done in a different way or has nobody
> noticed it before?

Try 10021ccaf042dd8d09c247c447b3ef22de0b83c8 in linux-next .

Best regards,
Marek Vasut
