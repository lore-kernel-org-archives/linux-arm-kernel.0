From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 13 Oct 2015 23:31:37 +0200
Subject: [PATCH 1/5] pinctrl: berlin: select the pinctrl driver according to
 the SoC used
In-Reply-To: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444771901-24460-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prepares to remove the pinctrl driver selection from the
mach-berlin Kconfig. To do so, bool is replaced by def_bool.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
index 740a13675fd1..7eb4bb615867 100644
--- a/drivers/pinctrl/berlin/Kconfig
+++ b/drivers/pinctrl/berlin/Kconfig
@@ -6,15 +6,15 @@ config PINCTRL_BERLIN
 	select REGMAP_MMIO
 
 config PINCTRL_BERLIN_BG2
-	bool
+	def_bool MACH_BERLIN_BG2
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG2CD
-	bool
+	def_bool MACH_BERLIN_BG2CD
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG2Q
-	bool
+	def_bool MACH_BERLIN_BG2Q
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG4CT
-- 
2.6.1
