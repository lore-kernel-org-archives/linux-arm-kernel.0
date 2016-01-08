From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 10:05:42 +0100
Subject: [PATCH v6 20/21] arm64:ilp32: change COMPAT_ELF_PLATFORM to
 report a a subplatform for ILP32
In-Reply-To: <1452209679-19445-21-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-21-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <68486474.QWvJHzOUAH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:38 Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index a519233..392301b 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -160,9 +160,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  #ifdef CONFIG_COMPAT
>  
>  #ifdef __AARCH64EB__
> -#define COMPAT_ELF_PLATFORM            ("v8b")
> +#define COMPAT_ELF_PLATFORM            (is_ilp32_compat_task() ? "aarch64_be:ilp32" : "v8b")
>  #else
> -#define COMPAT_ELF_PLATFORM            ("v8l")
> +#define COMPAT_ELF_PLATFORM            (is_ilp32_compat_task() ? "aarch64:ilp32" : "v8l")
>  #endif
> 

Same comment as for patch 12: you know which one to use at compile-time,
so just drop the runtime check and use different macros.

	Arnd
