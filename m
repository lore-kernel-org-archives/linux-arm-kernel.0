From: sam@ravnborg.org (Sam Ravnborg)
Date: Mon, 28 May 2012 22:30:05 +0200
Subject: [PATCH 1/2] Allow constructor name selection by architecture.
In-Reply-To: <1338230018-31052-2-git-send-email-vincent.sanders@collabora.co.uk>
References: <1338230018-31052-1-git-send-email-vincent.sanders@collabora.co.uk>
 <1338230018-31052-2-git-send-email-vincent.sanders@collabora.co.uk>
Message-ID: <20120528203005.GA20560@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 07:33:37PM +0100, Vincent Sanders wrote:
> From: Vincent Sanders <vince@collabora.co.uk>
> 
> The constructor symbol name is different between platforms. Allow this
> to be selected by configuration and set suitable default values.
> 
> Signed-off-by: Vincent Sanders <vincent.sanders@collabora.co.uk>
> ---
>  include/asm-generic/vmlinux.lds.h |    6 +++---
>  init/Kconfig                      |    6 ++++++
>  kernel/module.c                   |    2 +-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 8aeadf6..fd34808 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -471,9 +471,9 @@
>  	}
>  
>  #ifdef CONFIG_CONSTRUCTORS
> -#define KERNEL_CTORS()	. = ALIGN(8);			   \
> -			VMLINUX_SYMBOL(__ctors_start) = .; \
> -			*(.ctors)			   \
> +#define KERNEL_CTORS()	. = ALIGN(8);					\
> +			VMLINUX_SYMBOL(__ctors_start) = .;		\
> +			*(CONFIG_CONSTRUCTORS_NAME)			\
>  			VMLINUX_SYMBOL(__ctors_end) = .;

What is wrong with adding both "standard" names for ctors uncnditionally?
Like this:
> 			*(.ctors)			   \
> +			*(.init_array)			   \


	Sam
