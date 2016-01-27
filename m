From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:50 -0600
Subject: [PATCH 02/13] dtb: amd: Fix GICv2 hypervisor and virtual interface
 sizes
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-3-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brijesh Singh <brijeshkumar.singh@amd.com>

This patch fixes incorrect sizes of the GICv2 device tree node.
This has triggered error message when booting Xen hypervisor.

Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 2874d92..fdd0c96 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -18,8 +18,8 @@
 		#size-cells = <2>;
 		reg = <0x0 0xe1110000 0 0x1000>,
 		      <0x0 0xe112f000 0 0x2000>,
-		      <0x0 0xe1140000 0 0x10000>,
-		      <0x0 0xe1160000 0 0x10000>;
+		      <0x0 0xe1140000 0 0x2000>,
+		      <0x0 0xe1160000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
 		ranges = <0 0 0 0xe1100000 0 0x100000>;
 		v2m0: v2m at e0080000 {
-- 
2.5.0
