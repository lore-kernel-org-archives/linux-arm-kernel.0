From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 18 Dec 2016 00:01:21 +0200
Subject: [BISECTED] v4.9: OMAP MMC regression
Message-ID: <20161217220120.xgyzq2hwxn3lsmm2@raspberrypi-2.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

OMAP MMC is silently missing when booting v4.9 on Nokia 770 (OMAP1).

Bisected to:

commit 2d1a9a946faebfedd660a1f1c2b90984fff41f91
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Wed Jul 20 11:50:29 2016 +0300

    dmaengine: omap-dma: Dynamically allocate memory for lch_map

Reveting the commit makes MMC to appear and work again...

A.
