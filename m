From: julien.grall@arm.com (Julien Grall)
Date: Tue, 12 Jul 2016 11:58:42 +0100
Subject: [PATCH 4/4] Explicitly clean linux-system.axf and xen-system.axf
In-Reply-To: <20160620150934.1729-5-andre.przywara@arm.com>
References: <20160620150934.1729-1-andre.przywara@arm.com>
 <20160620150934.1729-5-andre.przywara@arm.com>
Message-ID: <5784CD62.8040507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 20/06/16 16:09, Andre Przywara wrote:
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

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

> ---
>   Makefile.am | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index d83b417..cd022e9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -131,7 +131,7 @@ OFILES		+= $(addprefix $(ARCH_SRC),boot.o stack.o $(BOOTMETHOD) utils.o)
>
>   all: $(IMAGE) $(XIMAGE)
>
> -CLEANFILES = $(IMAGE) $(OFILES) model.lds fdt.dtb
> +CLEANFILES = $(IMAGE) linux-system.axf xen-system.axf $(OFILES) model.lds fdt.dtb
>
>   $(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM) $(XEN_IMAGE)
>   	$(LD) $(LDFLAGS) $(OFILES) -o $@ --script=model.lds
>

-- 
Julien Grall
