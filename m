From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 11 Sep 2012 19:40:40 +0200
Subject: [PATCH 2/2] arm: mvebu: select the pinctrl drivers for Armada
 370 and Armada XP platforms
In-Reply-To: <1347377834-19402-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347377834-19402-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <504F7798.6070501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 05:37 PM, Thomas Petazzoni wrote:
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index b0924b1..0da722e 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -10,6 +10,7 @@ config MACH_ARMADA_370_XP
>   config MACH_ARMADA_370
>   	bool "Marvell Armada 370 boads"
>   	select MACH_ARMADA_370_XP
> +	select PINCTRL_ARMADA_370
>   	help
>   	  Say 'Y' here if you want your kernel to support boards based
>   	  on the Marvell Armada XP SoC with device tree.
> @@ -17,6 +18,7 @@ config MACH_ARMADA_370
>   config MACH_ARMADA_XP
>   	bool "Marvell Armada XP boards"
>   	select MACH_ARMADA_370_XP
> +	select PINCTRL_ARMADA_XP
>   	help
>   	  Say 'Y' here if you want your kernel to support boards based
>   	  on the Marvell Armada XP SoC with device tree.

Using PINCTRL_MVEBU on any mvebu SoC requires to
"select PINCTRL" in arch/arm/Kconfig for ARCH_MVEBU, too.

Sebastian
