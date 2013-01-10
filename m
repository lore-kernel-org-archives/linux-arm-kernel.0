From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 10 Jan 2013 04:10:22 +0000
Subject: [PATCH 0/7] HWMOD fixes for AM33xx PWM submodules and device
 tree nodes.
In-Reply-To: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
References: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA5A503@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, Jan 02, 2013 at 18:54:47, Philip, Avinash wrote:
> This patch series is being part of [1] and resubmitting on top of 3.8-rc1 to
> make it to 3.9.
> 
> In AM33xx PWM sub modules like ECAP, EHRPWM & EQEP are  integrated to
> PWM subsystem. All these submodules shares the resources (clock) & has
> a clock gating register in PWM Subsystem. So a parent PWM subsystem
> driver is created. To support PWM subsystem driver, parent child
> relation is created in HWMOD entry in patch #2.
> 
> In addition EHRPWM module requires explicit clock gating from control
> module. Hence add clock node for tbclk handling in patch #4.
> 
> Patch #3 to support common clock migration for AM33xx.
> 
> Also Device tree nodes populated to support parent child relation
> between PWMSS, ECAP & EHRPWM submodules (patch #5, 6 & 7).
> 
> This patch series based on linux_omap/master [2] and tested for
> backlight with ECAP on AM335x-evm & AM335x-evmsk.

Are there any reviews on this patch series?
This patch set is required for LCD backlight work based on ECAP PWM
in am335x-evm & am335x-evmsk.

Thanks
Avinash

> 
> 1. https://lkml.org/lkml/2012/11/27/120
> 2. http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=c4e2e79ff7c9f4fdad7da432c6b449121cc3033e
> 
> Philip Avinash (7):
>   ARM: OMAP: AM33xx hwmod: Corrects PWM subsystem HWMOD entries
>   ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM
>     subsystem
>   pwm: pwm-tiehrpwm: Update the clock handling of pwm-tiehrpwm driver
>   ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
>   ARM: dts: AM33XX: Add PWMSS device tree nodes
>   ARM: dts: AM33XX: Add PWM backlight DT data to  am335x-evm
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk
> 
>  arch/arm/boot/dts/am335x-evm.dts           |   23 ++
>  arch/arm/boot/dts/am335x-evmsk.dts         |   23 ++
>  arch/arm/boot/dts/am33xx.dtsi              |   84 ++++++
>  arch/arm/mach-omap2/cclock33xx_data.c      |   30 +++
>  arch/arm/mach-omap2/control.h              |    8 +
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  390 ++++++++++++++++++----------
>  drivers/pwm/pwm-tiehrpwm.c                 |    4 +-
>  7 files changed, 417 insertions(+), 145 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> 
