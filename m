From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  4 Nov 2014 13:00:37 -0300
Subject: [PATCH 0/2] Farewell Armada 375 Z1 support
Message-ID: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As we recently discussed [1], the Armada 375 Z1 stepping is no longer supported.

Once the 25 MHz reference clock patches are merged, watchdog and clocksource
will stop working properly [2]. Also, the ethernet driver for Armada 375 SoC
(mvpp2) never supported the Z1 stepping.

These two patches remove the thermal quirk needed for Z1, which currently is
the only piece that explicitly mentions Z1.

[1] http://www.spinics.net/lists/arm-kernel/msg374443.html
[2] http://www.spinics.net/lists/arm-kernel/msg371524.html

Ezequiel Garcia (2):
  thermal: armada: Remove support for A375-Z1 SoC
  ARM: mvebu: Remove thermal quirk for Z1 SoC

 .../devicetree/bindings/thermal/armada-thermal.txt |  8 ---
 arch/arm/mach-mvebu/board-v7.c                     | 66 +---------------------
 drivers/thermal/armada_thermal.c                   | 20 -------
 3 files changed, 1 insertion(+), 93 deletions(-)

-- 
2.1.0
