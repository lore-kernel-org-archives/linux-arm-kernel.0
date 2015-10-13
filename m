From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 13 Oct 2015 23:31:39 +0200
Subject: [PATCH 3/5] pinctrl: berlin: add explicit dependency on OF
In-Reply-To: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444771901-24460-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Berlin pinctrl drivers depends on CONFIG_OF. This patch adds
this dependency explicitly.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
index 7eb4bb615867..cf95b4d7f7e3 100644
--- a/drivers/pinctrl/berlin/Kconfig
+++ b/drivers/pinctrl/berlin/Kconfig
@@ -7,14 +7,17 @@ config PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG2
 	def_bool MACH_BERLIN_BG2
+	depends on OF
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG2CD
 	def_bool MACH_BERLIN_BG2CD
+	depends on OF
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG2Q
 	def_bool MACH_BERLIN_BG2Q
+	depends on OF
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG4CT
-- 
2.6.1
