From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:25:20 +0200
Subject: [PATCH 1/5] ARM: Kirkwood: Allow use of pinctrl
In-Reply-To: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351088724-11142-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have a pinctrl driver for arch-mvebu. It supports kirkwood out
of the box. Allow ARCH_KIRKWOOD to select it, and make ARCH_KIRKWOOD
select it. This then allows the convertion of board-*.c files away
from MPP to pinctrl in DT, before they get moved over into mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig        |    2 ++
 drivers/pinctrl/Kconfig |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73067ef..160cd40 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -548,6 +548,8 @@ config ARCH_KIRKWOOD
 	select GENERIC_CLOCKEVENTS
 	select PCI
 	select PLAT_ORION_LEGACY
+	select PINCTRL
+	select PINCTRL_KIRKWOOD
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7bf914d..5682c96 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -188,7 +188,7 @@ config PINCTRL_EXYNOS4
 
 config PINCTRL_MVEBU
 	bool
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || ARCH_KIRKWOOD
 	select PINMUX
 	select PINCONF
 
-- 
1.7.10.4
