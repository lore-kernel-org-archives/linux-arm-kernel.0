From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 31 Jul 2017 13:38:31 +0200
Subject: [PATCH 1/2] clk: meson8b: expose every clock in the bindings
In-Reply-To: <20170731113832.26490-1-jbrunet@baylibre.com>
References: <20170731113832.26490-1-jbrunet@baylibre.com>
Message-ID: <20170731113832.26490-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose all clocks which maybe used as DT bindings
Only clock ids internal the controller remain un-exposed (none on this
particular controller at the moment)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.h              | 103 ++-----------------------------
 include/dt-bindings/clock/meson8b-clkc.h |  70 +++++++++++++++++++++
 2 files changed, 74 insertions(+), 99 deletions(-)

diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index a687e02547dc..c139bb3273ca 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -60,107 +60,12 @@
  * CLKID index values
  *
  * These indices are entirely contrived and do not map onto the hardware.
- * Migrate them out of this header and into the DT header file when they need
- * to be exposed to client nodes in DT: include/dt-bindings/clock/meson8b-clkc.h
+ * It has now been decided to expose everything by default in the DT header:
+ * include/dt-bindings/clock/gxbb-clkc.h. Only the clocks ids we don't want
+ * to expose, such as the internal muxes and dividers of composite clocks,
+ * will remain defined here.
  */
 
-/* CLKID_UNUSED */
-/* CLKID_XTAL */
-/* CLKID_PLL_FIXED */
-/* CLKID_PLL_VID */
-/* CLKID_PLL_SYS */
-/* CLKID_FCLK_DIV2 */
-/* CLKID_FCLK_DIV3 */
-/* CLKID_FCLK_DIV4 */
-/* CLKID_FCLK_DIV5 */
-/* CLKID_FCLK_DIV7 */
-/* CLKID_CLK81 */
-/* CLKID_MALI */
-/* CLKID_CPUCLK */
-/* CLKID_ZERO */
-/* CLKID_MPEG_SEL */
-/* CLKID_MPEG_DIV */
-#define CLKID_DDR		16
-#define CLKID_DOS		17
-#define CLKID_ISA		18
-#define CLKID_PL301		19
-#define CLKID_PERIPHS		20
-#define CLKID_SPICC		21
-#define CLKID_I2C		22
-/* #define CLKID_SAR_ADC */
-#define CLKID_SMART_CARD	24
-/* #define CLKID_RNG0 */
-#define CLKID_UART0		26
-#define CLKID_SDHC		27
-#define CLKID_STREAM		28
-#define CLKID_ASYNC_FIFO	29
-/* #define CLKID_SDIO */
-#define CLKID_ABUF		31
-#define CLKID_HIU_IFACE		32
-#define CLKID_ASSIST_MISC	33
-#define CLKID_SPI		34
-#define CLKID_I2S_SPDIF		35
-/* #define CLKID_ETH */
-#define CLKID_DEMUX		37
-#define CLKID_AIU_GLUE		38
-#define CLKID_IEC958		39
-#define CLKID_I2S_OUT		40
-#define CLKID_AMCLK		41
-#define CLKID_AIFIFO2		42
-#define CLKID_MIXER		43
-#define CLKID_MIXER_IFACE	44
-#define CLKID_ADC		45
-#define CLKID_BLKMV		46
-#define CLKID_AIU		47
-#define CLKID_UART1		48
-#define CLKID_G2D		49
-/* #define CLKID_USB0 */
-/* #define CLKID_USB1 */
-#define CLKID_RESET		52
-#define CLKID_NAND		53
-#define CLKID_DOS_PARSER	54
-/* #define CLKID_USB */
-#define CLKID_VDIN1		56
-#define CLKID_AHB_ARB0		57
-#define CLKID_EFUSE		58
-#define CLKID_BOOT_ROM		59
-#define CLKID_AHB_DATA_BUS	60
-#define CLKID_AHB_CTRL_BUS	61
-#define CLKID_HDMI_INTR_SYNC	62
-#define CLKID_HDMI_PCLK		63
-/* CLKID_USB1_DDR_BRIDGE */
-/* CLKID_USB0_DDR_BRIDGE */
-#define CLKID_MMC_PCLK		66
-#define CLKID_DVIN		67
-#define CLKID_UART2		68
-/* #define CLKID_SANA */
-#define CLKID_VPU_INTR		70
-#define CLKID_SEC_AHB_AHB3_BRIDGE	71
-#define CLKID_CLK81_A9		72
-#define CLKID_VCLK2_VENCI0	73
-#define CLKID_VCLK2_VENCI1	74
-#define CLKID_VCLK2_VENCP0	75
-#define CLKID_VCLK2_VENCP1	76
-#define CLKID_GCLK_VENCI_INT	77
-#define CLKID_GCLK_VENCP_INT	78
-#define CLKID_DAC_CLK		79
-#define CLKID_AOCLK_GATE	80
-#define CLKID_IEC958_GATE	81
-#define CLKID_ENC480P		82
-#define CLKID_RNG1		83
-#define CLKID_GCLK_VENCL_INT	84
-#define CLKID_VCLK2_VENCLMCC	85
-#define CLKID_VCLK2_VENCL	86
-#define CLKID_VCLK2_OTHER	87
-#define CLKID_EDP		88
-#define CLKID_AO_MEDIA_CPU	89
-#define CLKID_AO_AHB_SRAM	90
-#define CLKID_AO_AHB_BUS	91
-#define CLKID_AO_IFACE		92
-#define CLKID_MPLL0		93
-#define CLKID_MPLL1		94
-#define CLKID_MPLL2		95
-
 #define CLK_NR_CLKS		96
 
 /* include the CLKIDs that have been made part of the stable DT binding */
diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index e29227fb52a1..a9c0306330b6 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -21,15 +21,85 @@
 #define CLKID_ZERO		13
 #define CLKID_MPEG_SEL		14
 #define CLKID_MPEG_DIV		15
+#define CLKID_DDR		16
+#define CLKID_DOS		17
+#define CLKID_ISA		18
+#define CLKID_PL301		19
+#define CLKID_PERIPHS		20
+#define CLKID_SPICC		21
+#define CLKID_I2C		22
 #define CLKID_SAR_ADC		23
+#define CLKID_SMART_CARD	24
 #define CLKID_RNG0		25
+#define CLKID_UART0		26
+#define CLKID_SDHC		27
+#define CLKID_STREAM		28
+#define CLKID_ASYNC_FIFO	29
 #define CLKID_SDIO		30
+#define CLKID_ABUF		31
+#define CLKID_HIU_IFACE		32
+#define CLKID_ASSIST_MISC	33
+#define CLKID_SPI		34
+#define CLKID_I2S_SPDIF		35
 #define CLKID_ETH		36
+#define CLKID_DEMUX		37
+#define CLKID_AIU_GLUE		38
+#define CLKID_IEC958		39
+#define CLKID_I2S_OUT		40
+#define CLKID_AMCLK		41
+#define CLKID_AIFIFO2		42
+#define CLKID_MIXER		43
+#define CLKID_MIXER_IFACE	44
+#define CLKID_ADC		45
+#define CLKID_BLKMV		46
+#define CLKID_AIU		47
+#define CLKID_UART1		48
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
+#define CLKID_HDMI_PCLK		63
 #define CLKID_USB1_DDR_BRIDGE	64
 #define CLKID_USB0_DDR_BRIDGE	65
+#define CLKID_MMC_PCLK		66
+#define CLKID_DVIN		67
+#define CLKID_UART2		68
 #define CLKID_SANA		69
+#define CLKID_VPU_INTR		70
+#define CLKID_SEC_AHB_AHB3_BRIDGE	71
+#define CLKID_CLK81_A9		72
+#define CLKID_VCLK2_VENCI0	73
+#define CLKID_VCLK2_VENCI1	74
+#define CLKID_VCLK2_VENCP0	75
+#define CLKID_VCLK2_VENCP1	76
+#define CLKID_GCLK_VENCI_INT	77
+#define CLKID_GCLK_VENCP_INT	78
+#define CLKID_DAC_CLK		79
+#define CLKID_AOCLK_GATE	80
+#define CLKID_IEC958_GATE	81
+#define CLKID_ENC480P		82
+#define CLKID_RNG1		83
+#define CLKID_GCLK_VENCL_INT	84
+#define CLKID_VCLK2_VENCLMCC	85
+#define CLKID_VCLK2_VENCL	86
+#define CLKID_VCLK2_OTHER	87
+#define CLKID_EDP		88
+#define CLKID_AO_MEDIA_CPU	89
+#define CLKID_AO_AHB_SRAM	90
+#define CLKID_AO_AHB_BUS	91
+#define CLKID_AO_IFACE		92
+#define CLKID_MPLL0		93
+#define CLKID_MPLL1		94
+#define CLKID_MPLL2		95
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.9.4
