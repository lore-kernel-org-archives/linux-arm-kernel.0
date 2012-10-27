From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:53 +0530
Subject: [PATCH 8/9] pinctrl: SPEAr1340: Make DDR reset & clock pads as gpio
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <93d8c2503c2a8c188b0325c898c136ded3e18adb.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

Some gpio pins are used to control DDR reset and clock enable while the system
is moved into Low power. This patch adds in the corresponding GPIO entries in
the pads_as_gpio_pins to ensure the pads are available as gpio's.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear1340.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index a0eb057..3963675 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -213,7 +213,7 @@ static const struct pinctrl_pin_desc spear1340_pins[] = {
  * Pad multiplexing for making all pads as gpio's. This is done to override the
  * values passed from bootloader and start from scratch.
  */
-static const unsigned pads_as_gpio_pins[] = { 251 };
+static const unsigned pads_as_gpio_pins[] = { 12, 88, 89, 251 };
 static struct spear_muxreg pads_as_gpio_muxreg[] = {
 	{
 		.reg = PAD_FUNCTION_EN_1,
-- 
1.7.12.rc2.18.g61b472e
