From: svenkatr@ti.com (Venkatraman S)
Date: Mon, 1 Mar 2010 16:55:10 +0530
Subject: [PATCH 00/03] sDMA driver descriptor autoloading feature [version 5]
	and omap hsmmc driver adaptations
Message-ID: <618f0c911003010325t337bb0f4o67e2cb3b2484d767@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is introduction of new sDMA feature: descriptor
autoloading (v5)
       and its adoption by omap hsmmc driver.
Previous thread (v4 of sDMA patch, without hsmmc adoptions) is here:
http://patchwork.kernel.org/patch/66690/
Current version(s) based on for-next branch, 7b97f3ed. Tested on omap4430 sdp.

Venkatraman S (3):
     MMC:  prevent race between dma  and hsmmc callback
     sDMA: descriptor autoloading feature [version 5]
     MMC: omap hsmmc adaptation of descriptor autoloading feature

 arch/arm/plat-omap/dma.c              |  269 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  162 ++++++++++++++++----
 3 files changed, 571 insertions(+), 30 deletions(-)
