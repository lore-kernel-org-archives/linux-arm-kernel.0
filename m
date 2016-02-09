From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Feb 2016 10:00:30 +0100
Subject: [PATCH] ARM: ks8695: fix __initdata annotation
In-Reply-To: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
References: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
Message-ID: <20160209090030.GS13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 03:24:57PM +0100, Arnd Bergmann wrote:
> Clang complains about the __initdata section attribute being in the
> wrong place in two files of ks8695:
> 
> arch/arm/mach-ks8695/cpu.c:37:31: error: '__section__' attribute only applies to functions and global variables
> arch/arm/mach-ks8695/board-og.c:83:31: error: '__section__' attribute only applies to functions and global variables
> 
> This moves the attribute to the correct place.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ks8695/board-og.c | 2 +-
>  arch/arm/mach-ks8695/cpu.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
> index 1f4f2f4f25bb..fa1a7c2ca2bb 100644
> --- a/arch/arm/mach-ks8695/board-og.c
> +++ b/arch/arm/mach-ks8695/board-og.c
> @@ -80,7 +80,7 @@ static void __init og_pci_bus_reset(void)
>  #define	S8250_VIRT	0xf4000000
>  #define	S8250_SIZE	0x00100000
>  
> -static struct __initdata map_desc og_io_desc[] = {
> +static struct map_desc __initdata og_io_desc[] = {

I would have expected that

+static struct map_desc og_io_desc[] __initdata = {

is the correct variant?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
