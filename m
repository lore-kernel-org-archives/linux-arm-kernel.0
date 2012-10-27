From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:50 +0530
Subject: [PATCH 5/9] pinctrl: SPEAr1310: Fix value of PERIP_CFG reigster and
 MCIF_SEL_SHIFT
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <c6063a2f8a36379dea60d781a064562e5aff632b.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

This patch fixes two macros: PERIP_CFG registers offset and MCIF selection
shift.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear1310.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index c720d09..baf98ae 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -25,8 +25,8 @@ static const struct pinctrl_pin_desc spear1310_pins[] = {
 };
 
 /* registers */
-#define PERIP_CFG					0x32C
-	#define MCIF_SEL_SHIFT				3
+#define PERIP_CFG					0x3B0
+	#define MCIF_SEL_SHIFT				5
 	#define MCIF_SEL_SD				(0x1 << MCIF_SEL_SHIFT)
 	#define MCIF_SEL_CF				(0x2 << MCIF_SEL_SHIFT)
 	#define MCIF_SEL_XD				(0x3 << MCIF_SEL_SHIFT)
-- 
1.7.12.rc2.18.g61b472e
