From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 17:54:03 +0800
Subject: [PATCH 2/6] pinctrl: sirf: add missing pins to pinctrl list
Message-ID: <1348739643-21105-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

We always use pinctrl_request_gpio() to get GPIO, If we don't have these
missing pins in the pin list, gpio_request and related operations will fail
for them.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 45a756f..6634944 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -69,6 +69,10 @@ static DEFINE_SPINLOCK(sgpio_lock);
  * refer to CS-131858-DC-6A.xls
  */
 static const struct pinctrl_pin_desc sirfsoc_pads[] = {
+	PINCTRL_PIN(0, "gpio0-0"),
+	PINCTRL_PIN(1, "gpio0-1"),
+	PINCTRL_PIN(2, "gpio0-2"),
+	PINCTRL_PIN(3, "gpio0-3"),
 	PINCTRL_PIN(4, "pwm0"),
 	PINCTRL_PIN(5, "pwm1"),
 	PINCTRL_PIN(6, "pwm2"),
@@ -77,7 +81,9 @@ static const struct pinctrl_pin_desc sirfsoc_pads[] = {
 	PINCTRL_PIN(9, "odo_0"),
 	PINCTRL_PIN(10, "odo_1"),
 	PINCTRL_PIN(11, "dr_dir"),
+	PINCTRL_PIN(12, "viprom_fa"),
 	PINCTRL_PIN(13, "scl_1"),
+	PINCTRL_PIN(14, "ntrst"),
 	PINCTRL_PIN(15, "sda_1"),
 	PINCTRL_PIN(16, "x_ldd[16]"),
 	PINCTRL_PIN(17, "x_ldd[17]"),
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
