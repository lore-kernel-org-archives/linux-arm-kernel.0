From: ido@wizery.com (Ido Yariv)
Date: Sun, 10 Jul 2011 16:14:33 +0300
Subject: [PATCH v2 0/6] arm: davinci: DA850: wl12xx expansion card
Message-ID: <1310303679-17936-1-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series adds support for an optional wl12xx based expansion
card for the AM18x EVM:
http://processors.wiki.ti.com/index.php/AM18x_%2B_WL1271

The first couple of patches address issues which had to be fixed for this
series to work. However, these should be fixed regardless of the wl12xx
daughter board support.

Only the Wi-Fi functionality of the expansion card is supported. Bluetooth
functionality is not yet supported.

The patches are based on v3.0-rc6.

Changes from v1:
* Explicitly set the default queue for all channel controllers on all
  platforms. As it makes little sense to set DA850's default queue to an
  invalid value and then fix it, merge the two patches
* Move pinmux configurations to separate patches
* Remove FREF Kconfig entry, use a default value of 38MHz instead
* Use msleep for long delays, usleep_range for shorter ones
* Minor cleanups

Ido.


Ido Yariv (6):
  arm: davinci: Fix low level gpio irq handlers' argument
  arm: davinci: Explicitly set channel controllers' default queues
  arm: davinci: mmc: Add support for set_power callback
  arm: davinci: DA850: Add MMC/SD1 pinmux configuration
  arm: davinci: DA850: Add GPIO pinmux configuration for wl1271
  arm: davinci: DA850: Add wl1271/wlan support

 arch/arm/mach-davinci/Kconfig             |   10 +++
 arch/arm/mach-davinci/board-da850-evm.c   |  127 +++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c             |    9 ++
 arch/arm/mach-davinci/devices-da8xx.c     |    3 +
 arch/arm/mach-davinci/devices-tnetv107x.c |    1 +
 arch/arm/mach-davinci/dm355.c             |    1 +
 arch/arm/mach-davinci/dm644x.c            |    1 +
 arch/arm/mach-davinci/dm646x.c            |    1 +
 arch/arm/mach-davinci/dma.c               |    2 -
 arch/arm/mach-davinci/gpio.c              |   32 +++++++-
 arch/arm/mach-davinci/include/mach/mmc.h  |    3 +
 arch/arm/mach-davinci/include/mach/mux.h  |   10 +++
 drivers/mmc/host/davinci_mmc.c            |   13 +++
 13 files changed, 207 insertions(+), 6 deletions(-)

-- 
1.7.4.1
