From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 13:51:43 -0400
Subject: [PATCH V6 01/10] Documentation: DT: qcom_hidma: update binding for MSI
In-Reply-To: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1476899512-20431-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new binding for qcom,hidma-1.1 to distinguish HW supporting
MSI interrupts from the older revision.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index fd5618b..2c5e4b8 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -47,12 +47,18 @@ When the OS is not in control of the management interface (i.e. it's a guest),
 the channel nodes appear on their own, not under a management node.
 
 Required properties:
-- compatible: must contain "qcom,hidma-1.0"
+- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
+for MSI capable HW.
 - reg: Addresses for the transfer and event channel
 - interrupts: Should contain the event interrupt
 - desc-count: Number of asynchronous requests this channel can handle
 - iommus: required a iommu node
 
+Optional properties for MSI:
+- msi-parent : See the generic MSI binding described in
+ devicetree/bindings/interrupt-controller/msi.txt for a description of the
+ msi-parent property.
+
 Example:
 
 Hypervisor OS configuration:
-- 
1.9.1
