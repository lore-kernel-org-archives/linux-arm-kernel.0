From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:04:51 +0100
Subject: [PATCH v2 0/3] ARM: davinci: use gpio descriptors for mmc pins
Message-ID: <20161124150454.23899-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the boards that use gpios managed by the davinci gpio driver,
we can use gpio descriptors to control the the mmc pins.

This will let the mmc driver register an interrupt for the
card detect pin, and also allows us to remove the dependency
on platform callbacks for these boards.

For boards using a CPLD or an MSP the conversion is not yet done,
and they still rely on the platform callbacks and polling.
More work is needed to be able to manage those pins with gpio
descriptors. Once that is done, we would be able to remove
completely platform callbacks.

Changes v1->v2
*Convert da850-evm and da830-evm
*keep hack board pins as they are not compatible with lcdk (Sekhar)

Dependency:
This patch depends on a mmc driver patch currently in linux-next.
MMC: davinci: fix card detect and write protect
https://lkml.org/lkml/2016/11/15/592

Axel Haslam (3):
  ARM: davinci: hawk: use gpio descriptor for card detect
  ARM: davinci: da850-evm: use gpio descriptor for mmc pins
  ARM: davinci: da830-evm: use gpio descriptor for mmc pins

 arch/arm/mach-davinci/board-da830-evm.c     | 41 ++++++++--------------------
 arch/arm/mach-davinci/board-da850-evm.c     | 35 +++++++-----------------
 arch/arm/mach-davinci/board-omapl138-hawk.c | 42 ++++++++---------------------
 3 files changed, 32 insertions(+), 86 deletions(-)

-- 
2.9.3
