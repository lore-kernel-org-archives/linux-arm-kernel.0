From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Mar 2012 12:05:37 -0800
Subject: [PATCH 3/8] ARM: tegra: select CPU_FREQ_TABLE
In-Reply-To: <1330630010-11241-4-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-4-git-send-email-alan@signal11.us>
Message-ID: <CAOesGMiFbggUz6_GH-5htzFJuaXzeYhXpTfHafy-LSPAEmkQnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 1, 2012 at 11:26 AM, Alan Ott <alan@signal11.us> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The tegra cpufreq implementation relies on the cpu_freq_table
> code, so make sure that this is always there when needed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?arch/arm/mach-tegra/Kconfig | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 373652d..b2a038e 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,6 +10,7 @@ config ARCH_TEGRA_2x_SOC
> ? ? ? ?select USB_ARCH_HAS_EHCI if USB_SUPPORT
> ? ? ? ?select USB_ULPI if USB_SUPPORT
> ? ? ? ?select USB_ULPI_VIEWPORT if USB_SUPPORT
> + ? ? ? select CPU_FREQ_TABLE if CPU_FREQ

The corresponding chance is needed for T30 as well.

(the cpufreq driver should probably be moved out to drivers/cpufreq
and given its own but that's a separate issue)


-Olof
