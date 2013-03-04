From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  4 Mar 2013 15:05:39 +0100
Subject: [PATCH 0/9] rtc: stmp3xxx: DT bindings and wakealarm
Message-ID: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series touches multiple things in the stmp3xxx RTC:
        - DT bindings and selection for the crystal
        - add sysfs entry for persistent regs 1-5
        - check the copy controller on all writes/reads

Sorry for the multiple topics. If need be, I can split this up in multiple
series, but the series is in itself a little interdependent.

The series is based on v3.9-rc1.

Regards,
Steffen


Juergen Beisert (5):
  MXS/i.MX28: add the possibility to define the used crystals via
    device tree
  MXS/i.MX28: add the possibility to define the external RTC crystal
  MXS/i.MX28: prepare different clocking of the built-in RTC
  MXS/i.MX28: there is more than one way to clock the RTC
  MXS/i.MX28: enable RTC to wakeup the system

Steffen Trumtrar (4):
  rtc: stmp3xxx: add sysfs entries for persistent regs
  rtc: stmp3xxx: Re-enable active alarm
  rtc: stmp3xxx: Check copy controller state
  rtc: stmp3xxx: Replace wait_time function

 arch/arm/boot/dts/imx28.dtsi |   19 +++
 drivers/clk/mxs/clk-imx28.c  |   20 ++-
 drivers/rtc/rtc-stmp3xxx.c   |  275 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 297 insertions(+), 17 deletions(-)

-- 
1.7.10.4
