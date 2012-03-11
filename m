From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 11 Mar 2012 19:38:56 +0100
Subject: [PATCH v2 1/2] ARM: AT91: Add parameter for AT91_HAS_PATA
In-Reply-To: <1331415531-10961-1-git-send-email-alan@signal11.us>
References: <1331415380-10928-1-git-send-email-alan@signal11.us>
 <1331415531-10961-1-git-send-email-alan@signal11.us>
Message-ID: <20120311183856.GA13869@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:38 Sat 10 Mar     , Alan Ott wrote:
> Not all at91 chips have PATA, this parameter will identify which
> chips do. The determining of which chips support PATA was done
> by Arnd Bergmann.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>
> CC: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-at91/Kconfig |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 71feb00..9eeeabe 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -24,6 +24,9 @@ config AT91_SAM9_ALT_RESET
>  config AT91_SAM9G45_RESET
>  	bool
>  
> +config AT91_HAS_PATA
> +	bool
what is the need for this?

As we switch to DT, I don't want to track the soc list in the Kconfig anymore
if the soc support the PATA will be describe in the DT

Best Regards,
J.
