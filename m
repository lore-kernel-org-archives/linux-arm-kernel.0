From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 9 Mar 2017 13:27:19 +0530
Subject: [PATCH v3 08/23] Documentation: PCI: Add binding documentation for
 pci-test endpoint function
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
Message-ID: <1489046254-19919-9-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for pci-test endpoint function that helps in
adding and configuring pci-test endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX                         |    2 ++
 .../PCI/endpoint/function/binding/pci-test.txt     |   17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index 4e5a283..53717b7 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -18,3 +18,5 @@ endpoint/pci-endpoint-cfs.txt
 	- guide to use configfs to configure the pci endpoint function.
 endpoint/pci-test-function.txt
 	- specification of *pci test* function device.
+endpoint/function/binding/
+	- binding documentation for pci endpoint function
diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
new file mode 100644
index 0000000..02a6c94
--- /dev/null
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
@@ -0,0 +1,17 @@
+PCI TEST ENDPOINT FUNCTION
+
+name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
+
+Configurable Fields:
+vendorid	 : should be 0x104c
+deviceid	 : should be 0xb500 for DRA74x and 0xb501 for DRA72x
+revid		 : dont't care
+progif_code	 : don't care
+subclass_code	 : don't care
+baseclass_code	 : should be 0xff
+cache_line_size	 : don't care
+subsys_vendor_id : don't care
+subsys_id	 : don't care
+interrupt_pin	 : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
+msi_interrupts	 : Should be 1 to 32 depending on the number of msi interrupts
+		   to test
-- 
1.7.9.5
