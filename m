From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Oct 2010 08:54:01 +0100
Subject: [RFC] Removal of dead code from arch/arm/*
In-Reply-To: <4CBF8BDB.7090907@gmail.com>
References: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
	<AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
	<4CBF8BDB.7090907@gmail.com>
Message-ID: <20101021075401.GC22100@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 02:39:55AM +0200, N.P.S. wrote:
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index 38c261f..fd30b75 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -37,13 +37,9 @@
>   */
>  struct sys_timer *system_timer;
>
> -#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
> +#if defined(CONFIG_RTC_DRV_CMOS)
>  /* this needs a better home */
>  DEFINE_SPINLOCK(rtc_lock);
> -
> -#ifdef CONFIG_RTC_DRV_CMOS_MODULE
> -EXPORT_SYMBOL(rtc_lock);
> -#endif
>  #endif    /* pc-style 'CMOS' RTC support */
>
>  /* change this if you have some constant time drift */

This is wrong, and will break the build if rtc-cmos is built as a module.
