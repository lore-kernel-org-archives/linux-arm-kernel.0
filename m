From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Wed, 7 Feb 2018 14:08:55 +0100
Subject: [PATCH 2/2] crypto: stm32/cryp - add stm32mp1 support
In-Reply-To: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
References: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <1518008935-30428-3-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32mp1 differs from stm32f7 in the way it handles byte ordering and
padding for aes gcm & ccm algo.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 6a1fe98..c5d3efc 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1906,8 +1906,14 @@ static const struct stm32_cryp_caps f7_data = {
 	.padding_wa = true,
 };
 
+static const struct stm32_cryp_caps mp1_data = {
+	.swap_final = false,
+	.padding_wa = false,
+};
+
 static const struct of_device_id stm32_dt_ids[] = {
 	{ .compatible = "st,stm32f756-cryp", .data = &f7_data},
+	{ .compatible = "st,stm32mp1-cryp", .data = &mp1_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_dt_ids);
-- 
2.7.4
