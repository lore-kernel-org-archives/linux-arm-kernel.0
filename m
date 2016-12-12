From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 12 Dec 2016 09:47:29 -0500
Subject: [Xen-devel] [PATCH v2 4/4] Explicitly clean linux-system.axf and
 xen-system.axf
In-Reply-To: <20161122150917.16524-5-andre.przywara@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
 <20161122150917.16524-5-andre.przywara@arm.com>
Message-ID: <20161212144729.GD1686@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 03:09:17PM +0000, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> When doing a make clean, only the output image currently configured to
> build is being removed.  However, one would expect all build artifacts
> to be removed when doing a 'make clean' and when switching between Xen
> and Linux builds, it is easy to accidentally run an older build than
> intended.  Simply hardcode the axf image file names.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Julien Grall <julien.grall@arm.com>

Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index db97f9c..506a1d9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -130,7 +130,7 @@ OFILES		+= $(addprefix $(ARCH_SRC),boot.o stack.o $(BOOTMETHOD) utils.o)
>  
>  all: $(IMAGE)
>  
> -CLEANFILES = $(IMAGE) $(OFILES) model.lds fdt.dtb
> +CLEANFILES = $(IMAGE) linux-system.axf xen-system.axf $(OFILES) model.lds fdt.dtb
>  
>  $(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM) $(XEN_IMAGE)
>  	$(LD) $(LDFLAGS) $(OFILES) -o $@ --script=model.lds
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> https://lists.xen.org/xen-devel
