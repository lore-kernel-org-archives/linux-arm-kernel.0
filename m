From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Aug 2016 14:57:08 +0200
Subject: [PATCH 1/3] dt-bindings: designware-pcie: document optional
 msi-parent property
In-Reply-To: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1472561830-20932-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the Designware PCIe Device Tree binding
documentation to document the optional msi-parent property. This
property allows to point to an external MSI controller, which can
optionally be provided. If provided, this external MSI controller is
used in preference over the internal MSI controller of the Designware
PCIe IP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 6c5322c..7a729bb 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -28,6 +28,8 @@ Optional properties:
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+- msi-parent: Pointer to an external MSI controller. If not provided,
+  the built-in MSI controller is used.
 
 Example configuration:
 
-- 
2.7.4
