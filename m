From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Wed, 19 Mar 2014 20:15:36 +0000
Subject: [PATCH 11/62] ARM: ep93xx: export ep93xx_chip_revision
In-Reply-To: <1395257399-359545-12-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-12-git-send-email-arnd@arndb.de>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8825DC177D@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 19, 2014 12:29 PM, Arnd Bergmann wrote:
> ep93xx_chip_revision is used by the pata_ep93xx driver,
> which can be a loadable module. Exporting the symbol
> avoids a link error in this case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 6c70547..0e571f1 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -242,6 +242,7 @@ unsigned int ep93xx_chip_revision(void)
>  	v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
>  	return v;
>  }
> +EXPORT_SYMBOL_GPL(ep93xx_chip_revision);
>  
>  /*************************************************************************
>   * EP93xx GPIO

Good catch. Thanks.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
