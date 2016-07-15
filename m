From: bsingharora@gmail.com (Balbir Singh)
Date: Fri, 15 Jul 2016 12:05:50 +1000
Subject: [PATCH v2 11/11] mm: SLUB hardened usercopy support
In-Reply-To: <1468446964-22213-12-git-send-email-keescook@chromium.org>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-12-git-send-email-keescook@chromium.org>
Message-ID: <20160715020550.GB13944@balbir.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 02:56:04PM -0700, Kees Cook wrote:
> Under CONFIG_HARDENED_USERCOPY, this adds object size checking to the
> SLUB allocator to catch any copies that may span objects. Includes a
> redzone handling fix from Michael Ellerman.
> 
> Based on code from PaX and grsecurity.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  init/Kconfig |  1 +
>  mm/slub.c    | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 798c2020ee7c..1c4711819dfd 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1765,6 +1765,7 @@ config SLAB
>  
>  config SLUB
>  	bool "SLUB (Unqueued Allocator)"
> +	select HAVE_HARDENED_USERCOPY_ALLOCATOR

Should this patch come in earlier from a build perspective? I think
patch 1 introduces and uses __check_heap_object.

Balbir Singh.
