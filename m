From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Jan 2014 10:41:17 +0100
Subject: [PATCH v2 14/15] watchdog: orion: Allow to build on any Orion
 platform
In-Reply-To: <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52DE40BD.10700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/14 10:12, Ezequiel Garcia wrote:
> After getting rid of all the mach-specific code, it's now possible
> to allow builds in any Orion platform.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5be6e91..1689f72 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -282,7 +282,7 @@ config DAVINCI_WATCHDOG
>
>   config ORION_WATCHDOG
>   	tristate "Orion watchdog"
> -	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
> +	depends on PLAT_ORION

Ezequiel,

while above is true now, I tend to rather have ARCH_MVEBU added here.
We really want to get rid of both !ARCH_MVEBU and PLAT_ORION and this
unnecessarily will make it more complicated.

I haven't checked why ARCH_MVEBU at all added PLAT_ORION as dependency,
but IIRC it was just because of a missing mbus driver? If it is just
this, we should also remove PLAT_ORION from ARCH_MVEBU to have a clean
cut between new common arch and existing sub-archs.

Sebastian

>   	select WATCHDOG_CORE
>   	help
>   	  Say Y here if to include support for the watchdog timer
>
