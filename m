From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 18 Apr 2012 07:46:15 +0200
Subject: [PATCH v2 7/8] ARM: LPC32xx: DTS files for device tree conversion
In-Reply-To: <1334682507-15055-8-git-send-email-stigge@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-8-git-send-email-stigge@antcom.de>
Message-ID: <20120418054615.GB17506@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roland Stigge wrote:
[...]
> --- /dev/null
> +++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -0,0 +1,303 @@
> +/*
> + * NXP LPC32xx SoC
> + *
> + * Copyright 2012 Roland Stigge <stigge@antcom.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "nxp,lpc32xx";
> +
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,arm926ejs";
> +		};
> +	};
> +
> +	ahb {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges = <0x20000000 0x20000000 0x30000000>;
> +
> +		slc: flash at 20020000 {
> +			compatible = "nxp,nand-slc";
> +			reg = <0x20020000 0x1000>;
> +			status = "disable";
> +		};
> +
> +		mlc: flash at 200B0000 {
> +			compatible = "nxp,nand-mlc";
> +			reg = <0x200B0000 0x1000>;
> +			status = "disable";
> +		};
> +
> +		dma at 31000000 {
> +			compatible = "arm,pl080", "arm,primecell";
> +			reg = <0x31000000 0x1000>;
> +			interrupt-parent = <&mic>;

Most platforms define the interrupt parent somewhere in the top-level node
and have it inherited for child devices instead of having to repeat it for
each device. But I guess it's also okay to make it explicit.

[...]
> +			/*
> +			 * MIC Interrupt controller includes:
> +			 *   MIC @40008000
> +			 *   SIC1 @4000C000
> +			 *   SIC2 @40010000
> +			 */
> +			mic: interrupt-controller at 40008000 {
> +				compatible = "nxp,lpc32xx-mic";
> +				interrupt-controller;
> +				interrupt-parent;

I /think/ in this case you can leave this out. At least there doesn't seem to
be any other such usage in the tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/079b6fe1/attachment-0001.sig>
