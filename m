From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 12 Jun 2013 10:55:52 +0200
Subject: [PATCH v2 0/4] dw_apb_timer: osc as sched_clock,
 clocks and clocksource_of support
In-Reply-To: <201306041136.09566.heiko@sntech.de>
References: <201306041136.09566.heiko@sntech.de>
Message-ID: <201306121055.53685.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 4. Juni 2013, 11:36:09 schrieb Heiko St?bner:
> This is split off of my Rockchip support series from yesterday. It's now
> a patch more than before, as the third patch enables the timer to be used
> thru clocksource_of_init and moves picoxcell and socfpga to it.
> 
> changes since v1:
> - hopefully improve the patch description of patch 1
>   after a suggestion by Linus Walleij
> - move the selection of DW_APB_TIMER and CLKSRC_OF into DW_APB_TIMER_OF
>   after a suggestion by Baruch Siach
> 
> Heiko Stuebner (4):
>   clocksource: dw_apb_timer_of: enable the use the clocksource as sched
> clock clocksource: dw_apb_timer_of: add clock-handling
>   clocksource: dw_apb_timer_of: select DW_APB_TIMER
>   clocksource: dw_apb_timer_of: use clocksource_of_init
> 
>  Documentation/devicetree/bindings/rtc/dw-apb.txt |   19 +++++
>  arch/arm/mach-picoxcell/Kconfig                  |    1 -
>  arch/arm/mach-picoxcell/common.c                 |    2 -
>  arch/arm/mach-socfpga/Kconfig                    |    1 -
>  arch/arm/mach-socfpga/socfpga.c                  |    2 -
>  drivers/clocksource/Kconfig                      |    2 +
>  drivers/clocksource/dw_apb_timer_of.c            |   95
> ++++++++++++++------- include/linux/dw_apb_timer.h                     |  
>  1 -
>  8 files changed, 84 insertions(+), 39 deletions(-)

with clocksource_of conversion of picoxcell and socfpga, this series stands on 
its own. Is anybody going to pick it up?


Thanks
Heiko
