From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 31 May 2016 11:49:56 +0200
Subject: [PATCH 0/2] clocksource: Add support for Oxford Semiconductor RPS
 Dual Timer
Message-ID: <1464688198-9655-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds driver for the Oxford Semiconductor RPS Dual Timer as base of the OX810SE
clock tick event and sched clock source.

This driver was posted with the initial OX810SE platform patchset at :
http://lkml.kernel.org/r/1457005210-18485-5-git-send-email-narmstrong at baylibre.com
and
http://lkml.kernel.org/r/1457005210-18485-6-git-send-email-narmstrong at baylibre.com

But since the SP804 was very similar, I decided to adapt it for OX810SE usage.
For some reasons, the SP804 has a lot of legacy code for non-dt, non-multiarch
platforms and needs a complete rewrite.
For now, this adds a dedicated driver with the same bindings as intended for SP804.

Neil Armstrong (2):
  clocksource: Add Oxford Semiconductor RPS Dual Timer
  dt-bindings: clocksource: Add Add Oxford Semiconductor RPS Timer
    bindings

 .../devicetree/bindings/timer/oxsemi,rps-timer.txt |  17 ++
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-oxnas-rps.c              | 273 +++++++++++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
 create mode 100644 drivers/clocksource/timer-oxnas-rps.c

-- 
1.9.1
