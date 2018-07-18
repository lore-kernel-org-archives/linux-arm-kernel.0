From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Thu, 19 Jul 2018 01:57:02 +0200
Subject: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap accessors for
 data I/O
Message-ID: <20180718235710.18242-1-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure").

 arch/arm/mach-omap1/board-ams-delta.c |   22 -
 drivers/gpio/gpio-omap.c              |   88 ++++++
 drivers/mtd/nand/raw/ams-delta.c      |  436 +++++++++++++++++++++-------------
 3 files changed, 376 insertions(+), 170 deletions(-)
