From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Jun 2013 16:48:11 +0900
Subject: [PATCH] ARM: zImage/virt: remove hyp-stub.S during distclean
In-Reply-To: <20130610060325.2335.65815.sendpatchset@w520>
References: <20130610060325.2335.65815.sendpatchset@w520>
Message-ID: <20130611074810.GC10440@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 03:03:25PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Make sure hyp-stub.S gets removed during make distclean,
> this left over file was introduced in commit:
> 
> 424e599 ARM: zImage/virt: hyp mode entry support for the zImage loader
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
>  arch/arm/boot/compressed/Makefile |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 0001/arch/arm/boot/compressed/Makefile
> +++ work/arch/arm/boot/compressed/Makefile	2013-06-05 17:21:20.000000000 +0900
> @@ -116,7 +116,8 @@ targets       := vmlinux vmlinux.lds \
>  
>  # Make sure files are removed during clean
>  extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern \
> -		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs)
> +		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs) \
> +		 hyp-stub.S
>  
>  ifeq ($(CONFIG_FUNCTION_TRACER),y)
>  ORIG_CFLAGS := $(KBUILD_CFLAGS)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
