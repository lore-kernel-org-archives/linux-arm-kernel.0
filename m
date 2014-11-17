From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 17 Nov 2014 14:33:10 +0100
Subject: [PATCH 0/2] ARM: berlin: let RESET_CONTROLLER be user-selectable
Message-ID: <1416231192-27056-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As asked by Arnd in the Berlin USB thread[1], do not select automatically
RESET_CONTROLLER when using ARCH_BERLIN but let it be user-selectable.

To ensure the Berlin USB PHY driver still works with this change, make it
depending on RESET_CONTROLLER.

Antoine

[1] https://lkml.org/lkml/2014/11/14/415

Antoine Tenart (2):
  phy: berlin_usb: depends on RESET_CONTROLLER
  ARM: berlin: do not select RESET_CONTROLLER

 arch/arm/mach-berlin/Kconfig | 1 -
 drivers/phy/Kconfig          | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.1.0
