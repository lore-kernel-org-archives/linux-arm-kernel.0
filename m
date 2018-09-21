From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:42 +0530
Subject: [RFC PATCH 27/40] dt-bindings: PCI: Document "atu" reg-names
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-28-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document "atu" reg-names required to get the register space for ATU in
Synopsys designware core version >= 4.80.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index c124f9bc11f3..5561a1c060d0 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -4,8 +4,11 @@ Required properties:
 - compatible:
 	"snps,dw-pcie" for RC mode;
 	"snps,dw-pcie-ep" for EP mode;
-- reg: Should contain the configuration address space.
-- reg-names: Must be "config" for the PCIe configuration space.
+- reg: For designware cores version < 4.80 contains the configuration
+       address space. For designware core version >= 4.80, contains
+       the configuration and ATU address space
+- reg-names: Must be "config" for the PCIe configuration space and "atu" for
+	     the ATU address space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
 - num-lanes: number of lanes to use
-- 
2.17.1
