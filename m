From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 1 Mar 2012 12:05:34 -0800
Subject: [PATCH 6/8] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <1330630010-11241-7-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-7-git-send-email-alan@signal11.us>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE86172C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The USB_ULPI driver is selected by tegra, but can only be
> built if at least one of USB or USB_GADGET is enabled.
> The kernel fails to link if both are off.

> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
...
> @@ -10,6 +10,7 @@ config ARCH_TEGRA_2x_SOC
...
> +	select USB_GADGET if USB_SUPPORT && !USB

I don't believe the Tegra USB driver supports gadget mode at present.
Would the above be better written as:

    select USB if USB_SUPPORT

And I wonder if the Tegra EHCI driver shouldn't be doing some of these
selects, not the ARCH_TEGRA_* option.

And this is probably required for Tegra30 too not just Tegra20.

-- 
nvpublic
