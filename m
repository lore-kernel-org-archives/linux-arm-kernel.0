From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 13 Oct 2015 14:45:41 -0400
Subject: [PATCH v3 1/3] Documentation: dt: soc: Add description for knav qmss
 driver
In-Reply-To: <1444761943-726-1-git-send-email-m-karicheri2@ti.com>
References: <1444761943-726-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1444761943-726-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for knav qmss driver.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 v3: not removed description from DT document
 Documentation/arm/keystone/knav-qmss.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/arm/keystone/knav-qmss.txt

diff --git a/Documentation/arm/keystone/knav-qmss.txt b/Documentation/arm/keystone/knav-qmss.txt
new file mode 100644
index 0000000..79946d1
--- /dev/null
+++ b/Documentation/arm/keystone/knav-qmss.txt
@@ -0,0 +1,24 @@
+* Texas Instruments Keystone Navigator Queue Management SubSystem driver
+
+Driver source code path
+  drivers/soc/ti/knav_qmss.c
+  drivers/soc/ti/knav_qmss_acc.c
+
+The QMSS (Queue Manager Sub System) found on Keystone SOCs is one of
+the main hardware sub system which forms the backbone of the Keystone
+multi-core Navigator. QMSS consist of queue managers, packed-data structure
+processors(PDSP), linking RAM, descriptor pools and infrastructure
+Packet DMA.
+The Queue Manager is a hardware module that is responsible for accelerating
+management of the packet queues. Packets are queued/de-queued by writing or
+reading descriptor address to a particular memory mapped location. The PDSPs
+perform QMSS related functions like accumulation, QoS, or event management.
+Linking RAM registers are used to link the descriptors which are stored in
+descriptor RAM. Descriptor RAM is configurable as internal or external memory.
+The QMSS driver manages the PDSP setups, linking RAM regions,
+queue pool management (allocation, push, pop and notify) and descriptor
+pool management.
+
+knav qmss driver provides a set of APIs to drivers to open/close qmss queues,
+allocate descriptor pools, map the descriptors, push/pop to queues etc. For
+details of the available APIs, please refers to include/linux/soc/ti/knav_qmss.h
-- 
1.9.1
