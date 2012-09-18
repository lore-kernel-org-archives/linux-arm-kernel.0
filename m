From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Tue, 18 Sep 2012 10:02:06 -0300
Subject: [PATCH 1/2] ARM: LPC32xx: DTS update for devicetree completion of
 spi-pl022
In-Reply-To: <1347973228-29839-1-git-send-email-stigge@antcom.de>
References: <1347973228-29839-1-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30F=TTyZtRk+EOK+u0e_5Km=T9ibhvA+4--pA7cfxHjYew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 10:00 AM, Roland Stigge <stigge@antcom.de> wrote:
> spi-pl022 got a further update to its devicetree support, completing properties
> such that no platform data is necessary anymore. This patch adjusts
> lpc32xx.dtsi accordingly.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

>
> ---
> I will do a git pull request for arm-soc.git when the respective change in
> spi-pl022.c is merged.
>
>  arch/arm/boot/dts/lpc32xx.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
> +++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -91,6 +91,7 @@
>                                 compatible = "arm,pl022", "arm,primecell";
>                                 reg = <0x20084000 0x1000>;
>                                 interrupts = <0x14 0>;
> +                               pl022,bus-id = <0>;
>                         };
>
>                         spi1: spi at 20088000 {
> @@ -102,6 +103,7 @@
>                                 compatible = "arm,pl022", "arm,primecell";
>                                 reg = <0x2008c000 0x1000>;
>                                 interrupts = <0x15 0>;
> +                               pl022,bus-id = <1>;
>                         };
>
>                         spi2: spi at 20090000 {
