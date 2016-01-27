From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:57 -0600
Subject: [PATCH 09/13] dtb: amd: Add KCS device tree node
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-10-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brijesh Singh <brijeshkumar.singh@amd.com>

Add KCS device node to support IPMI solution on Overdrive
system.

Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index c5461b2..a7fc059 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -236,5 +236,16 @@
 			reg = <0x0 0xe8000000 0 0x1000000>;
 			interrupts = <0 380 4>;
 		};
+
+		ipmi_kcs: kcs at e0010000 {
+			status = "disabled";
+			compatible = "ipmi-kcs";
+			device_type = "ipmi";
+			reg = <0x0 0xe0010000 0 0x8>;
+			interrupts = <0 389 4>;
+			interrupt-names = "ipmi_kcs";
+			reg-size = <1>;
+			reg-spacing = <4>;
+		};
 	};
 };
-- 
2.5.0
