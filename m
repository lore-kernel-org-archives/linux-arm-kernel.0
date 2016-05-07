From: sam@ravnborg.org (Sam Ravnborg)
Date: Sat, 7 May 2016 13:23:56 +0200
Subject: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
References: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
Message-ID: <20160507112308.GA2612@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 57ffaf2..ca675ed 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -42,6 +42,7 @@ config SPARC
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
>  	select ARCH_HAS_SG_CHAIN
> +	select CPU_NO_EFFICIENT_FFS
>  
>  config SPARC32
>  	def_bool !64BIT

sparc64 have an efficient ffs implementation.
We use run-time patching to use the proper version
depending on the actual sparc cpu.

As this is determinded at config time, then let the
sparc cpu that has the efficient ffs benefit from this.

In other words - select CPU_NO_EFFICIENT_FFS only for SPARC32.

	Sam
