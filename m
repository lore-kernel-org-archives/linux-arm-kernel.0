From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Fri, 06 Aug 2010 13:42:34 +0300
Subject: [PATCH 1/4] s3c: add support for mach-real6410
In-Reply-To: <20100806102041.2481.18980.stgit@darius-desktop>
References: <20100806101914.2481.67766.stgit@darius-desktop>
	<20100806102041.2481.18980.stgit@darius-desktop>
Message-ID: <4C5BE71A.6040106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2010 01:21 PM, Darius Augulis wrote:
> Add support for CoreWind Real6410 board,
> based on Samsung s3c6410 processor.
>
> Changelog:
>   * It's renamed patch '[PATCH v2] Support for Real6410'
>
> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
> ---
>   arch/arm/mach-s3c64xx/Kconfig         |    6 ++
>   arch/arm/mach-s3c64xx/Makefile        |    1
>   arch/arm/mach-s3c64xx/mach-real6410.c |   86 +++++++++++++++++++++++++++++++++
>   3 files changed, 93 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-s3c64xx/mach-real6410.c
>
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index f5a5972..0f9f2dd 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -88,6 +88,12 @@ config MACH_ANW6410
>   	help
>   	  Machine support for the A&W6410
>
> +config MACH_REAL6410
> +	bool "REAL6410"
> +	select CPU_S3C6410
> +	help
> +	  Machine support for the CoreWind REAL6410
> +
>   config MACH_SMDK6410
>   	bool "SMDK6410"
>   	select CPU_S3C6410
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
> index 9d10069..6be3e5b 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_PM)		+= irq-pm.o
>   obj-$(CONFIG_MACH_ANW6410)	+= mach-anw6410.o
>   obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
>   obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
> +obj-$(CONFIG_MACH_REAL6410)     += mach-real6410.o

Use TAB instead of spaces here ^^^^^
