From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 31 Jan 2013 15:15:02 +0100
Subject: [PATCH v2] arm: mvebu: support for the new Armada XP development
 board(DB-MV784MP-GP)
In-Reply-To: <1359641286-18182-2-git-send-email-gregory.clement@free-electrons.com>
References: <1359641286-18182-1-git-send-email-gregory.clement@free-electrons.com>
 <1359641286-18182-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <510A7C66.40906@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 03:08 PM, Gregory CLEMENT wrote:
> This is the new Armada XP evaluation board from Marvell. It comes with
> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
> Gigabit links.
>
> Support for USB (Host and device), SDIO, PCIe will be added as drivers
> when they become available for Armada XP in mainline.
>
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   arch/arm/boot/dts/Makefile         |    1 +
>   arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 102 insertions(+)
>   create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5ebb44f..51aab4b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>   	armada-370-mirabox.dtb \
>   	armada-xp-db.dtb \
> +	armada-xp-gp.dtb \
>   	armada-xp-openblocks-ax3-4.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
>   	imx53-ard.dtb \
> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
> new file mode 100644
> index 0000000..50e44e7
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
> @@ -0,0 +1,101 @@
> +/*
> + * Device Tree file for Marvell Armada XP development board
> + * (DB-MV784MP-GP)
> + *
> + * Copyright (C) 2013 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "armada-xp-mv78460.dtsi"
> +
> +/ {
> +	model = "Marvell Armada XP Development Board: DB-MV784MP-GP";

I noticed this just now, please do not use ":" for consistency with the 
other DTS files for Armada XP/370.
--
Florian
