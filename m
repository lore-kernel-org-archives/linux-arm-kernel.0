From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Oct 2013 09:02:31 +0200
Subject: [Patch v2][ 20/37] arm/dts: imx25.dtsi: Add some pinmux pins.
In-Reply-To: <1382022155-21954-21-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-21-git-send-email-denis@eukrea.com>
Message-ID: <20131018070231.GU30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:02:18PM +0200, Denis Carikli wrote:
> Uart1, fec, i2c1,esdhc1 and audmux were added.
> 
> +				fec {
> +					pinctrl_fec_1: fecgrp-1 {
> +						fsl,pins = <
> +							MX25_PAD_FEC_MDC__FEC_MDC       0x80000000
> +							MX25_PAD_FEC_MDIO__FEC_MDIO     0x400001e0
> +							MX25_PAD_FEC_TDATA0__FEC_TDATA0 0x80000000
> +							MX25_PAD_FEC_TDATA1__FEC_TDATA1 0x80000000
> +							MX25_PAD_FEC_TX_EN__FEC_TX_EN   0x80000000
> +							MX25_PAD_FEC_RDATA0__FEC_RDATA0 0x800000c0
> +							MX25_PAD_FEC_RDATA1__FEC_RDATA1 0x800000c0
> +							MX25_PAD_FEC_RX_DV__FEC_RX_DV   0x800000c0

The 0x8000xxxx values don't make sense:

NO_PAD_CTL(1 << 31): indicate this pin does not need config.

So by setting bit 31 you ask to ignore the settings, still you set other
bits.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
