From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 21 Jun 2015 18:00:45 +0800
Subject: [PATCH v2 0/2] add support holding 24Mhz osc during suspend
Message-ID: <1434880847-29505-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the usb-phy clocks are not connected to the 32khz clock-in, they
only have 24Mhz as the clock source. If we want to wake up system via
usb device, we should hold the 24Mhz osc during suspend.
This Patch has tested on chromebook jerry board, with another patch[0],
we can wakeup system via usb keyboard.

[0] https://chromium-review.googlesource.com/#/c/277811/3


Chris Zhong (2):
  ARM: rockchip: add support holding 24Mhz osc during suspend
  ARM: rockchip: remove some useless macro in pm.h

 arch/arm/mach-rockchip/pm.c | 38 ++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-rockchip/pm.h |  7 -------
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
1.9.1
