From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 31 Jul 2017 13:38:32 +0200
Subject: [PATCH 2/2] clk: meson-gxbb: expose almost every clock in the bindings
In-Reply-To: <20170731113832.26490-1-jbrunet@baylibre.com>
References: <20170731113832.26490-1-jbrunet@baylibre.com>
Message-ID: <20170731113832.26490-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose all clocks which maybe used as DT bindings
Only clock ids internal the controller remain un-exposed

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 117 ++--------------------------------
 include/dt-bindings/clock/gxbb-clkc.h |  60 +++++++++++++++++
 2 files changed, 67 insertions(+), 110 deletions(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index d63e77e8433d..2c8986d3232c 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -167,130 +167,27 @@
  * CLKID index values
  *
  * These indices are entirely contrived and do not map onto the hardware.
- * Migrate them out of this header and into the DT header file when they need
- * to be exposed to client nodes in DT: include/dt-bindings/clock/gxbb-clkc.h
+ * It has now been decided to expose everything by default in the DT header:
+ * include/dt-bindings/clock/gxbb-clkc.h. Only the clocks ids we don't want
+ * to expose, such as the internal muxes and dividers of composite clocks,
+ * will remain defined here.
  */
-#define CLKID_SYS_PLL		  0
 /* ID 1 is unused (it was used by the non-existing CLKID_CPUCLK before) */
-/* CLKID_HDMI_PLL */
-#define CLKID_FIXED_PLL		  3
-/* CLKID_FCLK_DIV2 */
-/* CLKID_FCLK_DIV3 */
-/* CLKID_FCLK_DIV4 */
-#define CLKID_FCLK_DIV5		  7
-#define CLKID_FCLK_DIV7		  8
-/* CLKID_GP0_PLL */
 #define CLKID_MPEG_SEL		  10
 #define CLKID_MPEG_DIV		  11
-/* CLKID_CLK81 */
-#define CLKID_MPLL0		  13
-#define CLKID_MPLL1		  14
-/* CLKID_MPLL2 */
-#define CLKID_DDR		  16
-#define CLKID_DOS		  17
-#define CLKID_ISA		  18
-#define CLKID_PL301		  19
-#define CLKID_PERIPHS		  20
-/* CLKID_SPICC */
-/* CLKID_I2C */
-/* #define CLKID_SAR_ADC */
-#define CLKID_SMART_CARD	  24
-/* CLKID_RNG0 */
-/* CLKID_UART0 */
-#define CLKID_SDHC		  27
-#define CLKID_STREAM		  28
-#define CLKID_ASYNC_FIFO	  29
-#define CLKID_SDIO		  30
-#define CLKID_ABUF		  31
-#define CLKID_HIU_IFACE		  32
-#define CLKID_ASSIST_MISC	  33
-/* CLKID_SPI */
-#define CLKID_I2S_SPDIF		  35
-/* CLKID_ETH */
-#define CLKID_DEMUX		  37
-/* CLKID_AIU_GLUE */
-/* CLKID_IEC958 */
-/* CLKID_I2S_OUT */
-#define CLKID_AMCLK		  41
-#define CLKID_AIFIFO2		  42
-#define CLKID_MIXER		  43
-/* CLKID_MIXER_IFACE */
-#define CLKID_ADC		  45
-#define CLKID_BLKMV		  46
-/* CLKID_AIU */
-/* CLKID_UART1 */
-#define CLKID_G2D		  49
-/* CLKID_USB0 */
-/* CLKID_USB1 */
-#define CLKID_RESET		  52
-#define CLKID_NAND		  53
-#define CLKID_DOS_PARSER	  54
-/* CLKID_USB */
-#define CLKID_VDIN1		  56
-#define CLKID_AHB_ARB0		  57
-#define CLKID_EFUSE		  58
-#define CLKID_BOOT_ROM		  59
-#define CLKID_AHB_DATA_BUS	  60
-#define CLKID_AHB_CTRL_BUS	  61
-#define CLKID_HDMI_INTR_SYNC	  62
-/* CLKID_HDMI_PCLK */
-/* CLKID_USB1_DDR_BRIDGE */
-/* CLKID_USB0_DDR_BRIDGE */
-#define CLKID_MMC_PCLK		  66
-#define CLKID_DVIN		  67
-/* CLKID_UART2 */
-/* #define CLKID_SANA */
-#define CLKID_VPU_INTR		  70
-#define CLKID_SEC_AHB_AHB3_BRIDGE 71
-#define CLKID_CLK81_A53		  72
-#define CLKID_VCLK2_VENCI0	  73
-#define CLKID_VCLK2_VENCI1	  74
-#define CLKID_VCLK2_VENCP0	  75
-#define CLKID_VCLK2_VENCP1	  76
-/* CLKID_GCLK_VENCI_INT0 */
-#define CLKID_GCLK_VENCI_INT	  78
-#define CLKID_DAC_CLK		  79
-/* CLKID_AOCLK_GATE */
-/* CLKID_IEC958_GATE */
-#define CLKID_ENC480P		  82
-#define CLKID_RNG1		  83
-#define CLKID_GCLK_VENCI_INT1	  84
-#define CLKID_VCLK2_VENCLMCC	  85
-#define CLKID_VCLK2_VENCL	  86
-#define CLKID_VCLK_OTHER	  87
-#define CLKID_EDP		  88
-#define CLKID_AO_MEDIA_CPU	  89
-#define CLKID_AO_AHB_SRAM	  90
-#define CLKID_AO_AHB_BUS	  91
-#define CLKID_AO_IFACE		  92
-/* CLKID_AO_I2C */
-/* CLKID_SD_EMMC_A */
-/* CLKID_SD_EMMC_B */
-/* CLKID_SD_EMMC_C */
-/* CLKID_SAR_ADC_CLK */
-/* CLKID_SAR_ADC_SEL */
 #define CLKID_SAR_ADC_DIV	  99
-/* CLKID_MALI_0_SEL */
-#define CLKID_MALI_0_DIV	 101
-/* CLKID_MALI_0	*/
-/* CLKID_MALI_1_SEL */
-#define CLKID_MALI_1_DIV	 104
-/* CLKID_MALI_1	*/
-/* CLKID_MALI	*/
-/* CLKID_CTS_AMCLK */
+#define CLKID_MALI_0_DIV	  101
+#define CLKID_MALI_1_DIV	  104
 #define CLKID_CTS_AMCLK_SEL	  108
 #define CLKID_CTS_AMCLK_DIV	  109
-/* CLKID_CTS_MCLK_I958 */
 #define CLKID_CTS_MCLK_I958_SEL	  111
 #define CLKID_CTS_MCLK_I958_DIV	  112
-/* CLKID_CTS_I958 */
-#define CLKID_32K_CLK		  114
 #define CLKID_32K_CLK_SEL	  115
 #define CLKID_32K_CLK_DIV	  116
 
 #define NR_CLKS			  117
 
-/* include the CLKIDs that have been made part of the stable DT binding */
+/* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
 
 #endif /* __GXBB_H */
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index e3e9f7919c31..e07fea011ebd 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -5,37 +5,96 @@
 #ifndef __GXBB_CLKC_H
 #define __GXBB_CLKC_H
 
+#define CLKID_SYS_PLL		0
 #define CLKID_HDMI_PLL		2
+#define CLKID_FIXED_PLL		3
 #define CLKID_FCLK_DIV2		4
 #define CLKID_FCLK_DIV3		5
 #define CLKID_FCLK_DIV4		6
+#define CLKID_FCLK_DIV5		7
+#define CLKID_FCLK_DIV7		8
 #define CLKID_GP0_PLL		9
 #define CLKID_CLK81		12
+#define CLKID_MPLL0		13
+#define CLKID_MPLL1		14
 #define CLKID_MPLL2		15
+#define CLKID_DDR		16
+#define CLKID_DOS		17
+#define CLKID_ISA		18
+#define CLKID_PL301		19
+#define CLKID_PERIPHS		20
 #define CLKID_SPICC		21
 #define CLKID_I2C		22
 #define CLKID_SAR_ADC		23
+#define CLKID_SMART_CARD	24
 #define CLKID_RNG0		25
 #define CLKID_UART0		26
+#define CLKID_SDHC		27
+#define CLKID_STREAM		28
+#define CLKID_ASYNC_FIFO	29
+#define CLKID_SDIO		30
+#define CLKID_ABUF		31
+#define CLKID_HIU_IFACE		32
+#define CLKID_ASSIST_MISC	33
 #define CLKID_SPI		34
 #define CLKID_ETH		36
+#define CLKID_I2S_SPDIF		35
+#define CLKID_DEMUX		37
 #define CLKID_AIU_GLUE		38
 #define CLKID_IEC958		39
 #define CLKID_I2S_OUT		40
+#define CLKID_AMCLK		41
+#define CLKID_AIFIFO2		42
+#define CLKID_MIXER		43
 #define CLKID_MIXER_IFACE	44
+#define CLKID_ADC		45
+#define CLKID_BLKMV		46
 #define CLKID_AIU		47
 #define CLKID_UART1		48
+#define CLKID_G2D		49
 #define CLKID_USB0		50
 #define CLKID_USB1		51
+#define CLKID_RESET		52
+#define CLKID_NAND		53
+#define CLKID_DOS_PARSER	54
 #define CLKID_USB		55
+#define CLKID_VDIN1		56
+#define CLKID_AHB_ARB0		57
+#define CLKID_EFUSE		58
+#define CLKID_BOOT_ROM		59
+#define CLKID_AHB_DATA_BUS	60
+#define CLKID_AHB_CTRL_BUS	61
+#define CLKID_HDMI_INTR_SYNC	62
 #define CLKID_HDMI_PCLK		63
 #define CLKID_USB1_DDR_BRIDGE	64
 #define CLKID_USB0_DDR_BRIDGE	65
+#define CLKID_MMC_PCLK		66
+#define CLKID_DVIN		67
 #define CLKID_UART2		68
 #define CLKID_SANA		69
+#define CLKID_VPU_INTR		70
+#define CLKID_SEC_AHB_AHB3_BRIDGE 71
+#define CLKID_CLK81_A53		72
+#define CLKID_VCLK2_VENCI0	73
+#define CLKID_VCLK2_VENCI1	74
+#define CLKID_VCLK2_VENCP0	75
+#define CLKID_VCLK2_VENCP1	76
 #define CLKID_GCLK_VENCI_INT0	77
+#define CLKID_GCLK_VENCI_INT	78
+#define CLKID_DAC_CLK		79
 #define CLKID_AOCLK_GATE	80
 #define CLKID_IEC958_GATE	81
+#define CLKID_ENC480P		82
+#define CLKID_RNG1		83
+#define CLKID_GCLK_VENCI_INT1	84
+#define CLKID_VCLK2_VENCLMCC	85
+#define CLKID_VCLK2_VENCL	86
+#define CLKID_VCLK_OTHER	87
+#define CLKID_EDP		88
+#define CLKID_AO_MEDIA_CPU	89
+#define CLKID_AO_AHB_SRAM	90
+#define CLKID_AO_AHB_BUS	91
+#define CLKID_AO_IFACE		92
 #define CLKID_AO_I2C		93
 #define CLKID_SD_EMMC_A		94
 #define CLKID_SD_EMMC_B		95
@@ -50,5 +109,6 @@
 #define CLKID_CTS_AMCLK		107
 #define CLKID_CTS_MCLK_I958	110
 #define CLKID_CTS_I958		113
+#define CLKID_32K_CLK		114
 
 #endif /* __GXBB_CLKC_H */
-- 
2.9.4
