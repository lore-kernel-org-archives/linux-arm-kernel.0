From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 31 Oct 2013 12:24:36 +0900
Subject: [PATCH] ARM: shmobile: Include all 4 GiB of memory on Lager DT Ref
Message-ID: <20131031032436.16031.48305.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add 2GiB of DRAM at 0x1_8000_0000 to support the full 4GiB
of Lager system memory in case of DT Reference.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 For correct run time operation regardless of kernel configuration
 ARM patches 7863/1 and 7864/1 are needed.

 Written on top of renesas-devel-v3.12-rc7-20131030

 arch/arm/boot/dts/r8a7790-lager-reference.dts |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ work/arch/arm/boot/dts/r8a7790-lager-reference.dts	2013-10-31 11:51:18.000000000 +0900
@@ -25,6 +25,11 @@
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
+	memory at 180000000 {
+		device_type = "memory";
+		reg = <1 0x80000000 0 0x80000000>;
+	};
+
 	lbsc {
 		#address-cells = <1>;
 		#size-cells = <1>;
