From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  2 Jun 2017 16:23:11 +0200
Subject: [PATCH v2 04/11] pinctrl: avoid PLAT_ORION dependency
In-Reply-To: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
Message-ID: <c7a440223b0855f2f916496be921362f2e3d62b6.1496413293.git-series.gregory.clement@free-electrons.com>
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
