From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Wed, 10 Oct 2018 09:42:15 -0500
Subject: [PATCH 0/4] Add SOCFPGA System Manager
In-Reply-To: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
On 09/24/2018 05:09 PM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add MFD driver for ARM64 SOCFPGA System Manager to steer
> System Manager calls appropriately.
> The SOCFPGA System Manager includes registers from several
> SOC peripherals.
> 
> On ARM32, syscon handles this aggregated register grouping.
> Redirect System Manager calls to syscon for ARM32 SOCFPGA
> systems.
> 
> The ARM64 System Manager can only be accessed from priority
> level EL3 so this new MFD driver handles the calls to EL3.
> 
> Thor Thayer (4):
>    mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
>    ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>    arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>    net: stmmac: socfpga: Convert to shared System Manager driver
> 
>   MAINTAINERS                                        |   6 +
>   arch/arm/configs/socfpga_defconfig                 |   1 +
>   arch/arm64/configs/defconfig                       |   1 +
>   drivers/mfd/Kconfig                                |   9 +
>   drivers/mfd/Makefile                               |   1 +
>   drivers/mfd/altera-sysmgr.c                        | 310 +++++++++++++++++++++
>   .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
>   include/linux/mfd/altera-sysmgr.h                  | 113 ++++++++
>   8 files changed, 444 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/mfd/altera-sysmgr.c
>   create mode 100644 include/linux/mfd/altera-sysmgr.h
> 
Gentle ping.

Thor
