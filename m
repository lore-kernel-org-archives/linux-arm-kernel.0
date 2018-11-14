From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 14 Nov 2018 18:52:37 +0100
Subject: [PATCH v4 1/6] arm64: add basic Kconfig symbols for i.MX8
Message-ID: <20181114175242.12468-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic Kconfig symbols to make the MXC architecture available
in the ARM64 world.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
v2: fix "enabled" typo.
v3: use SoC suboption in Kconfig.platforms instead of drivers/soc
v4: rebased to 4.20-rc1
---
 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..072c605f671a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -142,6 +142,20 @@ config ARCH_MVEBU
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
 
+config ARCH_MXC
+	bool "ARMv8 based NXP i.MX SoC family"
+	help
+	  This enables support for the ARMv8 based SoCs in the
+	  NXP i.MX family.
+
+config SOC_IMX8MQ
+	bool "i.MX8MQ support"
+	depends on ARCH_MXC
+	select ARM64_ERRATUM_843419
+	select ARM64_ERRATUM_845719
+	help
+	  This enables support for the i.MX8MQ SoC.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.19.1
