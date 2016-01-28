From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 28 Jan 2016 18:19:12 +0800
Subject: [PATCH 0/4] ARM: at91: pm: add ULP1 mode support
Message-ID: <1453976356-24391-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULP1 (Ultra Low-power mode 1) is introduced by SAMA5D2.

In order to achieve the lowest power consumption, in the ULP1 mode,
all the clocks are shut off, inclusive the embedded 12MHz RC oscillator.

The fast startup signal is used as a wake up source for ULP1 mode.
As soon as the wake up event is asserted, the embedded 12MHz RC
oscillator restarts automatically, which fast startup signal
to trigger the PMC to wake up the system from the ULP1 mode can be
configured via DT.

It is based on the following patch set:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390954.html


Wenyou Yang (4):
  ARM: at91: pm: create a separate procedure for the ULP0 mode
  ARM: at91: pm: add ULP1 mode support
  ARM: at91: pm: configure PMC fast startup signals
  Documentation: atmel-at91: add DT bindings for fast startup

 .../devicetree/bindings/arm/atmel-pmc.txt          |   74 +++++++++
 arch/arm/mach-at91/pm.c                            |  112 +++++++++++++-
 arch/arm/mach-at91/pm.h                            |    7 +
 arch/arm/mach-at91/pm_suspend.S                    |  158 +++++++++++++++++---
 include/linux/clk/at91_pmc.h                       |   36 +++++
 5 files changed, 362 insertions(+), 25 deletions(-)

-- 
1.7.9.5
