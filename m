From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 8 Oct 2011 18:10:37 +0800
Subject: [PATCH 22/26] ARM: pxa: only select SMC91x on xcep when
	networking is enabled
In-Reply-To: <1317499438-14058-23-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-23-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO_oP9t-miSr-OgWEUT9QycSQUx8y8gRyBcuswaB4rWiug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The smc91x driver is not strictly required for xcep, but it
> can only be enabled if ethernet support is built into the
> kernel, so make the dependency more specific.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?arch/arm/mach-pxa/Kconfig | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 491c522..ef35ce9 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -174,7 +174,7 @@ config MACH_XCEP
> ? ? ? ?select MTD_CFI_INTELEXT
> ? ? ? ?select MTD_CFI
> ? ? ? ?select MTD_CHAR
> - ? ? ? select SMC91X
> + ? ? ? select SMC91X if NET_ETHERNET

Or let's just remove this 'select SMC91X' completely as it's not
strictly required?

BTW - how's the Kconfig cleanup works going? I guess going forward,
the best way for such cases might be to introduce HAVE_SMC91X, and
let SMC91X to depend on this? However, that could in turn introduce
a massive number of HAVE_* for various drivers.

> ? ? ? ?help
> ? ? ? ? ?PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
> ? ? ? ? ?Tuned for usage in Libera instruments for particle accelerators.
> --
> 1.7.5.4
>
>
