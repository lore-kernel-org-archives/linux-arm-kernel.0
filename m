From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 18:04:47 +0200
Subject: [PATCH 5/9] pinctrl: avoid PLAT_ORION dependency
In-Reply-To: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
References: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
Message-ID: <0154e6504cc0a31685811b2342717881ce513ea4.1495209664.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Armada 8040 also needs orion pinctrl, and as these symbols are only
selected, there's no need to make them depend on PLAT_ORION.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
index 5bade32d3089..8cb444b60ae9 100644
--- a/drivers/pinctrl/mvebu/Kconfig
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -1,5 +1,3 @@
-if PLAT_ORION
-
 config PINCTRL_MVEBU
 	bool
 	select PINMUX
@@ -38,8 +36,6 @@ config PINCTRL_ORION
 	bool
 	select PINCTRL_MVEBU
 
-endif
-
 config PINCTRL_ARMADA_37XX
        bool
        select GENERIC_PINCONF
-- 
git-series 0.9.1
