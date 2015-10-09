From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 19:56:45 +0800
Subject: [PATCH v5 2/7] pinctrl: berlin: Make berlin pinctrl driver visible if
 COMPILE_TEST=y
In-Reply-To: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
References: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444391810-5045-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is good to allow berlin pinctrl driver to build with COMPILE_TEST, so
make the it menu visible when compile-testing.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
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
