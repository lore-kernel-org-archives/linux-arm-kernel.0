From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Sun, 30 Nov 2014 21:46:40 -0600
Subject: [PATCH 2/2] arm64: amd-seattle: Fix PCI bus range due to SMMU
 limitation
In-Reply-To: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <1417405600-19232-3-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Since PCIe is using SMMUv1 which only supports 15-bit stream ID,
only 7-bit PCI bus id is used to specify stream ID. Therefore,
we only limit the PCI bus range to 0x7f.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index f370f03..a6534c4 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -151,7 +151,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			device_type = "pci";
-			bus-range = <0 0xff>;
+			bus-range = <0 0x7f>;
 			msi-parent = <&v2m0>;
 			reg = <0 0xf0000000 0 0x10000000>;
 
-- 
1.9.3
