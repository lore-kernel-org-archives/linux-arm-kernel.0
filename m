From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 6 Jun 2017 20:50:42 +0300
Subject: [PATCH v2 1/2] ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
In-Reply-To: <cover.1496771145.git.leonard.crestez@nxp.com>
References: <cover.1496771145.git.leonard.crestez@nxp.com>
Message-ID: <1b0dac2d2236f86c87b066a95f33bd80a5ad5c6b.1496771145.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for imx6ull is already present but it's based on
of_machine_is_compatible("fsl,imx6ull") checks. Add it to the MXC_CPU_*
enumeration as well.

This also fixes /sys/devices/soc0/soc_id reading "Unknown".

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 3 +++
 arch/arm/mach-imx/mxc.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index b3347d3..94906ed 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -131,6 +131,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6UL:
 		soc_id = "i.MX6UL";
 		break;
+	case MXC_CPU_IMX6ULL:
+		soc_id = "i.MX6ULL";
+		break;
 	case MXC_CPU_IMX7D:
 		soc_id = "i.MX7D";
 		break;
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 34f2ff6..e00d626 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,6 +39,7 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6ULL		0x65
 #define MXC_CPU_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -73,6 +74,11 @@ static inline bool cpu_is_imx6ul(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6UL;
 }
 
+static inline bool cpu_is_imx6ull(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
-- 
2.7.4
