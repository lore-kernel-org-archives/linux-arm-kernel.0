From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 17 Mar 2015 10:10:54 +0100
Subject: [PATCH v2 0/7] ARM: mvebu: Enable perf support
In-Reply-To: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5507EF9E.2050105@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,


On 03/03/2015 11:43, Maxime Ripard wrote:
> Hi,
> 
> This patch enables the performance monitoring unit found on the Armada
> 370, 375, 38x and XP, in order to gain hardware-assisted tracing using
> perf.
> 
> Due to the way the interrupts are implemented in these SoCs, it
> required some additions to the interrupt controller in order to unmask
> the PMU interrupts.
> 
> While doing so, we reworked the way the PPI are supported, in order to
> make the driver both easier to read and to extend.
> 
> This has been tested on an Armada XP and an Armada 385, and this serie
> depends on the patch "irqchip: armada: Fix chained per-cpu interrupts"
> sent previously.
> 
> Thanks!
> Maxime
> 
> Changes from v1:
>   - Dropped the mask/unmask refactoring
>   - Rebased on top of the v2 of the chained PPI fix
> 
> Ezequiel Garcia (5):
>   irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
>   irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
>     readability
>   ARM: mvebu: Enable Performance Monitor Unit on Armada 375 SoC
>   ARM: mvebu: Enable Performance Monitor Unit on Armada 380/385 SoC
>   ARM: mvebu: Enable perf support in mvebu_v7_defconfig
> 
> Maxime Ripard (2):
>   irqchip: armada-370-xp: Enable the PMU interrupts
>   ARM: mvebu: Enable Performance Monitor Unit on Armada XP/370 SoCs
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi |  5 ++
>  arch/arm/boot/dts/armada-375.dtsi    |  5 ++
>  arch/arm/boot/dts/armada-38x.dtsi    |  5 ++
>  arch/arm/configs/mvebu_v7_defconfig  |  1 +
>  drivers/irqchip/irq-armada-370-xp.c  | 88 +++++++++++++++++++++++-------------
>  5 files changed, 73 insertions(+), 31 deletions(-)
> 


Now that patches 1-3 have been applied and are also in linux-next, I applied
patches 4-6 to mvebu/dt and pacth 7 to mvebu/defconfig

I also checked that having only patches 4 to 7 without the 3 first ones
didn't break the build or didn't make the kernel crash.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
