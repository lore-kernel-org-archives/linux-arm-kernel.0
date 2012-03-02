From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 02 Mar 2012 15:40:23 +0400
Subject: [PATCH 4/8] ARM: tegra: build localtimer support only when needed
In-Reply-To: <1330630010-11241-5-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-5-git-send-email-alan@signal11.us>
Message-ID: <4F50B1A7.60207@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-03-2012 23:26, Alan Ott wrote:

> From: Arnd Bergmann<arnd@arndb.de>

> It is possible to build a tegra kernel without localtimer
> support, so the tegra specific parts should only be built
> when that is indeed enabled.

> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> ---
>   arch/arm/mach-tegra/Makefile |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index e120ff5..a956df8 100644
> --- a/arch/arm/mach-tegra/Makefile
> +++ b/arch/arm/mach-tegra/Makefile
> @@ -13,7 +13,8 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
>   obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-tegra20-tables.o
>   obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pinmux-tegra30-tables.o
>   obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
> -obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
> +obj-$(CONFIG_SMP)                       += platsmp.o headsmp.o

   Could use the chance to indent here with tabs instead of spaces, like below.

> +obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o

WBR, Sergei
