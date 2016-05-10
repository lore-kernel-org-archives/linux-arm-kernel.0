From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:41 +0900
Subject: [RFC PATCH 00/21] mfd, clock,
 reset: add UniPhier clock/reset driver support
Message-ID: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds support for clock and reset (and MFD to populate them)
for UniPhier SoCs.

On UniPhier SoCs, one system control block contains various registers
for clock, reset, and others in it.

I consulted Arnd for better implementation for clock/reset drivers in such a case.
https://lkml.org/lkml/2016/4/18/605

After a while, I chose MFD approach and found it is a good fit in my case.

So, here I intentionally included clock, reset, MFD in one patch series
because they are related with one another.

I have not completed this series.  Some known problems are:
 - Binding document is missing
 - I need to fill clock/reset tables a bit more.

Please do not apply this series.

But, this sereis should be enough for reviewing
if my basic approach is OK or not.

Your feedback is appreciated.



Masahiro Yamada (21):
  mfd: uniphier: add UniPhier MFD driver
  clk: uniphier: add core support for UniPhier clock driver
  clk: uniphier: add clock driver for UniPhier PH1-LD4 SoC
  clk: uniphier: add clock driver for UniPhier PH1-Pro4 SoC
  clk: uniphier: add clock driver for UniPhier PH1-sLD8 SoC
  clk: uniphier: add clock driver for UniPhier PH1-Pro5 SoC
  clk: uniphier: add clock driver for UniPhier ProXstream2/PH1-LD6b SoC
  clk: uniphier: add clock driver for UniPhier PH1-LD11 SoC
  clk: uniphier: add clock driver for UniPhier PH1-LD20 SoC
  clk: uniphier: add clock driver for Media I/O block on UniPhier SoCs
  clk: uniphier: add clock driver for Peripheral block on UniPhier SoCs
  reset: uniphier: add core support for UniPhier reset driver
  reset: uniphier: add reset driver for UniPhier PH1-LD4 SoC
  reset: uniphier: add reset driver for UniPhier PH1-Pro4 SoC
  reset: uniphier: add reset driver for UniPhier PH1-sLD8 SoC
  reset: uniphier: add reset driver for UniPhier PH1-Pro5 SoC
  reset: uniphier: add reset driver for UniPhier ProXstream2/PH1-LD6b
    SoC
  reset: uniphier: add reset driver for UniPhier PH1-LD11 SoC
  reset: uniphier: add reset driver for UniPhier PH1-LD20 SoC
  reset: uniphier: add reset driver for Media I/O block on UniPhier SoCs
  reset: uniphier: add reset driver for Peripheral block on UniPhier
    SoCs

 MAINTAINERS                                      |   3 +
 drivers/clk/uniphier/Kconfig                     |  45 +++++
 drivers/clk/uniphier/Makefile                    |  16 ++
 drivers/clk/uniphier/clk-uniphier-core.c         |  99 +++++++++++
 drivers/clk/uniphier/clk-uniphier-fixed-factor.c |  50 ++++++
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c   |  49 ++++++
 drivers/clk/uniphier/clk-uniphier-gate.c         |  98 +++++++++++
 drivers/clk/uniphier/clk-uniphier-ld11.c         |  83 +++++++++
 drivers/clk/uniphier/clk-uniphier-ld20.c         |  83 +++++++++
 drivers/clk/uniphier/clk-uniphier-ld4.c          | 112 ++++++++++++
 drivers/clk/uniphier/clk-uniphier-mio.c          | 215 +++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-mux.c          |  96 ++++++++++
 drivers/clk/uniphier/clk-uniphier-peri.c         | 133 ++++++++++++++
 drivers/clk/uniphier/clk-uniphier-pro4.c         | 112 ++++++++++++
 drivers/clk/uniphier/clk-uniphier-pro5.c         | 102 +++++++++++
 drivers/clk/uniphier/clk-uniphier-pxs2.c         |  83 +++++++++
 drivers/clk/uniphier/clk-uniphier-sld8.c         | 102 +++++++++++
 drivers/clk/uniphier/clk-uniphier.h              |  89 ++++++++++
 drivers/mfd/Kconfig                              |   9 +
 drivers/mfd/Makefile                             |   1 +
 drivers/mfd/uniphier-mfd.c                       | 214 ++++++++++++++++++++++
 drivers/reset/Kconfig                            |   1 +
 drivers/reset/Makefile                           |   1 +
 drivers/reset/uniphier/Kconfig                   |  45 +++++
 drivers/reset/uniphier/Makefile                  |  12 ++
 drivers/reset/uniphier/reset-uniphier-core.c     | 151 ++++++++++++++++
 drivers/reset/uniphier/reset-uniphier-ld11.c     |  46 +++++
 drivers/reset/uniphier/reset-uniphier-ld20.c     |  46 +++++
 drivers/reset/uniphier/reset-uniphier-ld4.c      |  46 +++++
 drivers/reset/uniphier/reset-uniphier-mio.c      | 106 +++++++++++
 drivers/reset/uniphier/reset-uniphier-peri.c     | 101 +++++++++++
 drivers/reset/uniphier/reset-uniphier-pro4.c     |  46 +++++
 drivers/reset/uniphier/reset-uniphier-pro5.c     |  46 +++++
 drivers/reset/uniphier/reset-uniphier-pxs2.c     |  46 +++++
 drivers/reset/uniphier/reset-uniphier-sld8.c     |  46 +++++
 drivers/reset/uniphier/reset-uniphier.h          |  33 ++++
 36 files changed, 2566 insertions(+)
 create mode 100644 drivers/clk/uniphier/Kconfig
 create mode 100644 drivers/clk/uniphier/Makefile
 create mode 100644 drivers/clk/uniphier/clk-uniphier-core.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-factor.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-rate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-gate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-ld11.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-ld20.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-ld4.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mux.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-pro4.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-pro5.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-pxs2.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-sld8.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier.h
 create mode 100644 drivers/mfd/uniphier-mfd.c
 create mode 100644 drivers/reset/uniphier/Kconfig
 create mode 100644 drivers/reset/uniphier/Makefile
 create mode 100644 drivers/reset/uniphier/reset-uniphier-core.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-ld11.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-ld20.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-ld4.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-mio.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-peri.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-pro4.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-pro5.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-pxs2.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-sld8.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier.h

-- 
1.9.1
