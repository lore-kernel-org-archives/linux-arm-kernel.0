From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Jan 2011 08:57:38 +0100
Subject: [RFC 1/2] AT91: Support SAM9260 and SAM9G20-based boards in
	the same kernel image
In-Reply-To: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
References: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
Message-ID: <20110117075738.GI14798@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:50 Sat 15 Jan     , Albin Tonnerre wrote:
> Nothing actually prevents support for boards based on these SoCs to be
> compiled in the same kernel image, since the SAM9260 and SAM9G20 are
> almost identical (AT91SAM9G20 adds some new features, but is otherwise
> compatible with the AT91SAM9260).
> 
> Signed-off-by: Albin Tonnerre <albin.tonnerre@free-electrons.com>
> ---
>  arch/arm/mach-at91/Kconfig |   31 +++++++++++++------------------
>  1 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index c015b68..d1eda58 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -26,8 +26,8 @@ config ARCH_AT91RM9200
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_AT91_USART3
>  
> -config ARCH_AT91SAM9260
> -	bool "AT91SAM9260 or AT91SAM9XE"
> +config ARCH_AT91SAM9260_VARIANTS
sos so

I'm working on a similar patch but ARCH_AT91SAM9260_VARIANTS seems so so

I get in mind to get rid of ARCH_AT91SAM92G20

and detect it

Best Regards,
J.
