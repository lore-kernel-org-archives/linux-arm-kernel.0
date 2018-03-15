From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 14:58:41 -0300
Subject: [PATCH 2/3] ARM: dts: i.MX6: Add BTicino i.MX6DL Mamoj initial
 support
In-Reply-To: <20180315170710.9551-2-jagan@amarulasolutions.com>
References: <20180315170710.9551-1-jagan@amarulasolutions.com>
 <20180315170710.9551-2-jagan@amarulasolutions.com>
Message-ID: <CAOMZO5CNDN9RbuBiELKdY9xjUFksMAg16enwtpd+bBtOZbdZrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

On Thu, Mar 15, 2018 at 2:07 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:

> +&iomuxc {
> +       pinctrl_enet: enetgrp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_ENET_MDIO__ENET_MDIO         0x1b0b0
> +                       MX6QDL_PAD_ENET_MDC__ENET_MDC           0x1b0b0
> +                       MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK    0x1b0b1
> +                       MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0     0x1b0b0
> +                       MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1     0x1b0b0
> +                       MX6QDL_PAD_KEY_ROW2__ENET_TX_DATA2      0x1b0b0
> +                       MX6QDL_PAD_KEY_ROW0__ENET_TX_DATA3      0x1b0b0
> +                       MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN       0x1b0b0
> +                       MX6QDL_PAD_GPIO_19__ENET_TX_ER          0x1b0b0
> +                       MX6QDL_PAD_GPIO_18__ENET_RX_CLK         0x1b0b1
> +                       MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0     0x1b0b0
> +                       MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1     0x1b0b0
> +                       MX6QDL_PAD_KEY_COL2__ENET_RX_DATA2      0x1b0b0
> +                       MX6QDL_PAD_KEY_COL0__ENET_RX_DATA3      0x1b0b0
> +                       MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN      0x1b0b0
> +                       MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER       0x1b0b0
> +                       MX6QDL_PAD_KEY_COL3__ENET_CRS           0x1b0b0
> +                       MX6QDL_PAD_KEY_ROW1__ENET_COL           0x1b0b0
> +                       /* KSZ8041 PHY Reset */
> +                       MX6QDL_PAD_KEY_COL1__GPIO4_IO08         0x1b0b0

You use a GPIO for the Ethernet PHY reset, but you missed to pass
'phy-reset-gpios' in the fec node.
