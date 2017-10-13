From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 13 Oct 2017 09:54:35 +0100
Subject: [PATCH v2] arm64: dts: hikey960: Update HiKey960 with GPIO line
 names
In-Reply-To: <20171003085904.3733-1-linus.walleij@linaro.org>
References: <20171003085904.3733-1-linus.walleij@linaro.org>
Message-ID: <59E07F4B.5040506@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 2017/10/3 9:59, Linus Walleij wrote:
> This adds line names for all the GPIOs I could identify on the HiKey960
> schematic.
> 
> "GPIO-A" through "GPIO-L" are the most important since they give users
> a handle to look up the standard 96boards GPIOs from the GPIO character
> device.
> 
> The rest of the names are more informational, nice debug information
> for "lsgpio" so you can see that the right line is taken for the right
> function in the kernel for example.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Zhangfei Gao <zhangfei.gao@hisilicon.com>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Applied into hisilicon dt tree.
Thanks!

BR,
Wei

> ChangeLog v1->v2:
> - Make sure the DTS file compiles. A semicolon was missing. Sorry,
>   didn't have the right Aarch64 compiler to test it before.
> 
> Wei: can you test this please? I'm not sure it even compiles but
> I think it should look like this with maybe minor tweaks, if you know
> some of the undefined lines or see some errors feel free to fix it
> up.
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 319 ++++++++++++++++++++++
>  1 file changed, 319 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index fd4705c451e2..21e7618b8e97 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -196,6 +196,325 @@
>  	};
>  };
>  
> +/*
> + * Legend: proper name = the GPIO line is used as GPIO
> + *         NC = not connected (pin out but not routed from the chip to
> + *              anything the board)
> + *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
> + *         "" = no idea, schematic doesn't say, could be
> + *              unrouted (not connected to any external pin)
> + *         LSEC = Low Speed External Connector
> + *         HSEC = High Speed External Connector
> + *
> + * Line names are taken from "HiKey 960 Board ver A" schematics
> + * from Huawei. The 40 pin low speed expansion connector is named
> + * J2002 63453-140LF.
> + *
> + * For the lines routed to the external connectors the
> + * lines are named after the 96Boards CE Specification 1.0,
> + * Appendix "Expansion Connector Signal Description".
> + *
> + * When the 96Board naming of a line and the schematic name of
> + * the same line are in conflict, the 96Board specification
> + * takes precedence, which means that the external UART on the
> + * LSEC is named UART0 while the schematic and SoC names this
> + * UART3. This is only for the informational lines i.e. "[FOO]",
> + * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
> + * ones actually used for GPIO.
> + */
> +&gpio0 {
> +	/* GPIO_000-GPIO_007 */
> +	gpio-line-names =
> +		"",
> +		"TP901", /* TEST_MODE connected to TP901 */
> +		"[PMU0_SSI]",
> +		"[PMU1_SSI]",
> +		"[PMU2_SSI]",
> +		"[PMU0_CLKOUT]",
> +		"[JTAG_TCK]",
> +		"[JTAG_TMS]";
> +};
> +
> +&gpio1 {
> +	/* GPIO_008-GPIO_015 */
> +	gpio-line-names =
> +		"[JTAG_TRST_N]",
> +		"[JTAG_TDI]",
> +		"[JTAG_TDO]",
> +		"NC", "NC",
> +		"[I2C3_SCL]",
> +		"[I2C3_SDA]",
> +		"NC";
> +};
> +
> +&gpio2 {
> +	/* GPIO_016-GPIO_023 */
> +	gpio-line-names =
> +		"NC", "NC", "NC",
> +		"GPIO-J", /* LSEC pin 32: GPIO_019 */
> +		"GPIO_020_HDMI_SEL",
> +		"GPIO-L", /* LSEC pin 34: GPIO_021 */
> +		"GPIO_022_UFSBUCK_INT_N",
> +		"GPIO-G"; /* LSEC pin 29: LCD_TE0 */
> +};
> +
> +&gpio3 {
> +	/* GPIO_024-GPIO_031 */
> +	/* The rail from pin BK36 is named LCD_TE0, we assume to be muxed as GPIO for GPIO-G */
> +	gpio-line-names =
> +		"[CSI0_MCLK]", /* HSEC pin 15: ISP_CCLK0_MCAM */
> +		"[CSI1_MCLK]", /* HSEC pin 17: ISP_CCLK1_SCAM */
> +		"NC",
> +		"[I2C2_SCL]", /* HSEC pin 32: ISP_SCL0 */
> +		"[I2C2_SDA]", /* HSEC pin 34: ISP_SDA0 */
> +		"[I2C3_SCL]", /* HSEC pin 36: ISP_SCL1 */
> +		"[I2C3_SDA]", /* HSEC pin 38: ISP_SDA1 */
> +		"NC";
> +};
> +
> +&gpio4 {
> +	/* GPIO_032-GPIO_039 */
> +	gpio-line-names =
> +		"NC", "NC",
> +		"PWR_BTN_N", /* LSEC pin 4: GPIO_034_PWRON_DET */
> +		"GPIO_035_PMU2_EN",
> +		"GPIO_036_USB_HUB_RESET",
> +		"NC", "NC", "NC";
> +};
> +
> +&gpio5 {
> +	/* GPIO_040-GPIO_047 */
> +	gpio-line-names =
> +		"GPIO-H", /* LSEC pin 30: GPIO_040_LCD_RST_N */
> +		"GPIO_041_HDMI_PD",
> +		"TP904", /* Test point */
> +		"TP905", /* Test point */
> +		"NC", "NC",
> +		"GPIO_046_HUB_VDD33_EN",
> +		"GPIO_047_PMU1_EN";
> +};
> +
> +&gpio6 {
> +	/* GPIO_048-GPIO_055 */
> +	gpio-line-names =
> +		"NC", "NC", "NC",
> +		"GPIO_051_WIFI_EN",
> +		"GPIO-I", /* LSEC pin 31: GPIO_052_CAM0_RST_N */
> +		/*
> +		 * These two pins should be used for SD(IO) data according to the
> +		 * 96boards specification but seems to be repurposed for a IRDA UART.
> +		 * They are however named according to the spec.
> +		 */
> +		"[SD_DAT1]", /* HSEC pin 3: UART0_IRDA_RXD */
> +		"[SD_DAT2]", /* HSEC pin 5: UART0_IRDA_TXD */
> +		"[UART1_RXD]"; /* LSEC pin 13: DEBUG_UART6_RXD */
> +};
> +
> +&gpio7 {
> +	/* GPIO_056-GPIO_063 */
> +	gpio-line-names =
> +		"[UART1_TXD]", /* LSEC pin 11: DEBUG_UART6_TXD */
> +		"[UART0_CTS]", /* LSEC pin 3: UART3_CTS_N */
> +		"[UART0_RTS]", /* LSEC pin 9: UART3_RTS_N */
> +		"[UART0_RXD]", /* LSEC pin 7: UART3_RXD */
> +		"[UART0_TXD]", /* LSEC pin 5: UART3_TXD */
> +		"[SOC_BT_UART4_CTS_N]",
> +		"[SOC_BT_UART4_RTS_N]",
> +		"[SOC_BT_UART4_RXD]";
> +};
> +
> +&gpio8 {
> +	/* GPIO_064-GPIO_071 */
> +	gpio-line-names =
> +		"[SOC_BT_UART4_TXD]",
> +		"NC",
> +		"[PMU_HKADC_SSI]",
> +		"NC",
> +		"GPIO_068_SEL",
> +		"NC", "NC", "NC";
> +
> +};
> +
> +&gpio9 {
> +	/* GPIO_072-GPIO_079 */
> +	gpio-line-names =
> +		"NC", "NC", "NC",
> +		"GPIO-K", /* LSEC pin 33: GPIO_075_CAM1_RST_N */
> +		"NC", "NC", "NC", "NC";
> +};
> +
> +&gpio10 {
> +	/* GPIO_080-GPIO_087 */
> +	gpio-line-names = "NC", "NC", "NC", "NC", "NC", "NC", "NC", "NC";
> +};
> +
> +&gpio11 {
> +	/* GPIO_088-GPIO_095 */
> +	gpio-line-names =
> +		"NC",
> +		"[PCIE_PERST_N]",
> +		"NC", "NC", "NC", "NC", "NC", "NC";
> +};
> +
> +&gpio12 {
> +	/* GPIO_096-GPIO_103 */
> +	gpio-line-names = "NC", "NC", "NC", "", "", "", "", "NC";
> +};
> +
> +&gpio13 {
> +	/* GPIO_104-GPIO_111 */
> +	gpio-line-names = "NC", "NC", "NC", "NC", "NC", "NC", "NC", "NC";
> +};
> +
> +&gpio14 {
> +	/* GPIO_112-GPIO_119 */
> +	gpio-line-names = "NC", "NC", "NC", "NC", "NC", "NC", "NC", "NC";
> +};
> +
> +&gpio15 {
> +	/* GPIO_120-GPIO_127 */
> +	gpio-line-names =
> +		"NC", "NC", "NC", "NC", "NC", "NC",
> +		"GPIO_126_BT_EN",
> +		"TP902"; /* GPIO_127_JTAG_SEL0 */
> +};
> +
> +&gpio16 {
> +	/* GPIO_128-GPIO_135 */
> +	gpio-line-names = "", "", "", "", "", "", "", "";
> +};
> +
> +&gpio17 {
> +	/* GPIO_136-GPIO_143 */
> +	gpio-line-names = "", "", "", "", "", "", "", "";
> +};
> +
> +&gpio18 {
> +	/* GPIO_144-GPIO_151 */
> +	gpio-line-names =
> +		"[UFS_REF_CLK]",
> +		"[UFS_RST_N]",
> +		"[SPI1_SCLK]", /* HSEC pin 9: GPIO_146_SPI3_CLK */
> +		"[SPI1_DIN]", /* HSEC pin 11: GPIO_147_SPI3_DI */
> +		"[SPI1_DOUT]", /* HSEC pin 1: GPIO_148_SPI3_DO */
> +		"[SPI1_CS]", /* HSEC pin 7: GPIO_149_SPI3_CS0_N */
> +		"GPIO_150_USER_LED1",
> +		"GPIO_151_USER_LED2";
> +};
> +
> +&gpio19 {
> +	/* GPIO_152-GPIO_159 */
> +	gpio-line-names = "NC", "NC", "NC", "NC", "", "", "", "";
> +};
> +
> +&gpio20 {
> +	/* GPIO_160-GPIO_167 */
> +	gpio-line-names =
> +		"[SD_CLK]",
> +		"[SD_CMD]",
> +		"[SD_DATA0]",
> +		"[SD_DATA1]",
> +		"[SD_DATA2]",
> +		"[SD_DATA3]",
> +		"", "";
> +};
> +
> +&gpio21 {
> +	/* GPIO_168-GPIO_175 */
> +	gpio-line-names =
> +		"[WL_SDIO_CLK]",
> +		"[WL_SDIO_CMD]",
> +		"[WL_SDIO_DATA0]",
> +		"[WL_SDIO_DATA1]",
> +		"[WL_SDIO_DATA2]",
> +		"[WL_SDIO_DATA3]",
> +		"", "";
> +};
> +
> +&gpio22 {
> +	/* GPIO_176-GPIO_183 */
> +	gpio-line-names =
> +		"[GPIO_176_PMU_PWR_HOLD]",
> +		"NA",
> +		"[SYSCLK_EN]",
> +		"GPIO_179_WL_WAKEUP_AP",
> +		"GPIO_180_HDMI_INT",
> +		"NA",
> +		"GPIO-F", /* LSEC pin 28: LCD_BL_PWM */
> +		"[I2C0_SCL]"; /* LSEC pin 15 */
> +};
> +
> +&gpio23 {
> +	/* GPIO_184-GPIO_191 */
> +	gpio-line-names =
> +		"[I2C0_SDA]", /* LSEC pin 17 */
> +		"[I2C1_SCL]", /* Actual SoC I2C1 */
> +		"[I2C1_SDA]", /* Actual SoC I2C1 */
> +		"[I2C1_SCL]", /* LSEC pin 19: I2C7_SCL */
> +		"[I2C1_SDA]", /* LSEC pin 21: I2C7_SDA */
> +		"GPIO_189_USER_LED3",
> +		"GPIO_190_USER_LED4",
> +		"";
> +};
> +
> +&gpio24 {
> +	/* GPIO_192-GPIO_199 */
> +	gpio-line-names =
> +		"[PCM_DI]", /* LSEC pin 22: GPIO_192_I2S0_DI */
> +		"[PCM_DO]", /* LSEC pin 20: GPIO_193_I2S0_DO */
> +		"[PCM_CLK]", /* LSEC pin 18: GPIO_194_I2S0_XCLK */
> +		"[PCM_FS]", /* LSEC pin 16: GPIO_195_I2S0_XFS */
> +		"[GPIO_196_I2S2_DI]",
> +		"[GPIO_197_I2S2_DO]",
> +		"[GPIO_198_I2S2_XCLK]",
> +		"[GPIO_199_I2S2_XFS]";
> +};
> +
> +&gpio25 {
> +	/* GPIO_200-GPIO_207 */
> +	gpio-line-names =
> +		"NC",
> +		"NC",
> +		"GPIO_202_VBUS_TYPEC",
> +		"GPIO_203_SD_DET",
> +		"GPIO_204_PMU12_IRQ_N",
> +		"GPIO_205_WIFI_ACTIVE",
> +		"GPIO_206_USBSW_SEL",
> +		"GPIO_207_BT_ACTIVE";
> +};
> +
> +&gpio26 {
> +	/* GPIO_208-GPIO_215 */
> +	gpio-line-names =
> +		"GPIO-A", /* LSEC pin 23: GPIO_208 */
> +		"GPIO-B", /* LSEC pin 24: GPIO_209 */
> +		"GPIO-C", /* LSEC pin 25: GPIO_210 */
> +		"GPIO-D", /* LSEC pin 26: GPIO_211 */
> +		"GPIO-E", /* LSEC pin 27: GPIO_212 */
> +		"[PCIE_CLKREQ_N]",
> +		"[PCIE_WAKE_N]",
> +		"[SPI0_CLK]"; /* LSEC pin 8: SPI2_CLK */
> +};
> +
> +&gpio27 {
> +	/* GPIO_216-GPIO_223 */
> +	gpio-line-names =
> +		"[SPI0_DIN]", /* LSEC pin 10: SPI2_DI */
> +		"[SPI0_DOUT]", /* LSEC pin 14: SPI2_DO */
> +		"[SPI0_CS]", /* LSEC pin 12: SPI2_CS0_N */
> +		"GPIO_219_CC_INT",
> +		"NC",
> +		"NC",
> +		"[PMU_INT]",
> +		"";
> +};
> +
> +&gpio28 {
> +	/* GPIO_224-GPIO_231 */
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "";
> +};
> +
>  &i2c0 {
>  	/* On Low speed expansion */
>  	label = "LS-I2C0";
> 
