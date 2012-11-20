From: monstr@monstr.eu (Michal Simek)
Date: Tue, 20 Nov 2012 13:41:16 +0100
Subject: [PATCH 1/3] ARM: zynq: remove TTC early mapping
In-Reply-To: <1443f143846f22125e3d6631cf3a2fdf75d925d3.1353349191.git.josh.cartwright@ni.com>
References: <cover.1353349191.git.josh.cartwright@ni.com>
 <1443f143846f22125e3d6631cf3a2fdf75d925d3.1353349191.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3dK2AEGh72XMuPSyBCV1sdM6jDvdiyPdh5VGXhTnwOqWTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/19 Josh Cartwright <josh.cartwright@ni.com>:
> Now that the TTC driver has proper support for DT bindings, it is not
> necessary for the registers to be mapped early.  They will be mapped
> during clock initialization using of_iomap().  Remove the early mapping.
>
> In addition, remove the extraneous zynq_soc.h include from the timer
> driver.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/mach-zynq/common.c                | 5 -----
>  arch/arm/mach-zynq/include/mach/zynq_soc.h | 6 +-----
>  arch/arm/mach-zynq/timer.c                 | 1 -
>  3 files changed, 1 insertion(+), 11 deletions(-)

Tested-by: Michal Simek <michal.simek@xilinx.com>

Applied to xilinx arm-next branch.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
