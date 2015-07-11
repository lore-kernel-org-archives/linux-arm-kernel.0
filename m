From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 19:28:48 +0200
Subject: [PATCH v3 0/2] RTC support for NXP LPC18xx family
Message-ID: <1436635730-15617-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the RTC found on many NXP devices
including LPC178x/18xx/408x/43xx. The RTC provides calendar and
clock functionality together with alarm interrupt support.

The driver is a rework of an old driver by Kevin Wells. It has been
modified to support modern resource allocation, device tree and
generally cleaned up. Driver was originally written to support the
LPC24xx platform but since this platform isn't upstream support has
been removed. The LPC24xx name is still kept to preserve the origin
of this hardware block.

Been a while since the last version, but this version should address
all comments from Josh and Alexandre on v2. There has also been some
rework from my side. Please have a look.

changes since v2:
 - rework hw init
 - update Kconfig text
 - remove unused registers defines
 - misc clean ups
 - rebase on 4.2-rc1

changes since v1:
 - s/lpc2k/lpc24xx for better consistency
 - fix Kconfig entry
 - drop support for old versions for the ip block

Patch set is based on Linux v4.2-rc1.

Joachim Eastwood (2):
  rtc: add rtc-lpc24xx driver
  doc: dt: add documentation for nxp,lpc1788-rtc

 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    |  21 ++
 drivers/rtc/Kconfig                                |  12 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-lpc24xx.c                          | 310 +++++++++++++++++++++
 4 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
 create mode 100644 drivers/rtc/rtc-lpc24xx.c

-- 
1.8.0
