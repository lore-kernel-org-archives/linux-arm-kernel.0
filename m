From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Dec 2015 12:27:42 +0000
Subject: [RFC PATCH 0/5] arm64: prepare for basic Allwinner support
Message-ID: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a first step for introducing support for the Allwinner A64
SoC that made a recent appearance on the Pine A64 board featured on
Kickstarter.
This mini-series prepares the ground by allowing ARCH_SUNXI to be
defined for an arm64 kernel.
The patches fix some minor warnings which appear when Allwinner
(aka. sunxi) drivers are compiled for a 64-bit architecture.

Due to a lack of official documentation and hardware availability
this doesn't go any further at this moment.

Please have a look and comment!

Cheers,
Andre.

Andre Przywara (5):
  drivers: sunxi-rsb: fix error output type
  crypto: sunxi-ss: fix min3() call to match types
  crypto: sunxi-ss: fix dev_dbg() output type
  irqchip: sun4i: fix compilation outside of arch/arm
  arm64: Introduce Allwinner SoC config option

 arch/arm64/Kconfig.platforms              |  5 +++++
 drivers/bus/sunxi-rsb.c                   |  4 ++--
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 14 +++++++-------
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c   |  8 ++++----
 drivers/irqchip/irq-sun4i.c               |  1 -
 5 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.5.1
