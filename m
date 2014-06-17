From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 17 Jun 2014 12:07:38 -0400 (EDT)
Subject: [PATCH] ARM: zImage: ensure header in LE format for BE8
 kernels
In-Reply-To: <20140617142917.GA31861@n2100.arm.linux.org.uk>
References: <1397147232-28516-1-git-send-email-taras.kondratiuk@linaro.org>
 <20140617142917.GA31861@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1406171200220.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jun 2014, Russell King - ARM Linux wrote:

> Given that we're now passing the linker script through GCC for C
> preprocessing, it seems to me that we don't need to do the sed trick
> anymore - we can pass TEXTADDR and ZBSSADDR into GCC via definitions
> instead, so I've committed this patch after this one.  No changes to
> the vmlinux.lds.* file, it's just a pure rename.  Ack?
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] ARM: Simplify generation of compressed vmlinux.lds file
> 
> As we are now using the C preprocessor, we do not need to use sed to
> edit constants in this file, and then pass the resulting file through
> the C preprocessor.  Instead, rely solely on the C preprocessor to
> rewrite TEXT_START and BSS_ADDR.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/compressed/.gitignore     |  1 -
>  arch/arm/boot/compressed/Makefile       |  5 +-
>  arch/arm/boot/compressed/vmlinux.lds.S  | 90 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/compressed/vmlinux.lds.in | 90 ---------------------------------

Would be easier to review with git diff -M.

> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> new file mode 100644
> index 000000000000..60162231c7ea
[...]
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
> deleted file mode 100644
> index 60162231c7ea..000000000000

OK, the SHA1 is the same so both files are identical.

> --- a/arch/arm/boot/compressed/vmlinux.lds.in
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -/*
> - *  linux/arch/arm/boot/compressed/vmlinux.lds.in

You might want to update this comment though.

Other than that...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
