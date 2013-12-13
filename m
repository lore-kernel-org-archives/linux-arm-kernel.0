From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:29 +0900
Subject: [PATCH 55/69] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <8353f09f579631d095292bd838114833dbe1298f.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Add 1GiB of DRAM at 0x2_0000_0000 to support the full 2GiB
of APE6EVM system memory.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index e84d1a7..ce085fa 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -25,6 +25,11 @@
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
-- 
1.8.4
