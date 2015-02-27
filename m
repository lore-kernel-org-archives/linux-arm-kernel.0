From: vigneshr@ti.com (Vignesh R)
Date: Fri, 27 Feb 2015 14:48:36 +0530
Subject: [PATCH 0/2] Add support for HDQ-1W on AM43XX
Message-ID: <1425028718-4919-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for HDQ-1W interface on AM43XX.
The first patch adds hwmod entries for HDQ-1W on AM43xx.

The existing omap_hdq driver does not support 1-wire operations.
The second patch enables 1-wire support in the omap_hdq driver. Support
to Search ROM addresses and automatically load slave drivers is added
for 1-wire mode.

I have tested this on am437x-gp-evm using DS18B20 as 1-wire slave.

Poddar, Sourav (1):
  ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W

Vignesh R (1):
  w1: masters: omap_hdq: Add support for 1-wire mode

 Documentation/devicetree/bindings/w1/omap-hdq.txt |   7 +-
 Documentation/w1/masters/omap-hdq                 |   6 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c        |  36 ++++
 arch/arm/mach-omap2/prcm43xx.h                    |   1 +
 drivers/w1/masters/omap_hdq.c                     | 209 ++++++++++++++++++----
 5 files changed, 225 insertions(+), 34 deletions(-)

-- 
1.9.1
