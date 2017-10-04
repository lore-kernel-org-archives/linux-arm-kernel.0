From: joel@jms.id.au (Joel Stanley)
Date: Wed, 4 Oct 2017 16:22:28 +0930
Subject: [PATCH v2 9/9] ARM: dts: aspeed: Clean up UART nodes
In-Reply-To: <20171004064917.2498-10-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
 <20171004064917.2498-10-joel@jms.id.au>
Message-ID: <CACPK8XcQB6PQhGxESV0owo_sAg2+4KV7hsyT-TJOpuOCXmTcdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 4:19 PM, Joel Stanley <joel@jms.id.au> wrote:

> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 61cc2d25143a..cef51dcc1002 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi

> @@ -297,9 +297,9 @@
>                                 };
>                         };
>
> -                       uart6: serial at 1e787000 {
> -                               compatible = "ns16550a";
> -                               reg = <0x1e787000 0x1000>;
> +                       vuart: vuart at 1e787000 {

Doh. I'll fix this up when I apply, assuming I don't need to send a v3.


> +                               compatible = "aspeed,ast2500-vuart";
> +                               reg = <0x1e787000 0x40>;
>                                 reg-shift = <2>;
>                                 interrupts = <10>;
>                                 clocks = <&clk_uart>;
