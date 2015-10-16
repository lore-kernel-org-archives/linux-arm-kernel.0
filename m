From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 16 Oct 2015 15:37:07 +0800
Subject: [PATCH v6 2/7] pinctrl: berlin: Make berlin pinctrl driver visible if
 COMPILE_TEST=y
In-Reply-To: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
References: <1444981032-4401-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444981032-4401-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is good to allow berlin pinctrl driver to build with COMPILE_TEST, so
make the it menu visible when compile-testing.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
index b18322b..f7e45c8 100644
--- a/drivers/pinctrl/berlin/Kconfig
+++ b/drivers/pinctrl/berlin/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_BERLIN
+if (ARCH_BERLIN || COMPILE_TEST)
 
 config PINCTRL_BERLIN
 	bool
-- 
2.6.1
