From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 26 Nov 2014 13:51:01 -0800
Subject: [PATCH v8 3/3] regulator: qcom-rpm: Add missing state flag in call to
 RPM
In-Reply-To: <1417038661-30209-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1417038661-30209-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1417038661-30209-4-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing state parameter to the call down to the RPM. This
is currently hard coded to the active state, as that's all we're
supporting at this moment.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/regulator/qcom_rpm-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index b55cd5b..8f66040 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -198,6 +198,7 @@ static int rpm_reg_write(struct qcom_rpm_reg *vreg,
 	vreg->val[req->word] |= value << req->shift;
 
 	return qcom_rpm_write(vreg->rpm,
+			      QCOM_RPM_ACTIVE_STATE,
 			      vreg->resource,
 			      vreg->val,
 			      vreg->parts->request_len);
-- 
1.8.2.2
