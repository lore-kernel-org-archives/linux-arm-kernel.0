From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 May 2014 08:13:13 +0100
Subject: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for v3.16
In-Reply-To: <1401214140-9828-1-git-send-email-tony@atomide.com>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
Message-ID: <20140528071313.GH4227@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Tony, here's the pull-request:

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-omap-v3.16-1

for you to fetch changes up to 43fef47f94a1ae46fb2720dada32fa3b5547bee2:

  mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle (2014-05-28 08:06:18 +0100)

----------------------------------------------------------------
Second immutable branch between MFD and OMAP due for the v3.16 merge window.

----------------------------------------------------------------
Tony Lindgren (7):
      mfd: twl-core: Fix idle mode signaling for omaps when booted with device tree
      mfd: twl4030-power: Fix hang on reboot if sleep configuration was loaded earlier
      mfd: twl4030-power: Fix some defines for SW_EVENTS
      mfd: twl4030-power: Add generic reset configuration
      mfd: twl4030-power: Add recommended idle configuration
      mfd: twl4030-power: Add support for board specific configuration
      mfd: twl4030-power: Add a configuration to turn off oscillator during off-idle

 .../devicetree/bindings/mfd/twl4030-power.txt      |  17 +-
 arch/arm/mach-omap2/omap_twl.c                     |  60 -----
 drivers/mfd/twl-core.c                             |  15 ++
 drivers/mfd/twl4030-power.c                        | 286 +++++++++++++++++++--
 include/linux/i2c/twl.h                            |   4 +
 5 files changed, 296 insertions(+), 86 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
