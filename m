From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 20 Nov 2012 13:42:33 +0100
Subject: [PATCH 3/3] ARM: zynq: add support for ARCH_MULTIPLATFORM
In-Reply-To: <9bdc33093c6a5c22b180ef45b486edb575f87da3.1353349191.git.josh.cartwright@ni.com>
References: <cover.1353349191.git.josh.cartwright@ni.com>
 <9bdc33093c6a5c22b180ef45b486edb575f87da3.1353349191.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3d+UEdgHVALa9a7pqKPpKbZdoPOWzMPcTXpJ0TY7YofzRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/19 Josh Cartwright <josh.cartwright@ni.com>:
> The majority of changes are necessary to remove dependencies on header
> files within arch/arm/mach-zynq/include/mach:
>
>   uncompress.h
>     - Deleted. It is unused for ARCH_MULTIPLATFORM builds.
>
>   uart.h:
>     - Move uart definitions out of uart.h into debug/zynq.S, which is
>       now the only user
>
>   zynq_soc.h:
>     - Move SCU address definitions into common.c.
>     - Other #defines, such as PERIPHERAL_CLOCK_RATE, TTC0_BASE, etc, are
>       unused and can be dropped
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/Kconfig                             | 14 ++------
>  arch/arm/include/debug/zynq.S                | 20 +++++++++--
>  arch/arm/mach-zynq/Kconfig                   | 13 +++++++
>  arch/arm/mach-zynq/common.c                  |  8 ++---
>  arch/arm/mach-zynq/include/mach/uart.h       | 25 --------------
>  arch/arm/mach-zynq/include/mach/uncompress.h | 51 ----------------------------
>  arch/arm/mach-zynq/include/mach/zynq_soc.h   | 49 --------------------------
>  7 files changed, 37 insertions(+), 143 deletions(-)
>  create mode 100644 arch/arm/mach-zynq/Kconfig
>  delete mode 100644 arch/arm/mach-zynq/include/mach/uart.h
>  delete mode 100644 arch/arm/mach-zynq/include/mach/uncompress.h
>  delete mode 100644 arch/arm/mach-zynq/include/mach/zynq_soc.h

Tested-by: Michal Simek <michal.simek@xilinx.com>

Applied to xilinx arm-next branch.

Thanks,
Michal
