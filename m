From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Oct 2013 21:07:46 +0200
Subject: [PATCH 1/3] clocksource: sun4i: Select CLKSRC_MMIO
In-Reply-To: <1381777668-32565-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1381777668-32565-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1381777668-32565-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs timer use the clocksource MMIO functions. We thus
need to select them in Kconfig.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 41c6946..cea50f0 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -33,6 +33,7 @@ config ORION_TIMER
 	bool
 
 config SUN4I_TIMER
+	select CLKSRC_MMIO
 	bool
 
 config VT8500_TIMER
-- 
1.8.4
