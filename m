From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Apr 2013 10:44:44 +0900
Subject: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
Message-ID: <20130408014444.18767.64441.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

Add 1GiB of DRAM at 0x2_0000_0000

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This patch simply updates the DTS to describe the actual board
 hardware. If we want to make use of the memory we also need to
 enable LPAE in the kernel configuration, but that is seen as a
 separate step.

 arch/arm/boot/dts/r8a73a4-ape6evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts	2013-04-08 10:27:20.000000000 +0900
@@ -24,6 +24,11 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	memory at 200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
+
 	ape6evm_fixed_3v3: fixedregulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
