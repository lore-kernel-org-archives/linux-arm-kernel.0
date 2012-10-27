From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:48 +0530
Subject: [PATCH 3/9] pinctrl: SPEAr320: Correct pad mux entries for rmii/smii
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <1d2c374f463bda55c687d2bbee569ca2e23310dc.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

pin entries of rmii and smii are interchanged by mistake. Fix it.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index 4fccf95..ca47b0e 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -2960,9 +2960,9 @@ static struct spear_function mii2_function = {
 };
 
 /* Pad multiplexing for cadence mii 1_2 as smii or rmii device */
-static const unsigned smii0_1_pins[] = { 10, 11, 13, 14, 15, 16, 17, 18, 19, 20,
+static const unsigned rmii0_1_pins[] = { 10, 11, 13, 14, 15, 16, 17, 18, 19, 20,
 	21, 22, 23, 24, 25, 26, 27 };
-static const unsigned rmii0_1_pins[] = { 10, 11, 21, 22, 23, 24, 25, 26, 27 };
+static const unsigned smii0_1_pins[] = { 10, 11, 21, 22, 23, 24, 25, 26, 27 };
 static struct spear_muxreg mii0_1_muxreg[] = {
 	{
 		.reg = PMX_CONFIG_REG,
-- 
1.7.12.rc2.18.g61b472e
