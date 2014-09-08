From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 15:25:50 +0200
Subject: [PATCH] Enable gcov support on the ARM architecture
In-Reply-To: <1410181174-14977-1-git-send-email-riku.voipio@linaro.org>
References: <1410181174-14977-1-git-send-email-riku.voipio@linaro.org>
Message-ID: <7440624.dBfm8VFYff@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 15:59:34 Riku Voipio wrote:
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 38ddd9f..979c4e9 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -5,6 +5,8 @@
>  CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  
> +GCOV_PROFILE := n
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_ftrace.o = -pg
>  CFLAGS_REMOVE_insn.o = -pg
> 

This part doesn't look right: you don't want to disable profiling for
the entire directory, only for the parts on which it cannot be used.

	Arnd
