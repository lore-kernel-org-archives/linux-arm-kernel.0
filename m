From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  6 Jun 2016 18:36:36 +0200
Subject: [PATCH 7/8] arm64: tegra: Enable debug serial on Jetson TX1
In-Reply-To: <20160606163637.14234-1-thierry.reding@gmail.com>
References: <20160606163637.14234-1-thierry.reding@gmail.com>
Message-ID: <20160606163637.14234-7-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 8335bbe3ab6c..5fda583351d7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -12,6 +12,10 @@
 		serial0 = &uarta;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x0>;
-- 
2.8.3
