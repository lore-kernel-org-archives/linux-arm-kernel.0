From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 29 Aug 2013 09:24:42 -0400
Subject: [PATCH v2 0/3] OMAP4+: Get rid of internal SRAM handling
In-Reply-To: <1377775391-13103-1-git-send-email-rnayak@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com>
Message-ID: <521F4B9A.5020601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 August 2013 07:23 AM, Rajendra Nayak wrote:
> v2:
> Removed the static iotable mapping for sram done to handle
> errata I688, and used gen_pool instead.
> 
> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
> use drivers/misc/sram.c driver instead of the omap internal
> implementation for SRAM handling.
> 
> Rajendra Nayak (3):
>   ARM: AM335x: Get rid of unused sram init function
>   ARM: OMAP4+: Move SRAM data to DT
>   ARM: OMAP4+: Remove static iotable mappings for SRAM
> 
>  Documentation/devicetree/bindings/arm/omap/mpu.txt |    5 ++-
>  arch/arm/boot/dts/am33xx.dtsi                      |    5 +--
>  arch/arm/boot/dts/am4372.dtsi                      |    5 +++
>  arch/arm/boot/dts/omap4.dtsi                       |    6 +++
>  arch/arm/boot/dts/omap5.dtsi                       |    8 +++-
>  arch/arm/configs/omap2plus_defconfig               |    1 +
>  arch/arm/mach-omap2/io.c                           |   17 ---------
>  arch/arm/mach-omap2/omap4-common.c                 |   17 ++++++++-
>  arch/arm/mach-omap2/sram.c                         |   39 +-------------------
>  arch/arm/mach-omap2/sram.h                         |    7 ----
>  10 files changed, 42 insertions(+), 68 deletions(-)
> 
Apart from one minor comment of last patch, the series looks
fine ti me.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


Regards,
Santosh
