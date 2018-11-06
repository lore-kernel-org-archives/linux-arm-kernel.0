From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:20:41 +0000
Subject: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
is not used in current code, and "apb_csr" is not used by some
platorms.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
index a618d4787dd7..64156993e052 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -10,8 +10,10 @@ Required properties:
 	interrupt source. The value must be 1.
 - compatible: Should contain "mbvl,gpex40-pcie"
 - reg: Should contain PCIe registers location and length
+	Mandatory:
 	"config_axi_slave": PCIe controller registers
 	"csr_axi_slave"	  : Bridge config registers
+	Optional:
 	"gpio_slave"	  : GPIO registers to control slot power
 	"apb_csr"	  : MSI registers
 
-- 
2.17.1
