From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 5 Sep 2018 13:36:20 -0700
Subject: [RESEND PATCHv2 1/4] ARM: dts: add support for building DT
 overlays
In-Reply-To: <1536048344-9995-2-git-send-email-t-kristo@ti.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-2-git-send-email-t-kristo@ti.com>
Message-ID: <71d48595-f40f-acce-2660-ce1630ffc398@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+cc: devicetree-compiler at vger.kernel.org

     For context on the device-tree compiler list, this patch is for
     the Linux kernel.

On 09/04/18 01:05, Tero Kristo wrote:
> Add simple support for building DT overlays. This just compiles any
> given .dtso file under the base arch/arm/boot/dts directory into
> a .dtbo.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index d1516f8..ab555a0 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -339,7 +339,7 @@ $(BOOT_TARGETS): vmlinux
>  $(INSTALL_TARGETS):
>  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
>  
> -%.dtb: | scripts
> +%.dtb %.dtbo: | scripts
>  	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
>  
>  PHONY += dtbs dtbs_install
> 

The idea of adding knowledge of .dtso and .dtbo files to the dtc
compiler, but that idea and the related patches have fallen by
the wayside.

Current overlay sources and blobs are properly handled by dtc when
they are .dts and .dtb files.

If the dtc compiler is updated with knowledge of .dtso and .dtbo
then these changes would be needed.  At the moment the distinction
of a .dtso and .dtbo is a naming convention that provides a clue
about the intended use of the file.  But dtc does not know these
file name extensions, requiring a specific flag to tell dtc to
treat them as .dts or .dtb files.  I think the negative outweighs
the positive for this patch.

-Frank
