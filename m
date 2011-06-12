From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Sun, 12 Jun 2011 17:04:55 +0200
Subject: [PATCH v2 0/5] ep93xx/ts72xx patches
Message-ID: <1307891100-31123-1-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whole patchset is available on my GitHub repository[1] also.

1. https://github.com/ynezz/linux-2.6/commits/ts72xx-upstream


Changes since v1:

* incorporated Ryan's and Hartley's comments on CPLD watchdog patch
* added one more patch 5/5, which is fixing the bug in the model detection


Petr ?tetiar (5):
  ARM: ep93xx: use more reliable CPLD watchdog for reset on ts72xx
  ARM: ep93xx: add model detection for ts-7300 and ts-7400 boards
  ARM: ep93xx: increase NR_BANKS to 16 for support of 128MB RAM
  ARM: ep93xx: fix inverted RTS/DTR signals on uart1
  ARM: ep93xx: ts72xx: fix board model detection

 arch/arm/include/asm/setup.h               |    6 +++++-
 arch/arm/mach-ep93xx/core.c                |    4 ++--
 arch/arm/mach-ep93xx/include/mach/system.h |   18 +++++++++++++-----
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |   26 ++++++++++++++++++++++----
 4 files changed, 42 insertions(+), 12 deletions(-)
