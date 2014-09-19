From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 19 Sep 2014 12:26:11 +0200
Subject: [PATCH v10 0/6] Add Maxim 77802 RTC support
Message-ID: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

This series add support for the Real Time clock present in
the Maxim 77802 Power Managment IC. The version number is
quite high because it previously was part of a bigger series
[0] that aimed to add support for all the devices in the
max77802 PMIC. But now that the max77802 dependencies were
already merged for 3.17, the series were split but I kept
the version numbering.

While working on the max77802 rtc support a lot of feedback
was given and the issues pointed out also apply to a driver
for a similar PMIC RTC (max77686). So patches 01/06 to 05/06
in the series are cleanups for the max77686 driver and patch
06/06 adds the support for the max77802 RTC.

This version address the issues pointed out on the previous
version [1] and changelog are present on each patch when is
applicable.

The series were tested on an Exynos5250 Snow (max77686) and
Exynos5420 Peach Pit (max77802) machines and applies cleanly
to both 3.17-rc1 and today's linux-next (20140919).

NOTE: The patches from the previous version [1] were already
present in the -mm tree [2] so I didn't know if I should had
sent this as a delta or as a new revision. I decided to do
the later but please let me know if you expected the former.

Doug Anderson (1):
  rtc: max77686: Allow the max77686 rtc to wakeup the system

Javier Martinez Canillas (5):
  rtc: max77686: Remove dead code for SMPL and WTSR.
  rtc: max77686: Fail to probe if no RTC regmap irqchip is set
  rtc: max77686: Remove unneded info log
  rtc: max77686: Use ffs() to calculate tm_wday
  rtc: Add driver for Maxim 77802 PMIC Real-Time-Clock

 drivers/rtc/Kconfig        |  10 +
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-max77686.c | 139 +++----------
 drivers/rtc/rtc-max77802.c | 501 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 542 insertions(+), 109 deletions(-)
 create mode 100644 drivers/rtc/rtc-max77802.c

[0]: http://lwn.net/Articles/605350/
[1]: https://lkml.org/lkml/2014/9/12/87
[2]: http://ozlabs.org/~akpm/mmots/series
