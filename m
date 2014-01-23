From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 14:18:08 +0000
Subject: [PATCH v2 1/6] audit: Enable arm64 support
In-Reply-To: <1389946399-4525-2-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140123141808.GD27520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 08:13:14AM +0000, AKASHI Takahiro wrote:
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -327,6 +327,8 @@ enum {
>  /* distinguish syscall tables */
>  #define __AUDIT_ARCH_64BIT 0x80000000
>  #define __AUDIT_ARCH_LE	   0x40000000
> +#define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_AARCH64EB	(EM_AARCH64|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_ARMEB	(EM_ARM)
> diff --git a/init/Kconfig b/init/Kconfig
> index 79383d3..3aae602 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -284,7 +284,7 @@ config AUDIT
>  
>  config AUDITSYSCALL
>  	bool "Enable system-call auditing support"
> -	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT))
> +	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ARM64)

The usual comment for such changes: could you please clean this up and
just use something like "depends on HAVE_ARCH_AUDITSYSCALL"?

-- 
Catalin
