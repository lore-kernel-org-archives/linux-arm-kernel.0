From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 17 Jun 2013 19:08:47 -0500
Subject: [PATCH 0/2] Fix potential merge conflict for dw_apb_timer_of 
Message-ID: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi Arnd/Olof,

Because of the following patch series that is currently in arm-soc/for-next:

10021488997317d1121505a7ac659124c058efed clocksource: dw_apb_timer_of: use clocksource_of_init
1b4eca0f634be2a99f2baa6c29dfd183590ead3f clocksource: dw_apb_timer_of: select DW_APB_TIMER
a8b447f2bbbba737ff4478f498d7f83c75a9461b clocksource: dw_apb_timer_of: add clock-handling
a1198f83407ae3421f3f58355a0f296d5ea6249c clocksource: dw_apb_timer_of: enable the use the clocksource as sched clock

there will be a merge conflict with:

55a68c23e0a675b2b8ac2656fd6edbf98b78e4c6 dw_apb_timer_of.c: Remove parts that were picoxcell-specific

that is currently in John Stultz's tree fortglx/3.11/time.

The following 2 patches will eliminate the need for the patch in John
Stultz's tree. If there is to be merge of the 2 trees, then the
patch:

dw_apb_timer_of.c: Remove parts that were picoxcell-specific

can be removed from John's tree to avoid a merge-conflict.

Based on arm-soc/for-next:

PATCH[1/2] - Rename "dw-apb-timer-osc" and "dw-apb-timer-sp" bindings to just
"dw-apb-timer"
PATCH[2/2] - Fix user/system reporting by fixing read_sched_clock()

Thanks,
Dinh

Dinh Nguyen (2):
  ARM: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to just
    dw-apb-timer
  clocksource: dw_apb_timer_of: Fix read_sched_clock

 Documentation/devicetree/bindings/rtc/dw-apb.txt |   21 +++------------------
 arch/arm/boot/dts/socfpga.dtsi                   |   12 ++++++++----
 drivers/clocksource/dw_apb_timer_of.c            |    7 +++----
 3 files changed, 14 insertions(+), 26 deletions(-)


CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Jamie Iles <jamie@jamieiles.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Pavel Machek <pavel@denx.de>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org

-- 
1.7.9.5
