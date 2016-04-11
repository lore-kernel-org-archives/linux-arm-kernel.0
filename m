From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Mon, 11 Apr 2016 11:38:40 +0300
Subject: [PATCH v3 3/6] dmaengine: qcom: bam_dma: document controlled-remotely
 dt property
In-Reply-To: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1460363923-16296-4-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend BAM dt bindings with controlled-remotely property. The
property will be needed to handle cases where we need to skip
register writes to initialise BAM hardware block.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.txt       |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
index 1c9d48ea4914..9cbf5d9df8fd 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
@@ -13,6 +13,8 @@ Required properties:
 - clock-names: must contain "bam_clk" entry
 - qcom,ee : indicates the active Execution Environment identifier (0-7) used in
   the secure world.
+- qcom,controlled-remotely : optional, indicates that the bam is controlled by
+  remote proccessor i.e. execution environment.
 
 Example:
 
-- 
1.7.9.5
