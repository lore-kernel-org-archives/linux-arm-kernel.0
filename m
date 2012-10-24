From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 23:38:57 +0200
Subject: [PATCH 2/3] pinctrl: mvebu: remove useless include
In-Reply-To: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351114738-26793-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including the core.h header for the pinctrl subsystem is not
necessary, and it is actually causing problems when moving the
pinctrl-mvebu drivers into a separate subdirectory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/pinctrl-mvebu.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-mvebu.c b/drivers/pinctrl/pinctrl-mvebu.c
index 8e6266c..6c44b7e 100644
--- a/drivers/pinctrl/pinctrl-mvebu.c
+++ b/drivers/pinctrl/pinctrl-mvebu.c
@@ -24,7 +24,6 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
-#include "core.h"
 #include "pinctrl-mvebu.h"
 
 #define MPPS_PER_REG	8
-- 
1.7.9.5
