From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  7 Dec 2011 21:47:21 +0100
Subject: [PATCH] pinctrl: make the "Debug PINCTRL calls" entry actually do
 something
Message-ID: <1323290841-29633-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_PINCTRL wasn't used at all and DEBUG_PINMUX doesn't exist.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index bdc548a..50a2e2f 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -1,6 +1,6 @@
 # generic pinmux support
 
-ccflags-$(CONFIG_DEBUG_PINMUX)	+= -DDEBUG
+ccflags-$(CONFIG_DEBUG_PINCTRL)	+= -DDEBUG
 
 obj-$(CONFIG_PINCTRL)		+= core.o
 obj-$(CONFIG_PINMUX)		+= pinmux.o
-- 
1.7.7.3
