From: kraxel@redhat.com (Gerd Hoffmann)
Date: Mon, 19 Sep 2016 10:43:17 +0200
Subject: [PATCH v4 1/7] pinctrl: bcm2835: add pull defines to dt bindings
In-Reply-To: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
Message-ID: <1474274603-24215-2-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also delete (unused) private enum from driver.
The pull defines can be used instead if needed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 6 ------
 include/dt-bindings/pinctrl/bcm2835.h | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index fa77165..4cf612b 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -76,12 +76,6 @@ enum bcm2835_pinconf_param {
 	BCM2835_PINCONF_PARAM_PULL,
 };
 
-enum bcm2835_pinconf_pull {
-	BCM2835_PINCONFIG_PULL_NONE,
-	BCM2835_PINCONFIG_PULL_DOWN,
-	BCM2835_PINCONFIG_PULL_UP,
-};
-
 #define BCM2835_PINCONF_PACK(_param_, _arg_) ((_param_) << 16 | (_arg_))
 #define BCM2835_PINCONF_UNPACK_PARAM(_conf_) ((_conf_) >> 16)
 #define BCM2835_PINCONF_UNPACK_ARG(_conf_) ((_conf_) & 0xffff)
diff --git a/include/dt-bindings/pinctrl/bcm2835.h b/include/dt-bindings/pinctrl/bcm2835.h
index 6f0bc37..e4e4fdf 100644
--- a/include/dt-bindings/pinctrl/bcm2835.h
+++ b/include/dt-bindings/pinctrl/bcm2835.h
@@ -24,4 +24,9 @@
 #define BCM2835_FSEL_ALT2	6
 #define BCM2835_FSEL_ALT3	7
 
+/* brcm,pull property */
+#define BCM2835_PUD_OFF		0
+#define BCM2835_PUD_DOWN	1
+#define BCM2835_PUD_UP		2
+
 #endif /* __DT_BINDINGS_PINCTRL_BCM2835_H__ */
-- 
1.8.3.1
