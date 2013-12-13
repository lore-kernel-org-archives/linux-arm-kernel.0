From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:30 +0900
Subject: [PATCH 56/69] ARM: shmobile: Include all 4 GiB of memory on Lager
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <62bc32a2573c421926a292e13b71ad9cc3ebf6e4.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add 2GiB of DRAM at 0x1_8000_0000 to support the full 4GiB
of Lager system memory.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 8799dfb..10e6a08 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -24,6 +24,11 @@
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
-- 
1.8.4
