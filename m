From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Tue, 29 May 2018 19:04:31 +0200
Subject: [PATCH v3 0/5] Reintroduce i.MX EPIT Timer
Message-ID: <20180529170436.22711-1-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cl?ment Peron <clement.peron@devialet.com>

As suggested in the commit message we have added the device tree support,
proper bindings and we moved the driver into the correct folder.

Moreover we made some changes like use of relaxed IO accesor,
implement sched_clock, delay_timer and reduce the clockevents min_delta.

Changes since v2 (Thanks Fabio Estevam):
- Removed unused "ckil" clock
- Add out_iounmap
- Check and handle if clk_prepare_enable failed
- Fix comment typo

Changes since v1 (Thanks Vladimir Zapolskiy):
- Add OF dependency in Kconfig
- Sort header
- Use BIT macro
- Remove useless comments
- Fix incorrect indent
- Fix memory leak
- Add check and handle possible returned error

Cl?ment Peron (2):
  ARM: imx: remove inexistant EPIT timer init
  Documentation: DT: add i.MX EPIT timer binding

Colin Didier (3):
  clk: imx6: add EPIT clock support
  clocksource: add driver for i.MX EPIT timer
  ARM: dts: imx6qdl: add missing compatible and clock properties for
    EPIT

 .../devicetree/bindings/clock/imx6q,epit.txt  |  24 ++
 arch/arm/boot/dts/imx6qdl.dtsi                |  10 +
 arch/arm/mach-imx/common.h                    |   1 -
 drivers/clk/imx/clk-imx6q.c                   |   2 +
 drivers/clocksource/Kconfig                   |  12 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-imx-epit.c          | 283 ++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h     |   4 +-
 8 files changed, 335 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt
 create mode 100644 drivers/clocksource/timer-imx-epit.c

-- 
2.17.0
