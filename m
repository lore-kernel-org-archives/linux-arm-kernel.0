From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 23 Jun 2015 20:53:38 +0800
Subject: [PATCH v3 0/2] add support holding 24Mhz osc during suspend
Message-ID: <1435064020-7057-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the usb-phy clocks are not connected to the 32khz clock-in, they
only have 24Mhz as the clock source. If we want to wake up system via
usb device, we should hold the 24Mhz osc during suspend.
This Patch has tested on chromebook jerry board, with another patch[0],
we can wakeup system via usb keyboard.

[0] https://chromium-review.googlesource.com/#/c/277811/3

Changes in v3:
- Fixed commenting style
- Move the #define-s above the rk3288_slp_disable_osc function

Chris Zhong (2):
  ARM: rockchip: add support holding 24Mhz osc during suspend
  ARM: rockchip: remove some useless macro in pm.h

 arch/arm/mach-rockchip/pm.c | 40 ++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-rockchip/pm.h |  7 -------
 2 files changed, 38 insertions(+), 9 deletions(-)

-- 
1.9.1
