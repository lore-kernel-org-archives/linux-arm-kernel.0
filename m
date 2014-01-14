From: phdm@macq.eu (Philippe De Muyter)
Date: Tue, 14 Jan 2014 16:30:12 +0100
Subject: imx6dl/imx6q fec rmii mode with external ref_clk
Message-ID: <20140114153012.GA22550@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On the custom board we are developping (imx6q and imx6dl), we have connected
the fec to a switch chip using rmii mode, and we let the switch provide the
reference clock to gpio_16.

I work currently with 3.13-rc8 and

- I do not have ethernet access working (tx timeout)
- I do not find in the dtb files a description of the pad settings for the
RMII mode
- when searching about the setting for bit 21 ing GPR1, which seems to
be important for my setting to work, I found the following mail:
	http://www.spinics.net/lists/devicetree/msg06450.html

saying "So far, we haven't got any user with that setup (external phy or
oscillator generates clock to pad GPIO_16).  When we do, we can add a
device tree property for telling that."

Is there any progress for that configuration since that mail ?

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

P.S.: here is my attempt for a dts entry for RMII mode :

pinctrl_enet_4: enetgrp-4 {
			fsl,pins = <
				MX6QDL_PAD_ENET_MDC__ENET_MDC           0x1b0b0
				MX6QDL_PAD_ENET_MDIO__ENET_MDIO         0x1b0b0
				MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0x1b0b0
				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0     0x1b0b0
				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1     0x1b0b0
				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN      0x1b0b0
				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER       0x1b0b0
				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0     0x1b0b0
				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1     0x1b0b0
				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN       0x1b0b0
				MX6QDL_PAD_GPIO_19__ENET_TX_ER          0x1b0b0
			>;
		};
