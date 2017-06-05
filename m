From: joel@jms.id.au (Joel Stanley)
Date: Mon, 5 Jun 2017 18:29:53 +0930
Subject: [PATCH] arm: aspeed: Add clock-names property to timer node
In-Reply-To: <20170605074846.30925-1-andrew@aj.id.au>
References: <20170605074846.30925-1-andrew@aj.id.au>
Message-ID: <CACPK8XeM6fBztHwfrPUD+ewpMf==tBqgfj61B-k=SwT3ABTiZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 5:18 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> The merging of a number of clocksource drivers into fttmr010 means we
> require clock-names to be specified in the Aspeed timer node, else the
> clocksource fails to probe and boot hangs.

Arnd,

Linus' reworked timer driver will go into 4.13.

Can we get this patch merged into 4.12 as a fix so we don't end up
with a broken boot at any stage?

Cheers,

Joel

>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 8c6bc29eb7f6..3e74929d3289 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -893,6 +893,7 @@
>                                 //interrupts = <16 17 18 35 36 37 38 39>;
>                                 interrupts = <16>;
>                                 clocks = <&clk_apb>;
> +                               clock-names = "PCLK";
>                         };
>
>                         wdt1: wdt at 1e785000 {
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index a0bea4a6ec77..1e6c701da853 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1000,6 +1000,7 @@
>                                 //interrupts = <16 17 18 35 36 37 38 39>;
>                                 interrupts = <16>;
>                                 clocks = <&clk_apb>;
> +                               clock-names = "PCLK";
>                         };
>
>
> --
> 2.11.0
>
