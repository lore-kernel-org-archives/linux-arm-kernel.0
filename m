From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 14 Mar 2013 15:57:34 +0100
Subject: [PATCH 0/9] ARM: dts: Various OMAP2+ device-tree updates
In-Reply-To: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Message-ID: <5141E55E.9040801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Jon,

On 03/08/2013 06:27 PM, Jon Hunter wrote:
> Various OMAP device-tree updates for PMU, DMA, GPIO, GPMC and boards.
> 
> The DMA, PMU and OMAP3430 SDP board changes have been sent before
> individually but re-sending here as a complete series for v3.10.
> 
> This is based upon v3.9-rc1 and the OMAP3 GPMC binding from Florian
> Vaussard [1] and OMAP5 DT SPI patch from Felipe Balbi [2].
> 
> [1] https://patchwork.kernel.org/patch/2057111/

I've tried to follow the series review, and it seems that Florian was
considering sending some other patches. It is not clear if this is a new
version of the series or some additional patches.

I still did not merge this series wondering what to do with it.

Felipe's patch on this other hand is already applied in my branch.

Regards,
Benoit

> [2] https://patchwork.kernel.org/patch/2134711/
> 
> Jon Hunter (9):
>   ARM: OMAP2+: Prepare for device-tree PMU support
>   ARM: dts: OMAP2+: Add PMU nodes
>   ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
>   ARM: dts: OMAP3: Add support for OMAP3430 SDP board
>   ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
>   ARM: dts: Add OMAP3430 SDP flash memory bindings
>   ARM: dts: Add OMAP2 gpio bindings
>   ARM: dts: OMAP3+: Correct gpio #interrupts-cells property
>   ARM: dts: OMAP3: Add reg and interrupt properties for gpio
> 
>  .../devicetree/bindings/dma/omap-sdma.txt          |   51 +++++++
>  arch/arm/boot/dts/Makefile                         |    1 +
>  arch/arm/boot/dts/omap2.dtsi                       |   17 +++
>  arch/arm/boot/dts/omap2420.dtsi                    |   55 ++++++++
>  arch/arm/boot/dts/omap2430.dtsi                    |   66 +++++++++
>  arch/arm/boot/dts/omap3.dtsi                       |   70 +++++++++-
>  arch/arm/boot/dts/omap3430-sdp.dts                 |  141 ++++++++++++++++++++
>  arch/arm/boot/dts/omap4-panda-es.dts               |    2 +
>  arch/arm/boot/dts/omap4.dtsi                       |   64 ++++++++-
>  arch/arm/boot/dts/omap4460.dtsi                    |   18 +++
>  arch/arm/boot/dts/omap5.dtsi                       |   68 ++++++++--
>  arch/arm/mach-omap2/pmu.c                          |   14 +-
>  12 files changed, 544 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt
>  create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
>  create mode 100644 arch/arm/boot/dts/omap4460.dtsi
> 
