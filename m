From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 17 Jul 2015 00:33:51 +0200
Subject: [PATCH 1/3] arm64: add Rockchip architecture entry
In-Reply-To: <2820374.NgluYWXZkW@diego>
References: <2820374.NgluYWXZkW@diego>
Message-ID: <2658910.AevvbvQ8ln@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3368 is Rockchip's first ARM64 soc, build around 8 Cortex-A53 cores.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb1..6ad9971 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -202,6 +202,16 @@ config ARCH_QCOM
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
+config ARCH_ROCKCHIP
+	bool "Rockchip Platforms"
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARCH_REQUIRE_GPIOLIB
+	select PINCTRL
+	select PINCTRL_ROCKCHIP
+	help
+	  This enables support for the ARMv8 based Rockchip chipsets,
+	  like the RK3368.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
-- 
2.1.4
