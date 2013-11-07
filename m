From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 7 Nov 2013 10:59:59 +0000
Subject: [PATCH] seccomp: not compatible with ARM OABI
In-Reply-To: <20131106233117.GA24545@www.outflux.net>
References: <20131106233117.GA24545@www.outflux.net>
Message-ID: <527B72AF.50002@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/11/13 23:31, Kees Cook wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af2cc6eabcc7..6eaca7d92399 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -331,12 +331,15 @@ config HAVE_ARCH_SECCOMP_FILTER
>  
>  config SECCOMP_FILTER
>  	def_bool y
> -	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
> +	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET && !OABI_COMPAT

Isn't this the whole point of HAVE_ARCH_SECCOMP_FILTER?

Just change the select in arch/arm/Kconfig to this:

	select HAVE_ARCH_SECCOMP_FILTER if !OABI_COMPAT

Cheers
James
