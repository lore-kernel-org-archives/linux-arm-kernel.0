From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 17 Apr 2015 11:50:18 +0100
Subject: [PATCH 0/5] Add st_lpc clocksource timer driver.
Message-ID: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following on from the discussion here
https://www.mail-archive.com/devicetree at vger.kernel.org/msg68857.html

This series adds the st_lpc clocksource driver found on stih407 family
silicon. Regardless of whether the change referenced above actually gets
merged, adding this alternative clocksource driver is useful so that we
can activate cpufreq upstream on stih407 family.

regards,

Peter.

Peter Griffin (5):
  clocksource: st_lpc: Add LPC timer as a clocksource.
  clocksource: st_lpc: Add DT bindings documentation for lpc timer
  MAINTAINERS: Add st_lpc.c to ARCH/STI section of maintainers
  ARM: sti: Always enable CLKSRC_ST_LPC_CLOCK
  ARM: DT: STi: STiH407: Add DT node for st-lpc timer.

 .../devicetree/bindings/timer/st,lpc-timer.txt     |  15 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |   7 +
 arch/arm/mach-sti/Kconfig                          |   7 +-
 drivers/clocksource/Kconfig                        |  16 +++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/st_lpc.c                       | 154 +++++++++++++++++++++
 7 files changed, 198 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/st,lpc-timer.txt
 create mode 100644 drivers/clocksource/st_lpc.c

-- 
1.9.1
