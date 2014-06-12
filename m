From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 12 Jun 2014 13:08:12 +0800
Subject: [PATCH RFC v2 3/3] documentation/iommu: Add description of Hisilicon
 SMMU private binding
In-Reply-To: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1402549692-5224-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a description of private properties for the Hisilicon
System MMU architecture.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index f284b99..75b1351 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -15,6 +15,7 @@ conditions.
                         "arm,smmu-v2"
                         "arm,mmu-400"
                         "arm,mmu-500"
+                        "hisilicon,smmu-v1"

                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -54,6 +55,21 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.

+** Hisilicon SMMU private properties:
+
+- smmu-force-memtype : A list of StreamIDs which not translate address but
+                  translate attributes. The StreamIDs list here can not be
+                  used for map(translation) mode again.
+                  StreamID first, then the type list below:
+                  1, cahceable, WBRAWA, Normal outer and inner write-back
+                  2, non-cacheable, Normal outer and inner non-cacheable
+                  3, device, nGnRE
+                  others, bypass
+
+- smmu-bypass-vmid   : Specify which context bank is used for bypass mode.
+                  If omit, vmid=255 is default. If bypass and map mode can
+                  share a same S2CR, config vmid=0.
+
 Example:

         smmu {
--
1.8.0
