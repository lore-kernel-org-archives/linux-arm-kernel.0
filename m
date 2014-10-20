From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 15:34:44 +0200
Subject: [PATCH v2 2/3] ARM: zynq: Enable generic allocator
In-Reply-To: <e5623273ff5d730b54c0c7dfe306dfbb98d4f058.1413811526.git.michal.simek@xilinx.com>
References: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
 <e5623273ff5d730b54c0c7dfe306dfbb98d4f058.1413811526.git.michal.simek@xilinx.com>
Message-ID: <3551714.krTvviG9Ue@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 October 2014 15:25:32 Michal Simek wrote:
> Enable generic allocator by default because it is used by OCMC driver.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>


Why doesn't the driver select this then?

	Arnd

> 
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index aaa5162c1509..d447adefd397 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -5,6 +5,7 @@ config ARCH_ZYNQ
>         select ARM_GIC
>         select ARM_GLOBAL_TIMER if !CPU_FREQ
>         select CADENCE_TTC_TIMER
> +       select GENERIC_ALLOCATOR
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
>         select ICST
> 
