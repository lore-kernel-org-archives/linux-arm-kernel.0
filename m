From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 17:58:15 +0100
Subject: [PATCH] pinctrl: nsp-gpio: fix non-static functions
Message-ID: <1465318695-23348-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixup warnings from functions that are not exported and
therefore should be marked static. Fixes:

drivers/pinctrl/bcm/pinctrl-nsp-gpio.c:461:5: warning: symbol 'nsp_pin_config_group_get' was not declared. Should it be static?
drivers/pinctrl/bcm/pinctrl-nsp-gpio.c:467:5: warning: symbol 'nsp_pin_config_group_set' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: bcm-kernel-feedback-list at broadcom.com
---
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index a8b37a9..35783db 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -458,13 +458,15 @@ static int nsp_gpio_get_strength(struct nsp_gpio *chip, unsigned gpio,
 	return 0;
 }
 
-int nsp_pin_config_group_get(struct pinctrl_dev *pctldev, unsigned selector,
+static int nsp_pin_config_group_get(struct pinctrl_dev *pctldev,
+				    unsigned selector,
 			     unsigned long *config)
 {
 	return 0;
 }
 
-int nsp_pin_config_group_set(struct pinctrl_dev *pctldev, unsigned selector,
+static int nsp_pin_config_group_set(struct pinctrl_dev *pctldev,
+				    unsigned selector,
 			     unsigned long *configs, unsigned num_configs)
 {
 	return 0;
-- 
2.8.1
