From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 28 Feb 2015 16:51:30 +0100
Subject: [PATCH 4/7] efuse: Move Tegra efuse driver
In-Reply-To: <1424864719-3390-5-git-send-email-ezequiel.garcia@imgtec.com>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1424864719-3390-5-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <1425138690.24292.49.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-25 at 08:45 -0300, Ezequiel Garcia wrote:
> Now that the efuse subsystem has been introduced, move the Tegra efuse driver
> from drivers/soc/tegra/fuse/ to drivers/efuse/tegra. For now, there's no
> generic efuse API. However, by having the drivers in a unified location it is
> expected that such API will arise easier once support for more devices is added.
> 
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/efuse/Kconfig                                     | 7 +++++++
>  drivers/efuse/Makefile                                    | 1 +
>  drivers/{soc/tegra/fuse => efuse/tegra}/Makefile          | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra.c      | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra20.c    | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra30.c    | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/fuse.h            | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra114.c | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra124.c | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra20.c  | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra30.c  | 0
>  drivers/{soc/tegra/fuse => efuse/tegra}/tegra-apbmisc.c   | 0
>  drivers/soc/tegra/Makefile                                | 2 --
>  13 files changed, 8 insertions(+), 2 deletions(-)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/Makefile (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra20.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra30.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse.h (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra114.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra124.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra20.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra30.c (100%)
>  rename drivers/{soc/tegra/fuse => efuse/tegra}/tegra-apbmisc.c (100%)
> 
> diff --git a/drivers/efuse/Kconfig b/drivers/efuse/Kconfig
> index 617476f..b84e06b 100644
> --- a/drivers/efuse/Kconfig
> +++ b/drivers/efuse/Kconfig
> @@ -1,3 +1,10 @@
>  menu "eFuse drivers"
>  
> +config EFUSE_TEGRA
> +	bool
> +	depends on ARCH_TEGRA
> +	help
> +	  Support for the eFuses available on Tegra SoCs

This is a select only symbol. Patch 5/7 confirms this. So, as far as I
know, no one is ever going to see this help text when running make
*config. Is the help text needed?

> +
> +
>  endmenu


Paul Bolle
