From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 25 Feb 2016 09:49:43 +0100
Subject: [PATCH 2/5] all: introduce COMPAT_WRAPPER option and enable it
 for s390
In-Reply-To: <1456338854-14901-3-git-send-email-ynorov@caviumnetworks.com>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-3-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160225084943.GB3980@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 09:34:11PM +0300, Yury Norov wrote:
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/Kconfig      | 4 ++++
>  arch/s390/Kconfig | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index f6b649d..6393093 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -583,6 +583,10 @@ config HAVE_COPY_THREAD_TLS
>  	  normal C parameter passing, rather than extracting the syscall
>  	  argument from pt_regs.
> 
> +config COMPAT_WRAPPER
> +	bool
> +	depends on COMPAT
> +
>  #
>  # ABI hall of shame
>  #
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3be9c83..082b861 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -333,6 +333,7 @@ config COMPAT
>  	select COMPAT_BINFMT_ELF if BINFMT_ELF
>  	select ARCH_WANT_OLD_COMPAT_IPC
>  	select COMPAT_OLD_SIGACTION
> +	select COMPAT_WRAPPER
>  	depends on MULTIUSER
>  	help
>  	  Select this option if you want to enable your system kernel to

Maybe merge this into patch 4/5?
