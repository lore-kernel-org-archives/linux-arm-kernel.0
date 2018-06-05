From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:26:38 -0500
Subject: [RFC PATCH 1/3] Documentation: dt: keystone: ti-sci: Add optional
 host-id parameter
In-Reply-To: <20180605062640.3356-1-nm@ti.com>
References: <20180605062640.3356-1-nm@ti.com>
Message-ID: <20180605062640.3356-2-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Texas Instrument's System Control Interface (TISCI) permits the
ability for Operating Systems to running in virtual machines to be
able to independently communicate with the firmware without the need
going through an hypervisor.

The "host-id" in effect is the hardware representation of the
host (example: VMs locked to a core) as identified to the System
Controller.

This is introduced as an optional parameter to maintain consistency
with legacy device tree blobs.

We call this with a vendor prefix to prevent any possible confusion
with SCSI ID (m68k) kernel option.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index 31f5f9a104cc..b56a02c10ae6 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -45,11 +45,15 @@ Optional Properties:
 	debug_messages - Map the Debug message region
 - reg:  register space corresponding to the debug_messages
 - ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
+- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
+	for identification of host processing entities such as virtual
+	machines
 
 Example (K2G):
 -------------
 	pmmc: pmmc {
 		compatible = "ti,k2g-sci";
+		ti,host-id = <2>;
 		mbox-names = "rx", "tx";
 		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
 			<&msgmgr &msgmgr_proxy_pmmc_tx>;
-- 
2.15.1
