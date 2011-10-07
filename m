From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 11:56:38 +0200
Subject: [PATCH 08/26] ARM: pxa: move z2 to generic cpu_suspend
In-Reply-To: <CAMPhdO-tz2HgBYQGOUW6hrA6fC=x+CQJ3dwbW_0AazFB=cjvbA@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-9-git-send-email-arnd@arndb.de>
	<CAMPhdO-tz2HgBYQGOUW6hrA6fC=x+CQJ3dwbW_0AazFB=cjvbA@mail.gmail.com>
Message-ID: <201110071156.38283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011, Eric Miao wrote:
> commit 3f7961cbd3428c8639d42d1a51870466e4cbb0eb
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Sun Sep 11 17:19:11 2011 +0800
> 
>     ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no longer available
> 
>     Cc: Vasily Khoruzhick <anarsoul@gmail.com>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 6c9275a..6fa4e74 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -679,6 +679,8 @@ static inline void z2_pmic_init(void) {}
>  #endif
> 
>  #ifdef CONFIG_PM
> +extern void pxa27x_cpu_pm_enter(suspend_state_t state);
> +
>  static void z2_power_off(void)
>  {
>         /* We're using deep sleep as poweroff, so clear PSPR to ensure that

You really shouldn't have an extern declaration in a .c file. Otherwise
looks good to me.

	Arnd
