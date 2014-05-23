From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 May 2014 11:52:24 -0700
Subject: [Patch v2 3/4] soc: qcom: Add GSBI driver
In-Reply-To: <1398357082-5102-4-git-send-email-agross@codeaurora.org>
References: <1398357082-5102-1-git-send-email-agross@codeaurora.org>
 <1398357082-5102-4-git-send-email-agross@codeaurora.org>
Message-ID: <537F98E8.6050203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/14 09:31, Andy Gross wrote:
> +
> +static const struct of_device_id gsbi_dt_match[] = {
> +	{ .compatible = "qcom,gsbi-v1.0.0", },
> +};

Eek. This isn't NULL terminated.


-----8<---

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] soc: qcom: Terminate gsbi of match table

Failure to terminate this match table can lead to boot failures
depending on where the compiler places the match table.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/soc/qcom/qcom_gsbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 061dd0632dbd..ab7b441c9980 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -64,6 +64,7 @@ static int gsbi_probe(struct platform_device *pdev)
 
 static const struct of_device_id gsbi_dt_match[] = {
 	{ .compatible = "qcom,gsbi-v1.0.0", },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, gsbi_dt_match);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
