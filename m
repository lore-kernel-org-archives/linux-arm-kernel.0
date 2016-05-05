From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  5 May 2016 15:53:23 +0000
Subject: [PATCH 0/5] clk: bcm2835: add flags for mash and parent clocks
Message-ID: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Allow flags to be set on a per clock index basis, which control:
* the parent clocks selected when not setting clocks explicitly
* the clock mode with regards to integer only or higher order mash

These flags can also get set via the device tree.

Default flags:
* avoid the use of testdebug clocks for all clocks
* avoid pllc_* for per clocks
* allow fractional clocks, but not higher order mash

Other flags can easily get added if the need arrises.

Martin Sperl (5):
  dt: bindings: add means to control flags of specific clocks
  clk: bcm2835: expose the parent clocks via include/dt-bindings
  clk: bcm2835: enable default filtering for parent clocks
  clk: bcm2835: allow setting clocks flags via the dt
  clk: bcm2835: add support for BCM2835_CLOCK_FLAG_USE_MASH/INTEGER

 .../bindings/clock/brcm,bcm2835-cprman.txt         |  14 ++
 drivers/clk/bcm/clk-bcm2835.c                      | 202 +++++++++++++++++----
 include/dt-bindings/clock/bcm2835.h                |  33 ++++
 3 files changed, 216 insertions(+), 33 deletions(-)

--
2.1.4
