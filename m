From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 19:44:56 +0900
Subject: [PATCH 03/03] ARM: shmobile: Add second memory bank to DTS for APE6EVM
In-Reply-To: <20130605104427.1720.68752.sendpatchset@w520>
References: <20130605104427.1720.68752.sendpatchset@w520>
Message-ID: <20130605104456.1720.70240.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

Add 1GiB of DRAM at 0x2_0000_0000 to APE6EVM

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

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
