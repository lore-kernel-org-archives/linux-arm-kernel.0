From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 11 Feb 2013 09:40:34 -0600
Subject: [PATCHv4 for soc 0/4] Enabling socfpga on hardware
In-Reply-To: <1360008731-17021-1-git-send-email-dinguyen@altera.com>
References: <1360008731-17021-1-git-send-email-dinguyen@altera.com>
Message-ID: <1360597234.12812.3.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

I was wondering if you or Arnd can apply this series to the arm-soc
branch?

On Mon, 2013-02-04 at 14:12 -0600, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> V4:
> - Check for cpu1start_addr is valid in socfpga_boot_secondary()
> - Add Reviewed-by: Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com> for 3/4
> 
> V3:
> - Addressed comments from Olof Johansson and Russell King
> - Received Acked-by and Tested-by Stephen Warren
> - Received Signed-off-by Pavel Machek
> 
> V2:
> - Remove patch that adds clock entries in the socfpga.dtsi as this
> should accompany a rework in drivers/clk and will done in a different
> patch series.
> - Removed I-cache invalidate from v7_invalidate_l1
> - Defined cpu1-start-addr as a device tree entry
> - Removed the need to use CONFIG_VMSPLIT_2G
> 
> Dinh Nguyen (4):
>   arm: socfpga: Add new device tree source for actual socfpga HW
>   arm: socfpga: Add entries to enable make dtbs socfpga
>   arm: Add v7_invalidate_l1 to cache-v7.S
>   arm: socfpga: Add SMP support for actual socfpga harware
> 
>  .../bindings/arm/altera/socfpga-system.txt         |    2 +
>  arch/arm/boot/dts/Makefile                         |    2 +
>  arch/arm/boot/dts/socfpga.dtsi                     |   22 +++----
>  arch/arm/boot/dts/socfpga_cyclone5.dts             |   34 ++++++++++-
>  arch/arm/boot/dts/socfpga_vt.dts                   |   64 ++++++++++++++++++++
>  arch/arm/mach-imx/headsmp.S                        |   47 --------------
>  arch/arm/mach-shmobile/headsmp.S                   |   48 ---------------
>  arch/arm/mach-socfpga/core.h                       |    4 +-
>  arch/arm/mach-socfpga/headsmp.S                    |   16 +++--
>  arch/arm/mach-socfpga/platsmp.c                    |   19 +++---
>  arch/arm/mach-socfpga/socfpga.c                    |    7 ++-
>  arch/arm/mach-tegra/headsmp.S                      |   43 -------------
>  arch/arm/mm/cache-v7.S                             |   46 ++++++++++++++
>  13 files changed, 188 insertions(+), 166 deletions(-)
>  create mode 100644 arch/arm/boot/dts/socfpga_vt.dts
> 

Thanks,
Dinh
