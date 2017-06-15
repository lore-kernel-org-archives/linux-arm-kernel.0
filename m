From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 15 Jun 2017 12:59:02 -0700
Subject: [PATCH 0/2] Broadcom STB wake-timer support
Message-ID: <20170615195904.12653-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

This patch series adds support for the Broadcom STB wake-timer. This is a 27Mhz
timer which allows the system to exit S2/S3/S5 sleep states when configured.

The wake-timer has has a long history within our internal/downstream tree, and
Brian authored it in the first place, then Markus added the rtc bits, and then I
cleaned it up for upstream.

Thanks!

Brian Norris (1):
  rtc: brcmstb-waketimer: Add Broadcom STB wake-timer

Florian Fainelli (1):
  dt-bindings: Document the Broadcom STB wake-up timer node

 .../bindings/rtc/brcm,brcmstb-waketimer.txt        |  22 ++
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-brcmstb-waketimer.c                | 345 +++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c

-- 
2.9.3
