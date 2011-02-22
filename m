From: ccross@android.com (Colin Cross)
Date: Tue, 22 Feb 2011 11:39:46 -0800
Subject: [PATCH 3/6] ARM: tegra: remove stale nvidia atag handler
In-Reply-To: <1298354117-19097-4-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-4-git-send-email-olof@lixom.net>
Message-ID: <AANLkTim4aQkxab5rZwbrWWr-NiK9rf0YjhQGB2_zfGBP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 9:55 PM, Olof Johansson <olof@lixom.net> wrote:
> Remove dead atag handling code for nvidia-specific tags.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> ?arch/arm/mach-tegra/board-harmony.c | ? 25 -------------------------
> ?1 files changed, 0 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index b9dbdb1..f6ad58b 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -35,31 +35,6 @@
> ?#include "board-harmony.h"
> ?#include "clock.h"
>
> -/* NVidia bootloader tags */
> -#define ATAG_NVIDIA ? ? ? ? ? ?0x41000801
> -
> -#define ATAG_NVIDIA_RM ? ? ? ? ? ? ? ? 0x1
> -#define ATAG_NVIDIA_DISPLAY ? ? ? ? ? ?0x2
> -#define ATAG_NVIDIA_FRAMEBUFFER ? ? ? ? ? ? ? ?0x3
> -#define ATAG_NVIDIA_CHIPSHMOO ? ? ? ? ?0x4
> -#define ATAG_NVIDIA_CHIPSHMOOPHYS ? ? ?0x5
> -#define ATAG_NVIDIA_PRESERVED_MEM_0 ? ?0x10000
> -#define ATAG_NVIDIA_PRESERVED_MEM_N ? ?2
> -#define ATAG_NVIDIA_FORCE_32 ? ? ? ? ? 0x7fffffff
> -
> -struct tag_tegra {
> - ? ? ? __u32 bootarg_key;
> - ? ? ? __u32 bootarg_len;
> - ? ? ? char bootarg[1];
> -};
> -
> -static int __init parse_tag_nvidia(const struct tag *tag)
> -{
> -
> - ? ? ? return 0;
> -}
> -__tagtable(ATAG_NVIDIA, parse_tag_nvidia);
> -
> ?static struct plat_serial8250_port debug_uart_platform_data[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.membase ? ? ? ?= IO_ADDRESS(TEGRA_UARTD_BASE),
> --
> 1.7.0.4
>
>

Acked-by: Colin Cross <ccross@android.com>

Our version of the kernel will never use these atags, so it's better
to warn that they are being ignored and get the bootloaders updated.
