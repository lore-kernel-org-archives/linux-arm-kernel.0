From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 10 Feb 2016 21:51:07 -0600
Subject: [PATCH V3 08/12] dtb: amd: Add PERF CCN-504 device tree node
In-Reply-To: <1455162671-16044-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1455162671-16044-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1455162671-16044-9-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add PERF CCN-504 device tree node.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index ba455d1..70f407d 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -229,5 +229,12 @@
 				/* 64-bit MMIO (size= 124G) */
 				<0x03000000 0x01 0x00000000 0x01 0x00000000 0x7f 0x00000000>;
 		};
+
+		/* Perf CCN504 PMU */
+		ccn: ccn at e8000000 {
+			compatible = "arm,ccn-504";
+			reg = <0x0 0xe8000000 0 0x1000000>;
+			interrupts = <0 380 4>;
+		};
 	};
 };
-- 
2.5.0
