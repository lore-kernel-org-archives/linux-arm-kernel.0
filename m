From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 02 Apr 2013 19:04:35 +0900
Subject: [PATCH] ARM: Fix typo "CONFIG_SAMSUNG_DEV_RTC"
In-Reply-To: <1364570435.1345.82.camel@x61.thuisdomein>
References: <1364570435.1345.82.camel@x61.thuisdomein>
Message-ID: <237b01ce2f89$7af00b60$70d02220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle wrote:
> 
> s3c_rtc_setname() tests for CONFIG_SAMSUNG_DEV_RTC or
> CONFIG_PLAT_S3C24XX. But of these two macros only CONFIG_PLAT_S3C24XX
> actually exists. Now we can see that s3c_device_rtc is only defined if
> either CONFIG_PLAT_S3C24XX or CONFIG_S3C_DEV_RTC are defined. So,
> apparently, it was intended to use CONFIG_S3C_DEV_RTC here.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
> 
> 1) Introduced in commit commit b2994d318dc78c9a4a43605629f00217335ada28
> ("ARM: S3C2443/S3C2416: add s3c_rtc_setname and rename rtc devices"),
> which shipped in v3.4. Should this go to stable too (after testing)?
> 
Let me check again, and if required, I will add Cc to stable.

>  arch/arm/plat-samsung/include/plat/rtc-core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/rtc-core.h
> b/arch/arm/plat-samsung/include/plat/rtc-core.h
> index 21d8594..7b542f7 100644
> --- a/arch/arm/plat-samsung/include/plat/rtc-core.h
> +++ b/arch/arm/plat-samsung/include/plat/rtc-core.h
> @@ -19,7 +19,7 @@
>  /* re-define device name depending on support. */
>  static inline void s3c_rtc_setname(char *name)
>  {
> -#if defined(CONFIG_SAMSUNG_DEV_RTC) || defined(CONFIG_PLAT_S3C24XX)
> +#if defined(CONFIG_S3C_DEV_RTC) || defined(CONFIG_PLAT_S3C24XX)

Yes, according to devs.c file in plat-samsung, SAMSUNG_DEV_RTC should be changed to S3C_DEV_RTC.

>  	s3c_device_rtc.name = name;
>  #endif
>  }
> --
> 1.7.11.7

Will apply after checking about stable, thanks.

- Kukjin
