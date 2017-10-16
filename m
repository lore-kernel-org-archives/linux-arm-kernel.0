From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Oct 2017 20:02:29 +0200
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Statically build
 RTC_DRV_RK808
In-Reply-To: <1508156187-27519-10-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
 <1508156187-27519-10-git-send-email-jagan@amarulasolutions.com>
Message-ID: <3238534.Bk1TS2fSCp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 16. Oktober 2017, 17:46:27 CEST schrieb Jagan Teki:
> RTC_DRV_RK808 need to have build statically for the platforms
> do use MFB_RK808 so replace module with statical link.

why would you need this to be compiled on? MFD_RK808 will happily
just create the platform-devices which are then bound to the RTC
driver later once the module is ready.

Heiko

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig index 2adef49..6ddc35c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -768,7 +768,7 @@ CONFIG_RTC_DRV_MAX8907=y
>  CONFIG_RTC_DRV_MAX8998=m
>  CONFIG_RTC_DRV_MAX8997=m
>  CONFIG_RTC_DRV_MAX77686=y
> -CONFIG_RTC_DRV_RK808=m
> +CONFIG_RTC_DRV_RK808=y
>  CONFIG_RTC_DRV_RS5C372=m
>  CONFIG_RTC_DRV_BQ32K=m
>  CONFIG_RTC_DRV_PALMAS=y
