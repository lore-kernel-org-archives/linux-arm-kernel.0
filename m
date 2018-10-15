From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Oct 2018 09:01:43 +0200
Subject: [PATCH V2 3/4] arm64: dts: imx: add imx8qxp mek support
In-Reply-To: <1539527419-23613-4-git-send-email-aisheng.dong@nxp.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181015070143.hzmai3nrsq7jd2fz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2018 at 02:34:56PM +0000, A.s. Dong wrote:
> Add imx8qxp mek board support.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 134 ++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> 
> +&iomuxc {
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			SC_P_ENET0_MDC_CONN_ENET0_MDC			0x06000020
> +			SC_P_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
> +			SC_P_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x06000020
> +			SC_P_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC	0x06000020
> +			SC_P_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0	0x06000020
> +			SC_P_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1	0x06000020
> +			SC_P_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2	0x06000020
> +			SC_P_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3	0x06000020
> +			SC_P_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC	0x06000020
> +			SC_P_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x06000020
> +			SC_P_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0	0x06000020
> +			SC_P_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1	0x06000020
> +			SC_P_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2	0x06000020
> +			SC_P_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3	0x06000020

I doubt these names will be valid for future SoCs. They should have a
IMX8QP_ prefix.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
