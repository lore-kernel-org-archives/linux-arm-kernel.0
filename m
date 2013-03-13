From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 14 Mar 2013 01:19:50 +0530
Subject: [PATCH V3 1/5] ARM: tegra: add APB DMA nodes to Tegra114 DT
In-Reply-To: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
References: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1363204194-19487-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 has 32 channels APB DMA controller. Add DT entry for
APB DMA controllers and make it compatible with "nvidia,tegra114-apbdma".

Tegra114 DMA controller is not compatible with Tegra30/Tegra20 DMA
controller driver as in T114, the global pause also clock gate the
DMA register and hence it iw not possible to write the DMA register
with global pause.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Add reeason why APBDMA is not compatible with older driver
  in description.

Changes from V2:
 - Rebase to for-3.10/dt of Stephen's tegra tree.

 arch/arm/boot/dts/tegra114.dtsi |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 7ddb328..634d70c 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -37,6 +37,44 @@
 		reg = <0x6000c004 0x14c>;
 	};
 
+	apbdma: dma {
+		compatible = "nvidia,tegra114-apbdma";
+		reg = <0x6000a000 0x1400>;
+		interrupts = <0 104 0x04
+			      0 105 0x04
+			      0 106 0x04
+			      0 107 0x04
+			      0 108 0x04
+			      0 109 0x04
+			      0 110 0x04
+			      0 111 0x04
+			      0 112 0x04
+			      0 113 0x04
+			      0 114 0x04
+			      0 115 0x04
+			      0 116 0x04
+			      0 117 0x04
+			      0 118 0x04
+			      0 119 0x04
+			      0 128 0x04
+			      0 129 0x04
+			      0 130 0x04
+			      0 131 0x04
+			      0 132 0x04
+			      0 133 0x04
+			      0 134 0x04
+			      0 135 0x04
+			      0 136 0x04
+			      0 137 0x04
+			      0 138 0x04
+			      0 139 0x04
+			      0 140 0x04
+			      0 141 0x04
+			      0 142 0x04
+			      0 143 0x04>;
+		clocks = <&tegra_car 34>;
+	};
+
 	gpio: gpio {
 		compatible = "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
-- 
1.7.1.1
