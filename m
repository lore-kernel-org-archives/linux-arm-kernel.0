From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:38 +0900
Subject: [RFC 12/15] soc: qcom: Add missing MFD_SYSCON dependency on HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-13-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 461b387d03cc..24de48134c15 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -4,6 +4,7 @@
 config QCOM_GSBI
         tristate "QCOM General Serial Bus Interface"
         depends on ARCH_QCOM
+        depends on HAS_IOMEM	# For MFD_SYSCON
         select MFD_SYSCON
         help
           Say y here to enable GSBI support.  The GSBI provides control
-- 
2.5.0
