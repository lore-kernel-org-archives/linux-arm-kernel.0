From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 8 Feb 2016 11:59:13 -0600
Subject: [PATCH V2 08/12] dtb: amd: Add PERF CCN-504 device tree node
In-Reply-To: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1454954357-8395-9-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add PERF CCN-504 device tree node.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index ba455d1..c5461b2 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -229,5 +229,12 @@
 				/* 64-bit MMIO (size= 124G) */
 				<0x03000000 0x01 0x00000000 0x01 0x00000000 0x7f 0x00000000>;
 		};
+
+		/* Perf CCN504 PMU */
+		ccn: ccn at 0xe8000000 {
+			compatible = "arm,ccn-504";
+			reg = <0x0 0xe8000000 0 0x1000000>;
+			interrupts = <0 380 4>;
+		};
 	};
 };
-- 
2.5.0
