From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Jan 2013 18:26:20 +0530
Subject: [PATCH 4/7] ARM: DT: tegra114: add pinmux DT entry
In-Reply-To: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
References: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1359464183-6255-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT entry for pinmux and drive configuration addresses.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 74f6a77..210b4a7 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -91,6 +91,12 @@
 		interrupt-controller;
 	};
 
+	pinmux: pinmux {
+		compatible = "nvidia,tegra114-pinmux";
+		reg = <0x70000868 0x148		/* Pad control registers */
+		       0x70003000 0x40c>;	/* Mux registers */
+	};
+
 	serial at 70006000 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
-- 
1.7.1.1
