From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 15 May 2014 22:15:48 +0200
Subject: [PATCH 0/4] Fixes for DT CPU topology specification on Exynos
In-Reply-To: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
Message-ID: <53752074.3020205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 18.04.2014 16:42, Tomasz Figa wrote:
> Due to some parts of Exynos SoC support designed originally in a non-scalable
> way, relying on 1:1 mapping between value returned by cpu_logical_map() and
> CPU IDs as seen by PMU and GIC, trying to specify CPU topology in device tree
> caused various boot-up issues on Exynos SoCs, ranging from CPUs other than 0
> failing to boot to crashes due to GIC driver accessing registers out of range.
> 
> This series attempts to fix aforementioned issues by removing incorrect
> assumptions from Exynos SoC core code and GIC driver and then adding CPU
> topology data to device tree sources of Exynos4.
> 
> [On Exynos4210-based TRATS and Exynos4412-based TRATS2 board]
> Tested-by: Tomasz Figa <t.figa@samsung.com>
> 
> Tomasz Figa (4):
>   ARM: EXYNOS: Fix definitions of S5P_ARM_CORE_* registers
>   ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
>   irqchip: gic: Add support for per CPU bank offset specification in DT
>   ARM: dts: exynos4: Add CPU topology data
> 
>  Documentation/devicetree/bindings/arm/cpus.txt |  7 ++
>  Documentation/devicetree/bindings/arm/gic.txt  | 34 +++++++++-
>  arch/arm/boot/dts/exynos4210.dtsi              | 19 ++++++
>  arch/arm/boot/dts/exynos4212.dtsi              | 19 ++++++
>  arch/arm/boot/dts/exynos4412.dtsi              | 37 ++++++++--
>  arch/arm/mach-exynos/hotplug.c                 | 10 +--
>  arch/arm/mach-exynos/platsmp.c                 | 31 +++++----
>  arch/arm/mach-exynos/regs-pmu.h                |  4 +-
>  drivers/irqchip/irq-gic.c                      | 94 ++++++++++++++++++--------
>  9 files changed, 202 insertions(+), 53 deletions(-)
> 

Please drop patches 3 and 4 from this series, as patch 3 needs a bit
more work and 4 depends on 3.

Having patches 1 and 2 applied regardless would be nice, though.

Best regards,
Tomasz
