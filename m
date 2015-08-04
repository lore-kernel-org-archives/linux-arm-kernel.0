From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 4 Aug 2015 12:35:40 -0400
Subject: [PATCH] ARM: keystone: add documentation for SoCs and EVMs
Message-ID: <1438706140-3641-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is no general documentation on Keystone SoCs in the
Linux Documentation folder of the source tree. This patch adds some
essential documentation with links to help users of Keystone Linux and
also provide links to existing documents where necessary.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 Documentation/arm/keystone/Overview.txt | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/arm/keystone/Overview.txt

diff --git a/Documentation/arm/keystone/Overview.txt b/Documentation/arm/keystone/Overview.txt
new file mode 100644
index 0000000..f17bc4c
--- /dev/null
+++ b/Documentation/arm/keystone/Overview.txt
@@ -0,0 +1,73 @@
+		TI Keystone Linux Overview
+		--------------------------
+
+Introduction
+------------
+Keystone range of SoCs are based on ARM Cortex-A15 MPCore Processors
+and c66x DSP cores. This document describes essential information required
+for users to run Linux on Keystone based EVMs from Texas Instruments.
+
+Following SoCs  & EVMs are currently supported:-
+
+------------ K2HK SoC and EVM --------------------------------------------------
+
+a.k.a Keystone 2 Hawking/Kepler SoC
+TCI6636K2H & TCI6636K2K: See documentation at
+	http://www.ti.com/product/tci6638k2k
+	http://www.ti.com/product/tci6638k2h
+
+EVM:
+http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
+
+------------ K2E SoC and EVM ---------------------------------------------------
+
+a.k.a Keystone 2 Edison SoC
+K2E  -  66AK2E05: See documentation at
+	http://www.ti.com/product/66AK2E05/technicaldocuments
+
+EVM:
+https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
+
+------------ K2L SoC and EVM ---------------------------------------------------
+
+a.k.a Keystone 2 Lamarr SoC
+K2L  -  TCI6630K2L: See documentation at
+	http://www.ti.com/product/TCI6630K2L/technicaldocuments
+EVM:
+https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
+
+Configuration
+-------------
+
+All of the K2 SoCs/EVMs share a common defconfig, keystone_defconfig and same
+image is used to boot on individual EVMs. The platform configuration is
+specified through DTS. Following are the DTS used:-
+	K2HK EVM : k2hk-evm.dts
+	K2E EVM  : k2e-evm.dts
+	K2L EVM  : k2l-evm.dts
+
+The device tree documentation for the keystone machines are located at
+        Documentation/devicetree/bindings/arm/keystone/keystone.txt
+
+Known issues & workaround
+-------------------------
+
+Some of the device drivers used on keystone are re-used from that from
+DaVinci and other TI SoCs. These device drivers may use clock APIs directly.
+Some of the keystone specific drivers such as netcp uses run time power
+management API instead to enable clock. As this API has limitations on
+keystone, following workaround is needed to boot Linux.
+
+   Add 'clk_ignore_unused' to the bootargs env variable in u-boot. Otherwise
+   clock frameworks will try to disable clocks that are unused and disable
+   the hardware. This is because netcp related power domain and clock
+   domains are enabled in u-boot as run time power management API currently
+   doesn't enable clocks for netcp due to a limitation. This workaround is
+   expected to be removed in the future when proper API support becomes
+   available. Until then, this work around is needed.
+
+
+Document Author
+---------------
+Murali Karicheri <m-karicheri2@ti.com>
+Copyright 2015 Texas Instruments
-- 
1.9.1
