From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 10 Sep 2013 14:12:10 +0200 (CEST)
Subject: [PATCH v2 00/03] ARM: shmobile: r8a7790 APMU SMP support
In-Reply-To: <20130828232148.7321.45739.sendpatchset@w520>
References: <20130828232148.7321.45739.sendpatchset@w520>
Message-ID: <Pine.LNX.4.64.1309101410570.16010@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Aug 2013, Magnus Damm wrote:

> ARM: shmobile: r8a7790 APMU SMP support
> 
> [PATCH v2 01/03] ARM: shmobile: Shared APMU SMP support code without DT
> [PATCH v2 02/03] ARM: shmobile: Add r8a7790 SMP support using APMU code
> [PATCH v2 03/03] ARM: shmobile: Add r8a7790 CA15 CPU cores
> 
> This series adds SMP support to r8a7790 using the included APMU code.
> The previous version of r8a7790 support depended on the APMU code in 
> "[PATCH] ARM: shmobile: Shared APMU SMP support code", but in this
> version the APMU code has been reworked to not use DT. In the future
> r8a73a4 and other SoCs may make use of the APMU as well, but the 
> r8a73a4 code first needs to be adjusted to work with the CCI driver.
> 
> With these patches applied r8a7790 CA15 support for SMP boot
> and CPU Hotplug is known to be working.
> 
> Thanks to Sudeep for his feedback.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

On Lager, for all 3 patches

Tested-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks
Guennadi

> ---
> 
>  Written against renesas.git renesas-devel-20130829
> 
>  arch/arm/boot/dts/r8a7790.dtsi                 |   21 ++
>  arch/arm/mach-shmobile/Makefile                |    1 
>  arch/arm/mach-shmobile/board-lager-reference.c |    1 
>  arch/arm/mach-shmobile/board-lager.c           |    1 
>  arch/arm/mach-shmobile/include/mach/common.h   |    6 
>  arch/arm/mach-shmobile/include/mach/r8a7790.h  |    1 
>  arch/arm/mach-shmobile/platsmp-apmu.c          |  178 ++++++++++++++++++++++++
>  arch/arm/mach-shmobile/setup-r8a7790.c         |    1 
>  arch/arm/mach-shmobile/smp-r8a7790.c           |   67 +++++++++
>  9 files changed, 277 insertions(+)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
