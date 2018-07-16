From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Jul 2018 12:13:27 -0500
Subject: [PATCH V2 1/2] Documentation: dt: keystone: ti-sci: Add optional
 host-id parameter
In-Reply-To: <20180716171328.11674-1-nm@ti.com>
References: <20180716171328.11674-1-nm@ti.com>
Message-ID: <20180716171328.11674-2-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Texas Instrument's System Control Interface (TISCI) permits
the ability for OSs running in virtual machines to be able to
independently communicate with the firmware without the need going
through an hypervisor.

The "host-id" in effect is the hardware representation of the
host (example: VMs locked to a core) as identified to the System
Controller. Hypervisors can either fill in appropriate host-ids in dt
used for each VM instance OR may use prebuilt blobs where the host-ids
are pre-populated, as appropriate for the OS running in the VMs.

This is introduced as an optional parameter to maintain consistency
with legacy device tree blobs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since V1:
* Dropped the SCSI comment in commit log
* Picked up Rob's Reviewed by.

V1: https://patchwork.kernel.org/patch/10475311/
RFC: https://patchwork.kernel.org/patch/10447753/

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
