From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 27 Dec 2014 12:34:01 +0100
Subject: [PATCH 3/3] ARM: mvebu: Add Armada 385 General Purpose
 Development Board support
In-Reply-To: <1419678035-10658-4-git-send-email-gregory.clement@free-electrons.com>
References: <1419678035-10658-1-git-send-email-gregory.clement@free-electrons.com>
 <1419678035-10658-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141227113401.GC21001@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 27, 2014 at 12:00:35PM +0100, Gregory CLEMENT wrote:
> The A385-GP is a board produced by Marvell that holds
> 
> - 1 PCIe slot
> - 2 mini PCIe slot (one of them is multiplexed with the PCIe slot,
>   muxing is selected through the GPIO expander)
> - 1 16MB SPI-NOR
> - 2 Gigabit Ethernet ports
> - 4 SATA ports (2 of them are multiplexed with the mini PCIe slots,
>   muxing is selected through the GPIO expander)
> - 1 SDIO slot
> - 1 USB3 port
> - 2 USB2 port
> - 2 GPIO/interrupts expander on I2C
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/armada-385-gp.dts | 380 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 381 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-385-gp.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 91bd5bd62857..d6d7bafac127 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -535,6 +535,7 @@ dtb-$(CONFIG_MACH_ARMADA_375) += \
>  	armada-375-db.dtb
>  dtb-$(CONFIG_MACH_ARMADA_38X) += \
>  	armada-385-db.dtb \
> +	armada-385-gp.dtb \
>  	armada-385-rd.dtb
>  dtb-$(CONFIG_MACH_ARMADA_XP) += \
>  	armada-xp-axpwifiap.dtb \
> diff --git a/arch/arm/boot/dts/armada-385-gp.dts b/arch/arm/boot/dts/armada-385-gp.dts
> new file mode 100644
> index 000000000000..c9a375674e7f
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-gp.dts
> @@ -0,0 +1,380 @@
> +/*
> + * Device Tree file for Marvell Armada 385 development board
> + * (RD-88F6820-GP)
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.

Hi Gregory

I'm guessing here...

The file says Copyright Marvell. I guess Marvell released it GPL? Not
Dual license? So it would be nice to have a Signed-off-by: from
somebody in Marvell that they are O.K. with the dual license.

Thanks
	Andrew
