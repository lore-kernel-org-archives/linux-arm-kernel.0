From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 24 Apr 2015 09:58:08 +0200
Subject: [PATCH 4/4] ARM: dts: mediatek mt8135: Use real UART clocks
In-Reply-To: <1429780875-29096-5-git-send-email-s.hauer@pengutronix.de>
References: <1429780875-29096-1-git-send-email-s.hauer@pengutronix.de>
 <1429780875-29096-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeKoxAdW3VdrF229VAm+eB8Rku=_QF9bu-nCXfj+T=dMvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-23 11:21 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> We used to provide dummy clocks for the UART. Now that we have
> common clock support we can provide the real clocks to the UART.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index b0f20fc..4d1ddd9 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -180,7 +180,8 @@
>                         compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
>                         reg = <0 0x11006000 0 0x400>;
>                         interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
> -                       clocks = <&uart_clk>;
> +                       clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
> +                       clock-names = "baud", "bus";
>                         status = "disabled";
>                 };

We can delete the dummy uart_clk, as it is not needed any more.

-- 
motzblog.wordpress.com
