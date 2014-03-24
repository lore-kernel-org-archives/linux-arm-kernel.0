From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Mon, 24 Mar 2014 06:47:06 +0100
Subject: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
In-Reply-To: <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140324054706.GA4487@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 11:13:51AM -0700, Laura Abbott wrote:
> Rather than have architectures #define ARCH_HAS_SG_CHAIN in an architecture
> specific scatterlist.h, make it a proper Kconfig option and use that
> instead. At same time, remove the header files are are now mostly
> useless and just include asm-generic/scatterlist.h.
> 

[...]

> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 65a0775..d6c2059 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -142,6 +142,7 @@ config S390
>  	select SYSCTL_EXCEPTION_TRACE
>  	select VIRT_CPU_ACCOUNTING
>  	select VIRT_TO_BUS
> +	select ARCH_HAS_SG_CHAIN
> 

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

FWIW, it would have been nice to keep the list of selected configs sorted.
However no need to resend.
