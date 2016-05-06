From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 6 May 2016 15:24:56 +0200
Subject: [PATCH 0/3] ARM: at91/dt: add SAMA5 trng nodes
In-Reply-To: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
References: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
Message-ID: <572C9B28.40608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/05/2016 18:44, Mike Williams a ?crit :
> Adds support for the true hardware random number generator.
> 
> Tested on a SAMA5D3 Xplained board.
> 
> Mike Williams (3):
>   ARM: at91/dt: sama5d2: add trng node
>   ARM: at91/dt: sama5d3: add trng node
>   ARM: at91/dt: sama5d4: add trng node
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 7 +++++++
>  arch/arm/boot/dts/sama5d3.dtsi | 7 +++++++
>  arch/arm/boot/dts/sama5d4.dtsi | 7 +++++++
>  3 files changed, 21 insertions(+)

Oh, yes: they were missing indeed.

BTW, I reduce the size of the register memory map to 0x100 like this on
all patches (no need to re-send):

@@ -1170,7 +1170,7 @@

                        trng at fc01c000 {
                                compatible = "atmel,at91sam9g45-trng";
-                               reg = <0xfc01c000 0x4000>;
+                               reg = <0xfc01c000 0x100>;
                                interrupts = <47 IRQ_TYPE_LEVEL_HIGH 0>;
                                clocks = <&trng_clk>;
                        };


and take advantage of this to do the same on
arch/arm/boot/dts/at91sam9g45.dtsi as well.

Thanks and:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I stack the patches on top of at91-4.7-dt and build a pull-request soon.

Bye,
-- 
Nicolas Ferre
