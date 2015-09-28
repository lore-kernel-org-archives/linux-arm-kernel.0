From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Sep 2015 09:35:50 +0200
Subject: [PATCH 2/2] arm64: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <1443418478-8240-3-git-send-email-thunder.leizhen@huawei.com>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
 <1443418478-8240-3-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1783631.jH4WY2RqXu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 September 2015 13:34:38 Zhen Lei wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 07d1811..25cec57 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -85,7 +85,7 @@ config ARM64
>         select PERF_USE_VMALLOC
>         select POWER_RESET
>         select POWER_SUPPLY
> -       select RTC_LIB
> +       select RTC_LIB if !EFI
>         select SPARSE_IRQ
>         select SYSCTL_EXCEPTION_TRACE
>         select HAVE_CONTEXT_TRACKING

Sorry, we can't do that: enabling EFI has to be done in a way that it only
adds features but not disables them.

Your patch breaks RTC on all non-EFI platforms as soon as CONFIG_EFI
is selected by the user.

	Arnd
