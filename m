From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Jul 2014 16:24:21 +0200
Subject: [PATCH v3 0/2] ARM: at91: remove phy fixup for sama5d3xek boards
In-Reply-To: <1405022394-8311-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405022394-8311-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53C92E15.4030702@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 21:59, Boris BREZILLON :
> Hello,
> 
> This patch removes a board specific hook for sama5d3xek boards from the
> sama5d3 generic DT board file.
> 
> This hook (which register a phy fixup configuring board specific delays
> in the ksz9021 ethernet phy) is now replaced by the appropriate DT
> properties definitions in the sama5d3xcm.dtsi file.
> 
> Best Regards,

On the whole series:


Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> Changes since v2:
>  - define 2 phy nodes to handle Ronetix and Embest HW designs
> 
> Changes since v1:
>  - fix txc-skew-ps and rxc-skew-ps delays
>  - remove phy address info to handle Ronetix and Embest HW designs
> 
> Boris BREZILLON (2):
>   ARM: at91/dt: describe rgmii ethernet phy connected to sama5d3xek
>     boards
>   ARM: at91: remove phy fixup for sama5d3xek boards
> 
>  arch/arm/boot/dts/sama5d3xcm.dtsi   | 30 ++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/board-dt-sama5.c | 22 ----------------------
>  2 files changed, 30 insertions(+), 22 deletions(-)
> 


-- 
Nicolas Ferre
