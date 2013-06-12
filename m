From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 12 Jun 2013 14:16:38 +0200
Subject: [GIT PULL] dw_apb_timer enhancements for 3.11
Message-ID: <201306121416.39237.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

following the suggestion of Linus Walleij, a pull request for the
dw_apb_timer changes from last week with all ACKs applied.
Warning, this is my first pull request ever :-) .

The tag is signed and the key has among others a signature of Greg K-H, so
hopefully this will work.


The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git at github.com:mmind/linux-rockchip.git tags/dw_apb_timer_of

for you to fetch changes up to 10021488997317d1121505a7ac659124c058efed:

  clocksource: dw_apb_timer_of: use clocksource_of_init (2013-06-12 13:47:38 +0200)

----------------------------------------------------------------
Enhancements for dw_apb_timer:
- use DECLARE_CLOCKSOURCE_OF and convert its users
- handle the sptimer not being present as sched_clock
- add optional handling of timer clocks

----------------------------------------------------------------
Heiko Stuebner (4):
      clocksource: dw_apb_timer_of: enable the use the clocksource as sched clock
      clocksource: dw_apb_timer_of: add clock-handling
      clocksource: dw_apb_timer_of: select DW_APB_TIMER
      clocksource: dw_apb_timer_of: use clocksource_of_init

 Documentation/devicetree/bindings/rtc/dw-apb.txt |   19 +++++++++++++++++++
 arch/arm/mach-picoxcell/Kconfig                  |    1 -
 arch/arm/mach-picoxcell/common.c                 |    2 --
 arch/arm/mach-socfpga/Kconfig                    |    1 -
 arch/arm/mach-socfpga/socfpga.c                  |    2 --
 drivers/clocksource/Kconfig                      |    2 ++
 drivers/clocksource/dw_apb_timer_of.c            |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 include/linux/dw_apb_timer.h                     |    1 -
 8 files changed, 84 insertions(+), 39 deletions(-)
