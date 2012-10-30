From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 30 Oct 2012 12:35:25 +0530
Subject: [PATCH V3 3/4] ARM: tegra: dts: cardhu: enable SLINK4
In-Reply-To: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
References: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1351580726-17350-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SLINK4 in Tegra30 based platform Cardhu.
Setting maximum spi frequency to 25MHz.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- rename the max freq prop to spi-max-frequency

Changes from V2:
- make node name to spi@

 arch/arm/boot/dts/tegra30-cardhu.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index b245e6c..700f0a3 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -275,6 +275,11 @@
 		};
 	};
 
+	spi at 7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+	};
+
 	ahub {
 		i2s at 70080400 {
 			status = "okay";
-- 
1.7.1.1
