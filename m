From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 17:06:14 +0200
Subject: [PATCH] arm: mvebu: support for the PlatHome OpenBlocks AX3 board
In-Reply-To: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1350980365-6698-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121024150614.GD11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 10:19:25AM +0200, Thomas Petazzoni wrote:
> This platform, available in Japan from PlatHome, has a dual-core
> Armada XP, the MV78260. For now, only the two serial ports and the
> three front LEDs are supported. Support for network, SATA, USB and
> other peripherals will be added as drivers for them become available
> for Armada XP in mainline.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> ---
> This is 3.8 material.
> ---
>  arch/arm/boot/dts/Makefile           |    3 +-
>  arch/arm/boot/dts/openblocks-ax3.dts |   69 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mvebu/armada-370-xp.c  |    1 +
>  3 files changed, 72 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/openblocks-ax3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f37cf9f..b7814b9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -44,7 +44,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
>  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>  	msm8960-cdp.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
> -	armada-xp-db.dtb
> +	armada-xp-db.dtb \
> +	openblocks-ax3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
>  	imx53-ard.dtb \
>  	imx53-evk.dtb \
> diff --git a/arch/arm/boot/dts/openblocks-ax3.dts b/arch/arm/boot/dts/openblocks-ax3.dts
> new file mode 100644
> index 0000000..f757116
> --- /dev/null
> +++ b/arch/arm/boot/dts/openblocks-ax3.dts
> @@ -0,0 +1,69 @@
> +/*
> + * Device Tree file for OpenBlocks AX3 board
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "armada-xp-mv78260.dtsi"
> +
> +/ {
> +	model = "PlatHome OpenBlocks AX3 board";
> +	compatible = "plathome,openblocks-ax3", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>; /* 1 GB */
> +	};

Hi Thomas

There are two variants of this box, ax3/2 and ax3/4. The ax3/4 can
have more RAM and has a mini pci express slot. Do you expect both
boards to be supported with one dts file?

Thanks
	Andrew
