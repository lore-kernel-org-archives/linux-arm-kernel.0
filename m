From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 5 Mar 2015 20:42:58 +0100
Subject: [PATCH 0/3] net: macb: rework at91 specific handling
In-Reply-To: <1425572842-6084-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425572842-6084-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150305194258.GX3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2015 at 17:27:19 +0100, Boris Brezillon wrote :
> Hello,
> 
> This removes the #if defined(ARCH_AT91) sections to prevent any problem
> when enabling ARM multi-platform support.
> The at91 specific logic is now activated when the "at91sam9260-macb"
> compatible string is found. 
> 

A small nit in patch 3 but I'm fine with the series

Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> Best Regards,
> 
> Boris
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
>  drivers/net/ethernet/cadence/macb.c            | 33 ++++++++++++++------------
>  drivers/net/ethernet/cadence/macb.h            |  2 ++
>  9 files changed, 30 insertions(+), 22 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
