From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 6 Mar 2015 17:44:44 +0100
Subject: [PATCH v2 0/3] net: macb: rework at91 specific handling
In-Reply-To: <1425637442-8724-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425637442-8724-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54F9D97C.3050100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/03/2015 11:23, Boris Brezillon a ?crit :
> Hello,
> 
> This removes the #if defined(ARCH_AT91) sections to prevent any problem
> when enabling ARM multi-platform support.
> The at91 specific logic is now activated when the "at91sam9260-macb"
> compatible string is found. 
> 
> Best Regards,
> 
> Boris

I'm okay with the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> 
> Changes since v1:
> - avoid changing existing behavior as Alexandre suggested
> 
> Boris Brezillon (3):
>   net/macb: Update DT bindings documentation
>   ARM: at91/dt: fix macb compatible strings
>   net: macb: remove #if defined(CONFIG_ARCH_AT91) sections
> 
>  Documentation/devicetree/bindings/net/macb.txt |  5 +++-
>  arch/arm/boot/dts/at91sam9260.dtsi             |  2 +-
>  arch/arm/boot/dts/at91sam9263.dtsi             |  2 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi             |  2 +-
>  arch/arm/boot/dts/at91sam9x5_macb0.dtsi        |  2 +-
>  arch/arm/boot/dts/at91sam9x5_macb1.dtsi        |  2 +-
>  arch/arm/boot/dts/sama5d3_emac.dtsi            |  2 +-
>  drivers/net/ethernet/cadence/macb.c            | 32 ++++++++++++++------------
>  drivers/net/ethernet/cadence/macb.h            |  2 ++
>  9 files changed, 29 insertions(+), 22 deletions(-)
> 


-- 
Nicolas Ferre
