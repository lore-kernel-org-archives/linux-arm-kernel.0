From: neko@bakuhatsu.net (Matt Sealey)
Date: Mon, 26 Aug 2013 08:41:52 -0500
Subject: [PATCH] ARM: i.MX6: dts: change iomuxc pinctrl config to match
 Rev. 0 IMX6DQRM
In-Reply-To: <1377495568-9368-1-git-send-email-alison_chaiken@mentor.com>
References: <1377495568-9368-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <CAHCPf3uSf20CJV4x4K3N0DU-nOmguJPrsEZynhXoeEb0eMnP3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Have these been cross-referenced against the same table in Rev 1 of
the manual (4/2013)?

On Mon, Aug 26, 2013 at 12:39 AM,  <alison_chaiken@mentor.com> wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
>
> Update imx6.dtsi iomuxc pinctrl config settings to reflect Table 4-1 of Rev. 0
> (11/2012) of IMX6DQRM, i.MX6 technical reference manual.
>
> Impact:
> USDHC: increase drive speed and impedance.
> I2C and EIM: change drive impedance and disable open-drain.
> ECSPI: change drive impedance.
> ESAI and ENET: probably pedantic changes.
>
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi |  148 +++++++++++++--------------
>  arch/arm/boot/dts/imx6q.dtsi  |  226 ++++++++++++++++++++---------------------
>  arch/arm/boot/dts/imx6sl.dtsi |   48 ++++-----
>  3 files changed, 211 insertions(+), 211 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 2b3ecd6..36075b0 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -51,9 +51,9 @@
>                                 ecspi1 {
>                                         pinctrl_ecspi1_1: ecspi1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_EIM_D17__ECSPI1_MISO 0x100b1
> -                                                       MX6DL_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
> -                                                       MX6DL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
> +                                                       MX6DL_PAD_EIM_D17__ECSPI1_MISO 0x1b0b0
> +                                                       MX6DL_PAD_EIM_D18__ECSPI1_MOSI 0x1b0b0
> +                                                       MX6DL_PAD_EIM_D16__ECSPI1_SCLK 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -63,19 +63,19 @@
>                                                 fsl,pins = <
>                                                         MX6DL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
>                                                         MX6DL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +                                                       MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x13030
> +                                                       MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
> +                                                       MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
> +                                                       MX6DL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
> +                                                       MX6DL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
> +                                                       MX6DL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
>                                                         MX6DL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +                                                       MX6DL_PAD_RGMII_RXC__RGMII_RXC       0x13030
> +                                                       MX6DL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
> +                                                       MX6DL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
> +                                                       MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
> +                                                       MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
> +                                                       MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
>                                                         MX6DL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
>                                                 >;
>                                         };
> @@ -84,19 +84,19 @@
>                                                 fsl,pins = <
>                                                         MX6DL_PAD_KEY_COL1__ENET_MDIO        0x1b0b0
>                                                         MX6DL_PAD_KEY_COL2__ENET_MDC         0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +                                                       MX6DL_PAD_RGMII_TXC__RGMII_TXC       0x13030
> +                                                       MX6DL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
> +                                                       MX6DL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
> +                                                       MX6DL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
> +                                                       MX6DL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
> +                                                       MX6DL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
>                                                         MX6DL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> -                                                       MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +                                                       MX6DL_PAD_RGMII_RXC__RGMII_RXC       0x13030
> +                                                       MX6DL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
> +                                                       MX6DL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
> +                                                       MX6DL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
> +                                                       MX6DL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
> +                                                       MX6DL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
>                                                 >;
>                                         };
>                                 };
> @@ -104,23 +104,23 @@
>                                 gpmi-nand {
>                                         pinctrl_gpmi_nand_1: gpmi-nand-1 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
> -                                                       MX6DL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
> -                                                       MX6DL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
> -                                                       MX6DL_PAD_NANDF_RB0__NAND_READY_B 0xb000
> -                                                       MX6DL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
> -                                                       MX6DL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
> -                                                       MX6DL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
> -                                                       MX6DL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
> -                                                       MX6DL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
> -                                                       MX6DL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
> -                                                       MX6DL_PAD_SD4_DAT0__NAND_DQS      0x00b1
> +                                                       MX6DL_PAD_NANDF_CLE__NAND_CLE     0x1b0b0
> +                                                       MX6DL_PAD_NANDF_ALE__NAND_ALE     0x1b0b0
> +                                                       MX6DL_PAD_NANDF_WP_B__NAND_WP_B   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_RB0__NAND_READY_B 0x1b0b0
> +                                                       MX6DL_PAD_NANDF_CS0__NAND_CE0_B   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_CS1__NAND_CE1_B   0x1b0b0
> +                                                       MX6DL_PAD_SD4_CMD__NAND_RE_B      0x1b0b0
> +                                                       MX6DL_PAD_SD4_CLK__NAND_WE_B      0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D0__NAND_DATA00   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D1__NAND_DATA01   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D2__NAND_DATA02   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D3__NAND_DATA03   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D4__NAND_DATA04   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D5__NAND_DATA05   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D6__NAND_DATA06   0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D7__NAND_DATA07   0x1b0b0
> +                                                       MX6DL_PAD_SD4_DAT0__NAND_DQS      0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -128,8 +128,8 @@
>                                 i2c1 {
>                                         pinctrl_i2c1_2: i2c1grp-2 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
> -                                                       MX6DL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
> +                                                       MX6DL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b0b0
> +                                                       MX6DL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -137,8 +137,8 @@
>                                 uart1 {
>                                         pinctrl_uart1_1: uart1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
> -                                                       MX6DL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
> +                                                       MX6DL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b0
> +                                                       MX6DL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -146,8 +146,8 @@
>                                 uart4 {
>                                         pinctrl_uart4_1: uart4grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
> -                                                       MX6DL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
> +                                                       MX6DL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b0
> +                                                       MX6DL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -155,7 +155,7 @@
>                                 usbotg {
>                                         pinctrl_usbotg_2: usbotggrp-2 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
> +                                                       MX6DL_PAD_ENET_RX_ER__USB_OTG_ID 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -163,16 +163,16 @@
>                                 usdhc2 {
>                                         pinctrl_usdhc2_1: usdhc2grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_SD2_CMD__SD2_CMD    0x17059
> +                                                       MX6DL_PAD_SD2_CMD__SD2_CMD    0x1b0b0
>                                                         MX6DL_PAD_SD2_CLK__SD2_CLK    0x10059
> -                                                       MX6DL_PAD_SD2_DAT0__SD2_DATA0 0x17059
> -                                                       MX6DL_PAD_SD2_DAT1__SD2_DATA1 0x17059
> -                                                       MX6DL_PAD_SD2_DAT2__SD2_DATA2 0x17059
> -                                                       MX6DL_PAD_SD2_DAT3__SD2_DATA3 0x17059
> -                                                       MX6DL_PAD_NANDF_D4__SD2_DATA4 0x17059
> -                                                       MX6DL_PAD_NANDF_D5__SD2_DATA5 0x17059
> -                                                       MX6DL_PAD_NANDF_D6__SD2_DATA6 0x17059
> -                                                       MX6DL_PAD_NANDF_D7__SD2_DATA7 0x17059
> +                                                       MX6DL_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
> +                                                       MX6DL_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
> +                                                       MX6DL_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
> +                                                       MX6DL_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D4__SD2_DATA4 0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D5__SD2_DATA5 0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D6__SD2_DATA6 0x1b0b0
> +                                                       MX6DL_PAD_NANDF_D7__SD2_DATA7 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -180,27 +180,27 @@
>                                 usdhc3 {
>                                         pinctrl_usdhc3_1: usdhc3grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_SD3_CMD__SD3_CMD    0x17059
> +                                                       MX6DL_PAD_SD3_CMD__SD3_CMD    0x1b0b0
>                                                         MX6DL_PAD_SD3_CLK__SD3_CLK    0x10059
> -                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x17059
> -                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x17059
> -                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x17059
> -                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x17059
> -                                                       MX6DL_PAD_SD3_DAT4__SD3_DATA4 0x17059
> -                                                       MX6DL_PAD_SD3_DAT5__SD3_DATA5 0x17059
> -                                                       MX6DL_PAD_SD3_DAT6__SD3_DATA6 0x17059
> -                                                       MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x17059
> +                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT4__SD3_DATA4 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT5__SD3_DATA5 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT6__SD3_DATA6 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x1b0b0
>                                                 >;
>                                         };
>
>                                         pinctrl_usdhc3_2: usdhc3grp_2 {
>                                                 fsl,pins = <
> -                                                       MX6DL_PAD_SD3_CMD__SD3_CMD    0x17059
> +                                                       MX6DL_PAD_SD3_CMD__SD3_CMD    0x1b0b0
>                                                         MX6DL_PAD_SD3_CLK__SD3_CLK    0x10059
> -                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x17059
> -                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x17059
> -                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x17059
> -                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x17059
> +                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
> +                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index ba09dc3..826bfe0 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -103,9 +103,9 @@
>                                 ecspi1 {
>                                         pinctrl_ecspi1_1: ecspi1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_EIM_D17__ECSPI1_MISO 0x100b1
> -                                                       MX6Q_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
> -                                                       MX6Q_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
> +                                                       MX6Q_PAD_EIM_D17__ECSPI1_MISO 0x1b0b0
> +                                                       MX6Q_PAD_EIM_D18__ECSPI1_MOSI 0x1b0b0
> +                                                       MX6Q_PAD_EIM_D16__ECSPI1_SCLK 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -125,19 +125,19 @@
>                                                 fsl,pins = <
>                                                         MX6Q_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
>                                                         MX6Q_PAD_ENET_MDC__ENET_MDC         0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +                                                       MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x13030
> +                                                       MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b030
> +                                                       MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
>                                                         MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +                                                       MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x13030
> +                                                       MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b030
> +                                                       MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
>                                                         MX6Q_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
>                                                 >;
>                                         };
> @@ -146,19 +146,19 @@
>                                                 fsl,pins = <
>                                                         MX6Q_PAD_KEY_COL1__ENET_MDIO        0x1b0b0
>                                                         MX6Q_PAD_KEY_COL2__ENET_MDC         0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +                                                       MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x13030
> +                                                       MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b030
> +                                                       MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
>                                                         MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +                                                       MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x13030
> +                                                       MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b030
> +                                                       MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
>                                                 >;
>                                         };
>
> @@ -166,19 +166,19 @@
>                                                 fsl,pins = <
>                                                         MX6Q_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
>                                                         MX6Q_PAD_ENET_MDC__ENET_MDC         0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +                                                       MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x13030
> +                                                       MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b030
> +                                                       MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b030
> +                                                       MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
>                                                         MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> -                                                       MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +                                                       MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x13030
> +                                                       MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b030
> +                                                       MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b030
> +                                                       MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
>                                                         MX6Q_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
>                                                 >;
>                                         };
> @@ -187,22 +187,22 @@
>                                 gpmi-nand {
>                                         pinctrl_gpmi_nand_1: gpmi-nand-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_NANDF_CLE__NAND_CLE     0xb0b1
> -                                                       MX6Q_PAD_NANDF_ALE__NAND_ALE     0xb0b1
> -                                                       MX6Q_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
> -                                                       MX6Q_PAD_NANDF_RB0__NAND_READY_B 0xb000
> -                                                       MX6Q_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
> -                                                       MX6Q_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
> -                                                       MX6Q_PAD_SD4_CMD__NAND_RE_B      0xb0b1
> -                                                       MX6Q_PAD_SD4_CLK__NAND_WE_B      0xb0b1
> -                                                       MX6Q_PAD_NANDF_D0__NAND_DATA00   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D1__NAND_DATA01   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D2__NAND_DATA02   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D3__NAND_DATA03   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D4__NAND_DATA04   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D5__NAND_DATA05   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D6__NAND_DATA06   0xb0b1
> -                                                       MX6Q_PAD_NANDF_D7__NAND_DATA07   0xb0b1
> +                                                       MX6Q_PAD_NANDF_CLE__NAND_CLE     0x1b0b0
> +                                                       MX6Q_PAD_NANDF_ALE__NAND_ALE     0x1b0b0
> +                                                       MX6Q_PAD_NANDF_WP_B__NAND_WP_B   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_RB0__NAND_READY_B 0x1b0b0
> +                                                       MX6Q_PAD_NANDF_CS0__NAND_CE0_B   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_CS1__NAND_CE1_B   0x1b0b0
> +                                                       MX6Q_PAD_SD4_CMD__NAND_RE_B      0x1b0b0
> +                                                       MX6Q_PAD_SD4_CLK__NAND_WE_B      0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D0__NAND_DATA00   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D1__NAND_DATA01   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D2__NAND_DATA02   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D3__NAND_DATA03   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D4__NAND_DATA04   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D5__NAND_DATA05   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D6__NAND_DATA06   0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D7__NAND_DATA07   0x1b0b0
>                                                         MX6Q_PAD_SD4_DAT0__NAND_DQS      0x00b1
>                                                 >;
>                                         };
> @@ -211,15 +211,15 @@
>                                 i2c1 {
>                                         pinctrl_i2c1_1: i2c1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
> -                                                       MX6Q_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
> +                                                       MX6Q_PAD_EIM_D21__I2C1_SCL 0x4001b0b0
> +                                                       MX6Q_PAD_EIM_D28__I2C1_SDA 0x4001b0b0
>                                                 >;
>                                         };
>
>                                         pinctrl_i2c1_2: i2c1grp-2 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
> -                                                       MX6Q_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
> +                                                       MX6Q_PAD_CSI0_DAT8__I2C1_SDA 0x4001b0b0
> +                                                       MX6Q_PAD_CSI0_DAT9__I2C1_SCL 0x4001b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -227,8 +227,8 @@
>                                 i2c2 {
>                                         pinctrl_i2c2_1: i2c2grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_EIM_EB2__I2C2_SCL 0x4001b8b1
> -                                                       MX6Q_PAD_EIM_D16__I2C2_SDA 0x4001b8b1
> +                                                       MX6Q_PAD_EIM_EB2__I2C2_SCL 0x4001b0b0
> +                                                       MX6Q_PAD_EIM_D16__I2C2_SDA 0x4001b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -236,8 +236,8 @@
>                                 i2c3 {
>                                         pinctrl_i2c3_1: i2c3grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
> -                                                       MX6Q_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
> +                                                       MX6Q_PAD_EIM_D17__I2C3_SCL 0x4001b0b0
> +                                                       MX6Q_PAD_EIM_D18__I2C3_SDA 0x4001b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -245,8 +245,8 @@
>                                 uart1 {
>                                         pinctrl_uart1_1: uart1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
> -                                                       MX6Q_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
> +                                                       MX6Q_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b0
> +                                                       MX6Q_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -254,8 +254,8 @@
>                                 uart2 {
>                                         pinctrl_uart2_1: uart2grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
> -                                                       MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
> +                                                       MX6Q_PAD_EIM_D26__UART2_TX_DATA 0x1b0b0
> +                                                       MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -263,8 +263,8 @@
>                                 uart4 {
>                                         pinctrl_uart4_1: uart4grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
> -                                                       MX6Q_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
> +                                                       MX6Q_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b0
> +                                                       MX6Q_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -272,13 +272,13 @@
>                                 usbotg {
>                                         pinctrl_usbotg_1: usbotggrp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_GPIO_1__USB_OTG_ID 0x17059
> +                                                       MX6Q_PAD_GPIO_1__USB_OTG_ID 0x1b0b0
>                                                 >;
>                                         };
>
>                                         pinctrl_usbotg_2: usbotggrp-2 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
> +                                                       MX6Q_PAD_ENET_RX_ER__USB_OTG_ID 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -286,27 +286,27 @@
>                                 usdhc2 {
>                                         pinctrl_usdhc2_1: usdhc2grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_SD2_CMD__SD2_CMD    0x17059
> +                                                       MX6Q_PAD_SD2_CMD__SD2_CMD    0x1b0b0
>                                                         MX6Q_PAD_SD2_CLK__SD2_CLK    0x10059
> -                                                       MX6Q_PAD_SD2_DAT0__SD2_DATA0 0x17059
> -                                                       MX6Q_PAD_SD2_DAT1__SD2_DATA1 0x17059
> -                                                       MX6Q_PAD_SD2_DAT2__SD2_DATA2 0x17059
> -                                                       MX6Q_PAD_SD2_DAT3__SD2_DATA3 0x17059
> -                                                       MX6Q_PAD_NANDF_D4__SD2_DATA4 0x17059
> -                                                       MX6Q_PAD_NANDF_D5__SD2_DATA5 0x17059
> -                                                       MX6Q_PAD_NANDF_D6__SD2_DATA6 0x17059
> -                                                       MX6Q_PAD_NANDF_D7__SD2_DATA7 0x17059
> +                                                       MX6Q_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
> +                                                       MX6Q_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
> +                                                       MX6Q_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
> +                                                       MX6Q_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D4__SD2_DATA4 0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D5__SD2_DATA5 0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D6__SD2_DATA6 0x1b0b0
> +                                                       MX6Q_PAD_NANDF_D7__SD2_DATA7 0x1b0b0
>                                                 >;
>                                         };
>
>                                         pinctrl_usdhc2_2: usdhc2grp-2 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_SD2_CMD__SD2_CMD    0x17059
> +                                                       MX6Q_PAD_SD2_CMD__SD2_CMD    0x1b0b0
>                                                         MX6Q_PAD_SD2_CLK__SD2_CLK    0x10059
> -                                                       MX6Q_PAD_SD2_DAT0__SD2_DATA0 0x17059
> -                                                       MX6Q_PAD_SD2_DAT1__SD2_DATA1 0x17059
> -                                                       MX6Q_PAD_SD2_DAT2__SD2_DATA2 0x17059
> -                                                       MX6Q_PAD_SD2_DAT3__SD2_DATA3 0x17059
> +                                                       MX6Q_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
> +                                                       MX6Q_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
> +                                                       MX6Q_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
> +                                                       MX6Q_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -314,27 +314,27 @@
>                                 usdhc3 {
>                                         pinctrl_usdhc3_1: usdhc3grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_SD3_CMD__SD3_CMD    0x17059
> +                                                       MX6Q_PAD_SD3_CMD__SD3_CMD    0x1b0b0
>                                                         MX6Q_PAD_SD3_CLK__SD3_CLK    0x10059
> -                                                       MX6Q_PAD_SD3_DAT0__SD3_DATA0 0x17059
> -                                                       MX6Q_PAD_SD3_DAT1__SD3_DATA1 0x17059
> -                                                       MX6Q_PAD_SD3_DAT2__SD3_DATA2 0x17059
> -                                                       MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x17059
> -                                                       MX6Q_PAD_SD3_DAT4__SD3_DATA4 0x17059
> -                                                       MX6Q_PAD_SD3_DAT5__SD3_DATA5 0x17059
> -                                                       MX6Q_PAD_SD3_DAT6__SD3_DATA6 0x17059
> -                                                       MX6Q_PAD_SD3_DAT7__SD3_DATA7 0x17059
> +                                                       MX6Q_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT4__SD3_DATA4 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT5__SD3_DATA5 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT6__SD3_DATA6 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT7__SD3_DATA7 0x1b0b0
>                                                 >;
>                                         };
>
>                                         pinctrl_usdhc3_2: usdhc3grp-2 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_SD3_CMD__SD3_CMD    0x17059
> +                                                       MX6Q_PAD_SD3_CMD__SD3_CMD    0x1b0b0
>                                                         MX6Q_PAD_SD3_CLK__SD3_CLK    0x10059
> -                                                       MX6Q_PAD_SD3_DAT0__SD3_DATA0 0x17059
> -                                                       MX6Q_PAD_SD3_DAT1__SD3_DATA1 0x17059
> -                                                       MX6Q_PAD_SD3_DAT2__SD3_DATA2 0x17059
> -                                                       MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x17059
> +                                                       MX6Q_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
> +                                                       MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -342,27 +342,27 @@
>                                 usdhc4 {
>                                         pinctrl_usdhc4_1: usdhc4grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_SD4_CMD__SD4_CMD    0x17059
> +                                                       MX6Q_PAD_SD4_CMD__SD4_CMD    0x1b0b0
>                                                         MX6Q_PAD_SD4_CLK__SD4_CLK    0x10059
> -                                                       MX6Q_PAD_SD4_DAT0__SD4_DATA0 0x17059
> -                                                       MX6Q_PAD_SD4_DAT1__SD4_DATA1 0x17059
> -                                                       MX6Q_PAD_SD4_DAT2__SD4_DATA2 0x17059
> -                                                       MX6Q_PAD_SD4_DAT3__SD4_DATA3 0x17059
> -                                                       MX6Q_PAD_SD4_DAT4__SD4_DATA4 0x17059
> -                                                       MX6Q_PAD_SD4_DAT5__SD4_DATA5 0x17059
> -                                                       MX6Q_PAD_SD4_DAT6__SD4_DATA6 0x17059
> -                                                       MX6Q_PAD_SD4_DAT7__SD4_DATA7 0x17059
> +                                                       MX6Q_PAD_SD4_DAT0__SD4_DATA0 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT1__SD4_DATA1 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT2__SD4_DATA2 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT3__SD4_DATA3 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT4__SD4_DATA4 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT5__SD4_DATA5 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT6__SD4_DATA6 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT7__SD4_DATA7 0x1b0b0
>                                                 >;
>                                         };
>
>                                         pinctrl_usdhc4_2: usdhc4grp-2 {
>                                                 fsl,pins = <
> -                                                       MX6Q_PAD_SD4_CMD__SD4_CMD    0x17059
> +                                                       MX6Q_PAD_SD4_CMD__SD4_CMD    0x1b0b0
>                                                         MX6Q_PAD_SD4_CLK__SD4_CLK    0x10059
> -                                                       MX6Q_PAD_SD4_DAT0__SD4_DATA0 0x17059
> -                                                       MX6Q_PAD_SD4_DAT1__SD4_DATA1 0x17059
> -                                                       MX6Q_PAD_SD4_DAT2__SD4_DATA2 0x17059
> -                                                       MX6Q_PAD_SD4_DAT3__SD4_DATA3 0x17059
> +                                                       MX6Q_PAD_SD4_DAT0__SD4_DATA0 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT1__SD4_DATA1 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT2__SD4_DATA2 0x1b0b0
> +                                                       MX6Q_PAD_SD4_DAT3__SD4_DATA3 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index c5e5da0..81edb19 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -527,8 +527,8 @@
>                                 uart1 {
>                                         pinctrl_uart1_1: uart1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
> -                                                       MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> +                                                       MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b0
> +                                                       MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -536,16 +536,16 @@
>                                 usdhc1 {
>                                         pinctrl_usdhc1_1: usdhc1grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6SL_PAD_SD1_CMD__SD1_CMD    0x17059
> -                                                       MX6SL_PAD_SD1_CLK__SD1_CLK    0x10059
> -                                                       MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x17059
> -                                                       MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x17059
> -                                                       MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x17059
> -                                                       MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x17059
> -                                                       MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x17059
> -                                                       MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x17059
> -                                                       MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x17059
> -                                                       MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x17059
> +                                                       MX6SL_PAD_SD1_CMD__SD1_CMD    0x1b0b0
> +                                                       MX6SL_PAD_SD1_CLK__SD1_CLK    0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x1b0b0
> +                                                       MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -553,12 +553,12 @@
>                                 usdhc2 {
>                                         pinctrl_usdhc2_1: usdhc2grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6SL_PAD_SD2_CMD__SD2_CMD    0x17059
> -                                                       MX6SL_PAD_SD2_CLK__SD2_CLK    0x10059
> -                                                       MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x17059
> -                                                       MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x17059
> -                                                       MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x17059
> -                                                       MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x17059
> +                                                       MX6SL_PAD_SD2_CMD__SD2_CMD    0x1b0b0
> +                                                       MX6SL_PAD_SD2_CLK__SD2_CLK    0x1b0b0
> +                                                       MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
> +                                                       MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
> +                                                       MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
> +                                                       MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> @@ -566,12 +566,12 @@
>                                 usdhc3 {
>                                         pinctrl_usdhc3_1: usdhc3grp-1 {
>                                                 fsl,pins = <
> -                                                       MX6SL_PAD_SD3_CMD__SD3_CMD    0x17059
> -                                                       MX6SL_PAD_SD3_CLK__SD3_CLK    0x10059
> -                                                       MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x17059
> -                                                       MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x17059
> -                                                       MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x17059
> -                                                       MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x17059
> +                                                       MX6SL_PAD_SD3_CMD__SD3_CMD    0x1b0b0
> +                                                       MX6SL_PAD_SD3_CLK__SD3_CLK    0x1b0b0
> +                                                       MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
> +                                                       MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
> +                                                       MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
> +                                                       MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
>                                                 >;
>                                         };
>                                 };
> --
> 1.7.10.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
