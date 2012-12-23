From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Sun, 23 Dec 2012 16:35:45 +0530
Subject: [PATCH 05/11] ARM: dt: tegra30: Add device node for APB MISC
In-Reply-To: <1356260751-3667-1-git-send-email-pgaikwad@nvidia.com>
References: <1356260751-3667-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1356260751-3667-6-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APB misc contains multiple registers required by different modules
such as CAR.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 74d607a..356c0bf 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -77,6 +77,11 @@
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
