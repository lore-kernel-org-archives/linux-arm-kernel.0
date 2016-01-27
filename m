From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 27 Jan 2016 10:51:19 +0530
Subject: [RFC PATCH 6/6] iommu/arm-smmu: Update bindings document for
 smmu-inst-as-data DT option
In-Reply-To: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1453872079-27140-7-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds info about 'smmu-inst-as-data' DT option in ARM
SMMUv1/SMMUv2 driver bindings document.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 7180745..4c4d03e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -49,6 +49,14 @@ conditions.
                   NOTE: this only applies to the SMMU itself, not
                   masters connected upstream of the SMMU.
 
+- smmu-inst-as-data : Treat privilege/unprivilege instruction fetch as
+                  data read for SMMUv2. The SMMU driver by default provides
+                  unprivilege read-write permission in page table entries.
+                  For SMMUv2, privilege instruction fetch from MMU masters
+                  will cause a context fault for unprivilege read-write
+                  pages. To allow both privilege and unprivilege instruction
+                  fetch, we have to forcefully treat it as data read.
+
 - calxeda,smmu-secure-config-access : Enable proper handling of buggy
                   implementations that always use secure access to
                   SMMU configuration registers. In this case non-secure
-- 
1.9.1
