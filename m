From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:40:15 -0800
Subject: [PATCH v2 5/6] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <1330721919-8800-1-git-send-email-alan@signal11.us>
References: <1330721919-8800-1-git-send-email-alan@signal11.us>
Message-ID: <20120304184015.GE31064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 03:58:39PM -0500, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The USB_ULPI driver is selected by tegra, but can only be
> built if at least one of USB or USB_GADGET is enabled.
> The kernel fails to link if both are off.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>
> ---
>  arch/arm/mach-tegra/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 60f3e4b..9bb8a37 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,6 +10,7 @@ config ARCH_TEGRA_2x_SOC
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select USB_ULPI if USB_SUPPORT
>  	select USB_ULPI_VIEWPORT if USB_SUPPORT
> +	select USB_GADGET if USB_SUPPORT && !USB
>  	select CPU_FREQ_TABLE if CPU_FREQ
>  	help
>  	  Support for NVIDIA Tegra AP20 and T20 processors, based on the

This is another patch that needs the same change for T30.


-Olof
