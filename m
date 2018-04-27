From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 27 Apr 2018 10:27:10 +0530
Subject: [RFC] ARM: DTS: da850-evm: Refactor device tree layout
In-Reply-To: <20180427023549.13678-1-aford173@gmail.com>
References: <20180427023549.13678-1-aford173@gmail.com>
Message-ID: <790e7323-f2a9-df64-aec5-965452df1bba@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Friday 27 April 2018 08:05 AM, Adam Ford wrote:
> Many of the items in the device tree are already defined or partially
> defined, so let's remove the redundancies and reduce the whitespace.

The patch is fine (and welcome, but for one nit below), but the
description needs to be better.

The main redundancy I can see is that node labels (like serial0, serial1
etc) are being redefined. So can you be clear on that. Also, the phandle
way of extending nodes is more "modern" (I dont quite recall if it was
common place back when the file was added in 2012).

Also, I would not call it "Refactor device tree layout" in subject. "use
phandles to extend nodes" is more apt.

> +
> +&pmx_core {
> +	status = "okay";
> +
> +	mcasp0_pins: pinmux_mcasp0_pins {
> +		pinctrl-single,bits = <
> +			/*
> +			 * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
> +			 * AFSR, AMUTE
> +			 */
> +			0x00 0x11111111 0xffffffff
> +			/* AXR11, AXR12 */
> +			0x04 0x00011000 0x000ff000
> +		>;
> +	};
> +	nand_pins: nand_pins {
> +		pinctrl-single,bits = <
> +			/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
> +			0x1c 0x10110110  0xf0ff0ff0
> +			/*
> +			 * EMA_D[0], EMA_D[1], EMA_D[2],
> +			 * EMA_D[3], EMA_D[4], EMA_D[5],
> +			 * EMA_D[6], EMA_D[7]
> +			 */
> +			0x24 0x11111111  0xffffffff
> +			/* EMA_A[1], EMA_A[2] */
> +			0x30 0x01100000  0x0ff00000
> +		>;
> +	};
> +};

Can you add an empty line after each node. This will make it consistent
with how its done in da850-lcdk.dts and da850-lego-ev3.dts

Thanks,
Sekhar
