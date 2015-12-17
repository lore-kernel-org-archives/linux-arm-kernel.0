From: pmallapp@broadcom.com (Prem Mallappa)
Date: Thu, 17 Dec 2015 15:29:36 +0530
Subject: [PATCH v2 2/2] Documentation: dt-bindings: Add option to workaround
 STE.VALID in Broadcom Vulcan
In-Reply-To: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
Message-ID: <1450346376-30920-2-git-send-email-pmallapp@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 947863a..9c1218e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -43,6 +43,11 @@ the PCIe specification.
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
 
+- broadcom,broken-ste-valid-check
+                    : Broadcom specific, h/w peeks into more than just 
+		      STE.VALID bit in "Bypass" mode. Enabling this, 
+		      populates needed bits.
+
 ** Example
 
         smmu at 2b400000 {
-- 
2.6.0
