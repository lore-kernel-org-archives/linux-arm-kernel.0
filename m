From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 22 May 2017 16:45:14 +0200
Subject: [PATCH v5 4/4] arm64: marvell: dts: add dma-mask in crypto nodes for
 7k/8k
In-Reply-To: <20170522144514.6654-1-antoine.tenart@free-electrons.com>
References: <20170522144514.6654-1-antoine.tenart@free-electrons.com>
Message-ID: <20170522144514.6654-5-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EIP197 cryptographic engine supports 64 bits address width but is
limited to 40 bits on 7k/8k. Add a dma-mask property in the
cryptographic engine nodes to reflect this.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index ac8df5201cd6..e040677b67dc 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -241,6 +241,7 @@
 				interrupt-names = "mem", "ring0", "ring1",
 				"ring2", "ring3", "eip";
 				clocks = <&cpm_syscon0 1 26>;
+				dma-mask = <0xff 0xffffffff>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 7740a75a8230..1a69fb006f16 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -231,6 +231,7 @@
 				interrupt-names = "mem", "ring0", "ring1",
 						  "ring2", "ring3", "eip";
 				clocks = <&cps_syscon0 1 26>;
+				dma-mask = <0xff 0xffffffff>;
 				status = "disabled";
 			};
 		};
-- 
2.9.4
