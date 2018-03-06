From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Tue,  6 Mar 2018 10:29:25 +0530
Subject: [RFC 2/5] dt-bindings: brcm: Add reserved-dma-region for iPROC
In-Reply-To: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
Message-ID: <1520312368-7068-3-git-send-email-jitendra.bhivare@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With SoC wide DMA mask of 40-bit, the mappings for entire IOVA space can't
be specified in the PAXBv2 PCIe RC of SoC. The holes in IOVA space needs to
be reserved to prevent any IOVA allocations in those spaces.

reserved-dma-region property is added to specify the ranges which should
never be mapped and given to devices sitting behind.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index b8e48b4..3be0fe3 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -30,6 +30,9 @@ Optional properties:
 - dma-ranges: Some PAXB-based root complexes do not have inbound mapping done
   by the ASIC after power on reset.  In this case, SW is required to configure
 the mapping, based on inbound memory regions specified by this property.
+- reserved-dma-region: PAXBv2 with IOMMU enabled cannot provide mappings for
+  entire IOVA space specified by DMA mask. Hence this is used to reserve the
+  gaps in dma-ranges.
 
 - brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
 by the ASIC after power on reset. In this case, SW needs to configure it
-- 
2.7.4
