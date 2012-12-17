From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 17 Dec 2012 17:38:21 +0530
Subject: [PATCH 4/4] ARM: tegra: dts: add dma requestor and port numbers for
 serial controller
In-Reply-To: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
References: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1355746101-15291-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add parameters for:
- port-number to enable the port index in device interface.
- dma requestor id to make trigger for apb dma burst transfer
  from controller.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |   10 ++++++++++
 arch/arm/boot/dts/tegra30.dtsi |   10 ++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index b8effa1..ca3a2a3 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -199,6 +199,8 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		port-number = <0>;
+		nvidia,dma-request-selector = <&apbdma 8>;
 		status = "disabled";
 	};
 
@@ -207,6 +209,8 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
+		port-number = <1>;
+		nvidia,dma-request-selector = <&apbdma 9>;
 		status = "disabled";
 	};
 
@@ -215,6 +219,8 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
+		port-number = <2>;
+		nvidia,dma-request-selector = <&apbdma 10>;
 		status = "disabled";
 	};
 
@@ -223,6 +229,8 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
+		port-number = <3>;
+		nvidia,dma-request-selector = <&apbdma 19>;
 		status = "disabled";
 	};
 
@@ -231,6 +239,8 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
+		port-number = <4>;
+		nvidia,dma-request-selector = <&apbdma 20>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 529fdb8..dcb9caa 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -195,6 +195,8 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		port-number = <0>;
+		nvidia,dma-request-selector = <&apbdma 8>;
 		status = "disabled";
 	};
 
@@ -203,6 +205,8 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
+		port-number = <1>;
+		nvidia,dma-request-selector = <&apbdma 9>;
 		status = "disabled";
 	};
 
@@ -211,6 +215,8 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
+		port-number = <2>;
+		nvidia,dma-request-selector = <&apbdma 10>;
 		status = "disabled";
 	};
 
@@ -219,6 +225,8 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
+		port-number = <3>;
+		nvidia,dma-request-selector = <&apbdma 19>;
 		status = "disabled";
 	};
 
@@ -227,6 +235,8 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
+		port-number = <4>;
+		nvidia,dma-request-selector = <&apbdma 20>;
 		status = "disabled";
 	};
 
-- 
1.7.1.1
