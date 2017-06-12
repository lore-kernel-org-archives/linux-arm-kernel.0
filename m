From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Jun 2017 17:34:54 +0200
Subject: [PATCH v3 3/9] pinctrl: avoid PLAT_ORION dependency
In-Reply-To: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <58b227242d015c9a9db62bfd331be351037b1054.1497281623.git-series.gregory.clement@free-electrons.com>
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
