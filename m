From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 19 Dec 2012 20:27:12 +0530
Subject: [PATCH] ARM: tegra30: tegra30 gpio is not compatible with tegra20 gpio
Message-ID: <1355929032-26549-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra30 gpio controller is not compatible with the tegra20 due to
their bank stride i.e. Tegra20 bank stride is 0x80 where Tegra30
bank stride is 0x100.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 80a0edf..dfa9f57 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -176,7 +176,7 @@
 	};
 
 	gpio: gpio {
-		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
+		compatible = "nvidia,tegra30-gpio"
 		reg = <0x6000d000 0x1000>;
 		interrupts = <0 32 0x04
 			      0 33 0x04
-- 
1.7.1.1
