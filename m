From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Mar 2018 20:22:33 +0800
Subject: [RFC PATCH] reset: stm32mp1: stm32_reset_ops can be static
In-Reply-To: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
References: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20180316122233.GA85610@lkp-sb05>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: d05c83341cbc ("reset: stm32mp1: Enable stm32mp1 reset driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 reset-stm32mp1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-stm32mp1.c b/drivers/reset/reset-stm32mp1.c
index 5e25388..ed44604 100644
--- a/drivers/reset/reset-stm32mp1.c
+++ b/drivers/reset/reset-stm32mp1.c
@@ -70,7 +70,7 @@ static int stm32_reset_status(struct reset_controller_dev *rcdev,
 	return !(reg & BIT(offset));
 }
 
-const struct reset_control_ops stm32_reset_ops = {
+static const struct reset_control_ops stm32_reset_ops = {
 	.assert		= stm32_reset_assert,
 	.deassert	= stm32_reset_deassert,
 	.status		= stm32_reset_status,
