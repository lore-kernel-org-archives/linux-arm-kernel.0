From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Jun 2011 12:43:25 -0500
Subject: [PATCH v2 3/5] ARM: ep93xx: increase NR_BANKS to 16 for support
	of 128MB RAM
In-Reply-To: <1307891100-31123-4-git-send-email-ynezz@true.cz>
References: <1307891100-31123-1-git-send-email-ynezz@true.cz>
	<1307891100-31123-4-git-send-email-ynezz@true.cz>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3821F5A0A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 12, 2011 8:05 AM, Petr ?tetiar wrote:
>
> I've got hands on one ts-7300 board, which is equiped with 128MB RAM in two
> 64MB memory chips, so it's 16 banks/8MB each. Without this patch, the bootmem
> init code complains about small NR_BANKS number and only lower 64MB is
> accessible.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> ---
>  arch/arm/include/asm/setup.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index ee2ad8a..b13720d 100644
> --- a/arch/arm/include/asm/setup.h
> +++ b/arch/arm/include/asm/setup.h
> @@ -192,7 +192,11 @@ static struct tagtable __tagtable_##fn __tag = { tag, fn }
>  /*
>   * Memory map description
>   */
> -#define NR_BANKS 8
> +#ifdef CONFIG_ARCH_EP93XX
> +# define NR_BANKS 16
> +#else
> +# define NR_BANKS 8
> +#endif
>  
>  struct membank {
>  	phys_addr_t start;

I would like Russell's opinion on this patch before it's accepted into his
Patch Tracker.

But, as far as the ep93xx support goes...

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
