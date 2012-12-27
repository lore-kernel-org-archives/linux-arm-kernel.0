From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 27 Dec 2012 20:17:18 +0530
Subject: [PATCH v2 05/11] ARM: dt: tegra30: Add device node for APB MISC
In-Reply-To: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1356619644-18565-6-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APB misc contains multiple registers required by different modules
such as CAR.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 6765646..00e2d44 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -190,6 +190,11 @@
 		interrupt-controller;
 	};
 
+	apbmisc: apbmisc {
+		compatible = "nvidia,tegra30-apbmisc";
+		reg = <0x70000000 0x1000>;
+	};
+
 	pinmux: pinmux {
 		compatible = "nvidia,tegra30-pinmux";
 		reg = <0x70000868 0xd4    /* Pad control registers */
-- 
1.7.4.1
