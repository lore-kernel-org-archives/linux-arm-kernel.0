From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 18 Aug 2014 10:34:32 +0200
Subject: [PATCH v9 0/5] Add Maxim 77802 RTC support
Message-ID: <1408350877-15921-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alessandro,

This series add support for the Real Time clock present in
the Maxim 77802 Power Managment IC. Previously, the series
was part of a bigger one [0] that aimed to add support for
all the devices in the max77802 PMIC. But now the max77802
dependencies were already merged for 3.17 so the series can
be split and each driver can go through the relevant tree.

While working on the max77802 rtc support a lot of feedback
was given and the issues pointed out also apply to a driver
for a similar PMIC RTC (max77686). So patches 01/05 to 04/05
in the series are cleanups for the max77686 driver and patch
05/05 adds the support for the max77802 RTC.

I kept the version numbering from the old series so this is
version 9 although there were no changes on the max77802 rtc
driver since v6 of the old series, only patches 03 and 04 were
added on this version which are cleanups for the max77686 rtc.

The series were tested on an Exynos5250 Snow (max77686) and
Exynos5420 Peach Pit (max77802) machines and applies cleanly
to both 3.17-rc1 and today's linux-next (20140818).

Doug Anderson (1):
  rtc: max77686: Allow the max77686 rtc to wakeup the system

Javier Martinez Canillas (4):
  rtc: max77686: Remove dead code for SMPL and WTSR.
  rtc: max77686: Fail to probe if no RTC regmap irqchip is set
  rtc: max77686: Remove unneded info log
  rtc: Add driver for Maxim 77802 PMIC Real-Time-Clock

 drivers/rtc/Kconfig        |  10 +
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-max77686.c | 127 +++--------
 drivers/rtc/rtc-max77802.c | 513 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 553 insertions(+), 98 deletions(-)
 create mode 100644 drivers/rtc/rtc-max77802.c

Best regards,
Javier

[0]: http://lwn.net/Articles/605350/
