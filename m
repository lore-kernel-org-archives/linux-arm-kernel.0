From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 25 Feb 2016 19:53:28 +0800
Subject: [PATCH 2/2] PCI: generic: add description of property
 "interrupt-skip-mask"
In-Reply-To: <1456401208-10136-1-git-send-email-thunder.leizhen@huawei.com>
References: <1456401208-10136-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1456401208-10136-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt Pin register is read-only and optional. Some pci devices may use
msi/msix but leave the value of Interrupt Pin non-zero. In this case, the
driver will print information as below:
pci 0000:40:00.0: of_irq_parse_pci() failed with rc=-22

It's easily lead to misinterpret.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
index 3f1d3fc..0f10978 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
@@ -70,6 +70,8 @@ Practice: Interrupt Mapping' and requires the following properties:

 - interrupt-map-mask : <see aforementioned specification>

+- interrupt-skip-mask: Explicitly declare which pci devices only use msi/msix
+but leave the value of Interrupt Pin non-zero.

 Example:

--
2.5.0
