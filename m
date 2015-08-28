From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Aug 2015 12:31:10 -0700
Subject: [PATCH] spmi: pmic-arb: u8 <= 0xff is always true
Message-ID: <1440790270-14859-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silences this static checker warning:

 drivers/spmi/spmi-pmic-arb.c:363
 pmic_arb_write_cmd() warn: always true condition
 '(opc <= 255) => (0-255 <= 255)'

Cc: Andy Gross <agross@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/spmi/spmi-pmic-arb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 5e834bd23c09..c7aa6f1a898e 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -360,7 +360,7 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 		opc = PMIC_ARB_OP_EXT_WRITE;
 	else if (opc >= 0x30 && opc <= 0x37)
 		opc = PMIC_ARB_OP_EXT_WRITEL;
-	else if (opc >= 0x80 && opc <= 0xFF)
+	else if (opc >= 0x80)
 		opc = PMIC_ARB_OP_ZERO_WRITE;
 	else
 		return -EINVAL;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
