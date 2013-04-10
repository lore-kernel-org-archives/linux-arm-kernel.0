From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 10 Apr 2013 17:18:03 +0530
Subject: [PATCH 2/2] ARM: tegra: dts: dalmore: enable spi4
In-Reply-To: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
References: <1365594483-20651-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1365594483-20651-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SPI4 and add Winbond SPI flash W25Q32DW device
on CS0 line.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 12198d1..295a1be 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -823,6 +823,16 @@
 		};
 	};
 
+	spi at 7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+		spi-flash at 0 {
+			compatible = "winbond,w25q32dw";
+			reg = <0>;
+			spi-max-frequency = <20000000>;
+		};
+	};
+
 	kbc {
 		status = "okay";
 		nvidia,debounce-delay-ms = <640>;
-- 
1.7.1.1
