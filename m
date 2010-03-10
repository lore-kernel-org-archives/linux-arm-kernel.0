From: svenkatr@ti.com (Venkatraman S)
Date: Wed, 10 Mar 2010 19:41:21 +0530
Subject: [PATCH 00/03 v7] sDMA descriptor loading feature and omap hsmmc
	adaptations
Message-ID: <618f0c911003100611r6d256075p3ca7af3d66070efe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series was posted 10 days back
(http://www.mail-archive.com/linux-omap at vger.kernel.org/msg24713.html)
and I have received one comment, which I have fixed in this series.
Also rebased to latest 34-rc1.

Changes since v6:
 * Fixed comment alignment
 * removed incorrect whitespace alignment
 * rebased to 2.6.34-rc1

Venkatraman S (3):
     MMC:  prevent race between dma  and hsmmc callback
     sDMA: descriptor autoloading feature
     MMC: omap hsmmc adaptation of descriptor autoloading feature

 arch/arm/plat-omap/dma.c              |  269 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  162 ++++++++++++++++----
 3 files changed, 571 insertions(+), 30 deletions(-)
