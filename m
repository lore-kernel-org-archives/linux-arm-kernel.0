From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 08:36:53 +0000
Subject: [PATCH v2 7/8] ARM: LPC32xx: DTS files for device tree conversion
In-Reply-To: <1334682507-15055-8-git-send-email-stigge@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-8-git-send-email-stigge@antcom.de>
Message-ID: <201204180836.53268.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Roland Stigge wrote:
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

You have the flash chips in here, which seem right, but I would expect
to see the phy3250 file pick this up again and define partitions in
it, at least if there is a well-defined partition layout for that
board.

> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n81 root=/dev/ram0";
> +	};

I think in general it's better not to list a command line like this,
it should instead get set by the boot loader or using ARM_ATAG_DTB_COMPAT.

	Arnd
