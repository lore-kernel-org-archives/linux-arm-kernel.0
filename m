From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 15 May 2015 15:25:04 +0200
Subject: [PATCH v2 0/2] RTC support for NXP LPC18xx family
Message-ID: <1431696306-19093-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the RTC found on many NXP devices
including LPC24xx/178x/18xx/43xx. The RTC provides calendar and
clock functionality together with periodic tick and alarm interrupt
support.

The driver is a rework of an old driver by Kevin Wells. It has been
modified to support modern resource allocation, device tree and
generally cleaned up.

This version address the comments from Josh Cartwright and Alexandre
Belloni.

changes since v1:
 - s/lpc2k/lpc24xx for better consistency
 - fix Kconfig entry
 - drop support for old versions for the ip block

Patch set is based on Linux v4.1-rc1.

Base support for the NXP LPC18xx family can be found here:
http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2


Joachim Eastwood (2):
  rtc: add rtc-lpc24xx driver
  doc: dt: add documentation for nxp,lpc1788-rtc

 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    |  21 ++
 drivers/rtc/Kconfig                                |  13 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-lpc24xx.c                          | 341 +++++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
 create mode 100644 drivers/rtc/rtc-lpc24xx.c

-- 
1.8.0
