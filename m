From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 12:48:48 +0900
Subject: [PATCH 46/62] ARM: s3c24xx: fix gta02 build error
In-Reply-To: <1395257399-359545-47-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-47-git-send-email-arnd@arndb.de>
Message-ID: <01e701cf43ef$4cf9ae70$e6ed0b50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> The gta02 has always been broken in the case when CONFIG_PCF50633_ADC
> is not used, since gta02_charger_worker then passes a nonexisting
> variable into the pcf50633_mbc_usb_curlim_set() function.
> 
> This addresses the obvious typo by using the variable that is
> used everywhere else in this file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s3c24xx/mach-gta02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-
> s3c24xx/mach-gta02.c
> index 8e05813..dc4db84 100644
> --- a/arch/arm/mach-s3c24xx/mach-gta02.c
> +++ b/arch/arm/mach-s3c24xx/mach-gta02.c
> @@ -196,7 +196,7 @@ static void gta02_charger_worker(struct work_struct
> *work)
>  	 * If the PCF50633 ADC is disabled we fallback to a
>  	 * 100mA limit for safety.
>  	 */
> -	pcf50633_mbc_usb_curlim_set(pcf, 100);
> +	pcf50633_mbc_usb_curlim_set(gta02_pcf, 100);
>  #endif
>  }
> 
> --
> 1.8.3.2
