From: syin@broadcom.com (Sherman Yin)
Date: Wed, 11 Dec 2013 10:37:18 -0800
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <1386787041-6035-1-git-send-email-syin@broadcom.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
Message-ID: <1386787041-6035-4-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a string to the PINCTRL config option so that 1) CONFIG_PINCTRL=y would
not be erased by make config, and 2) PINCTRL option would show up in menuconfig.

Signed-off-by: Sherman Yin <syin@broadcom.com>
---
v3: added to patchset

 drivers/pinctrl/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 33f9dc1..a921ff1 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -3,7 +3,7 @@
 #
 
 config PINCTRL
-	bool
+	bool "Enable the pinctrl framework"
 
 if PINCTRL
 
-- 
1.7.9.5
