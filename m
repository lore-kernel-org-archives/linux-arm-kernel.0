From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:15:38 +0100
Subject: [PATCH 0/3] ARM: davinci: hawk: fix mmc gpio declaration
Message-ID: <20161121161541.27048-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hawk board does not have a write protect gpio, so remove
it form the platform data. Also the card detect gpio is declared
on the wrong pin. fix it.

After fixing the platform data bugs, change to use a gpio descriptor,
so we can take advantage of the drivers recent updates, and have card
detect irq instead of polling.

DEPENDENCIES:
MMC: davinci: fix card detect and write protect
https://lkml.org/lkml/2016/11/15/592

Axel Haslam (3):
  ARM: davinci: hawk: fix mmc card detect gpio
  ARM: davinci: hawk: remove mmc ro pin
  ARM: davinci: hawk: use gpio descriptor for card detect

 arch/arm/mach-davinci/board-omapl138-hawk.c | 44 ++++++++---------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

-- 
2.9.3
