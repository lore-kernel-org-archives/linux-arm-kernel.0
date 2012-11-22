From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:16:16 +0100
Subject: [PATCH v4 00/11] Support for AM33xx PWM Subsystem
In-Reply-To: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122211616.GK16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:40:57PM +0530, Philip, Avinash wrote:
> In AM33xx PWM sub modules like ECAP, EHRPWM & EQEP are  integrated to
> PWM subsystem. All these submodules shares the resources (clock) & has
> a clock gating register in PWM Subsystem. This patch series creates a
> parent PWM Subsystem driver to handle access synchronization of shared
> resources & clock gating from PWM Subsystem configuration space.
> Also Device tree nodes populated to support parent child relation
> between PWMSS, ECAP & EHRPWM submodules.
> In addition EHRPWM module requires explicit clock gating from control
> module & is handled by patch #2 & 8.
> 
> As suggested by  Thierry for handling clock gating for PWM submodules
> should handle with a global function. This requires config space
> handling done independent from driver and is done at parent driver.
> 
> So the parent<->child relation adopted to handle
> 1. pm runtime synchronization
> 2. PWM subsystem common config space clock gating for PWM submodules.
> 
> Patches supports
> - Driver support for parent child relation handled patch #1
> - Optional EHRPWM tb clock in patch #2
> - Parent child in HWMOD handled at patch #3
> - Device tree binding support handled in patch #4, 6 &8
> - pinctrl support in patch #5 & 7.
> - DT node populated in patch #9 ,10 & 11.
> 
> This patch series based on omap_dt/for_3.8/dts_part2 and tested
> on am335x-evm & am335x-evmsk.
> 
> It depends on [1]
> 
> 1. https://lkml.org/lkml/2012/11/21/70
> pwm: Device tree support for PWM polarity
> 
> Changes since v3:
> 	- Rebased on top of omap_dt/for_3.8/dts_part2
> 	- Add pwm backlight for am335xevm_sk
> 	- Moved tipwmss.h to pwm-tipwmss.h
> 
> Philip, Avinash (11):
>   PWMSS: Add PWM Subsystem driver for parent<->child relationship
>   ARM: am33xx: clk: Add optional clock for EHRPWM
>   ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM
>     subsystem
>   pwm: pwm-tiecap: Add device-tree binding support for APWM driver
>   pwm: pwm-tiecap: pinctrl support
>   pwm: pwm-tiehrpwm: Add device-tree binding support for EHRPWM driver
>   pwm: pwm-tiehrpwm: pinctrl support
>   pwm: pwm-tiehrpwm: Adding TBCLK gating support.
>   ARM: dts: AM33XX: Add PWMSS device tree nodes
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk

Hi,

So how do you want to get this merged? Should I take patches 1, 4, 5, 6,
7 and 8 while the rest go through some ARM tree? Can we still merge this
for 3.8? The patches don't seem to have build dependencies on each other
but how about runtime dependencies?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/6f2ecaea/attachment.sig>
