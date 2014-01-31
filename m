From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 31 Jan 2014 23:03:03 +0100
Subject: [PATCH v7 0/7] ARM: rockchip: add smp functionality
In-Reply-To: <4970034.fqvMoHdOyd@phil>
References: <4970034.fqvMoHdOyd@phil>
Message-ID: <13010296.nzTT2PqdSR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, 20. January 2014 16:41:43 Heiko St?bner wrote:
> This series enables the use of the additional cores on Rockchip
> Cortex-A9 SoCs.

So, two weeks without any general complaints, but I guess part of the more 
general patches could use an ack.

Going forward, what would be best way to merge them?
As one pull request to arm-soc, or for example splitting them into the first 
three patches going through the misc tree and the rockchip specific stuff going 
through arm-soc? Or something else altogether?


> Heiko Stuebner (7):
>   of: add functions to count number of elements in a property

One of the intermediate versions of this patch got a
	Reviewed-by: Mark Rutland <mark.rutland@arm.com> .
Mark, is this still true for this variant addressing some additional wished 
from Rob?

And this final version got a "Looks good" from Rob Herring in the original 
thread, but a more formal "ack" might be nice :-) .


>   dt-bindings: sram: describe option to reserve parts of the memory
>   misc: sram: implement mmio-sram-reserved option

Philipp, you acked an intermediate version, and this v7 now should also 
contain the two separate loops (1st gathering data and 2nd creating the pool 
parts) you asked for.

Could I persuade you to take a look again?


Thanks
Heiko


>   ARM: rockchip: add snoop-control-unit
>   ARM: rockchip: add sram dt nodes and documentation
>   ARM: rockchip: add power-management-unit
>   ARM: rockchip: add smp bringup code
> 
>  .../devicetree/bindings/arm/rockchip/pmu.txt       |   16 ++
>  .../devicetree/bindings/arm/rockchip/smp-sram.txt  |   23 +++
>  Documentation/devicetree/bindings/misc/sram.txt    |    8 +
>  arch/arm/boot/dts/rk3066a.dtsi                     |    6 +
>  arch/arm/boot/dts/rk3188.dtsi                      |    6 +
>  arch/arm/boot/dts/rk3xxx.dtsi                      |   10 +
>  arch/arm/mach-rockchip/Kconfig                     |    1 +
>  arch/arm/mach-rockchip/Makefile                    |    1 +
>  arch/arm/mach-rockchip/core.h                      |   22 +++
>  arch/arm/mach-rockchip/headsmp.S                   |   30 +++
>  arch/arm/mach-rockchip/platsmp.c                   |  208
> ++++++++++++++++++++ arch/arm/mach-rockchip/rockchip.c                  |  
>  2 +
>  drivers/misc/sram.c                                |  121 +++++++++++-
>  drivers/of/base.c                                  |   32 +++
>  include/linux/of.h                                 |   76 +++++++
>  15 files changed, 554 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
>  create mode 100644
> Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt create mode
> 100644 arch/arm/mach-rockchip/core.h
>  create mode 100644 arch/arm/mach-rockchip/headsmp.S
>  create mode 100644 arch/arm/mach-rockchip/platsmp.c
