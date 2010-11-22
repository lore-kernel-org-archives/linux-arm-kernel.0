From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 23 Nov 2010 02:01:53 +0300
Subject: [PATCH v2 9/9] ARM: kprobes: Don't HAVE_KPROBES
	when	CONFIG_THUMB2_KERNEL is selected
In-Reply-To: <1290449065-28843-10-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-10-git-send-email-dave.martin@linaro.org>
Message-ID: <4CEAF661.3000907@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-11-2010 21:04, Dave Martin wrote:

> Currently, the kprobes implementation for ARM only supports
> the ARM instruction set, so it only works if
> CONFIG_THUMB2_KERNEL is not enabled.

> Until kprobes is updated to work with Thumb-2, turning it on
> will cause horrible things to happen, so this patch disables it
> for now.

> Signed-off-by: Dave Martin<dave.martin@linaro.org>
[...]

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db524e7..f1d9297 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -9,7 +9,7 @@ config ARM
>   	select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
>   	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>   	select HAVE_ARCH_KGDB
> -	select HAVE_KPROBES if (!XIP_KERNEL)
> +	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)

    These parens are useless.

WBR, Sergei
