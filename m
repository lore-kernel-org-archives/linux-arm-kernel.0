From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Nov 2017 20:10:11 +0000
Subject: [PATCH 06/15] efi/libstub: disable clang LTO
In-Reply-To: <20171103171203.107569-7-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-7-samitolvanen@google.com>
Message-ID: <CAKv+Gu813CiWQr-LyXtGq0CXW+xSUhnGshWbTzxTR699zBK6SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2017 at 17:11, Sami Tolvanen <samitolvanen@google.com> wrote:
> With CONFIG_CLANG_LTO, we produce LLVM IR instead of object files. Since LTO
> is not really needed here and the Makefile assumes we produce an object file,
> disable LTO for libstub.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 2371a92808be..5146eee677ce 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)  += -I$(srctree)/scripts/dtc/libfdt
>  KBUILD_CFLAGS                  := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>                                    -D__NO_FORTIFY \
>                                    $(call cc-option,-ffreestanding) \
> -                                  $(call cc-option,-fno-stack-protector)
> +                                  $(call cc-option,-fno-stack-protector) \
> +                                  $(DISABLE_LTO)
>
>  GCOV_PROFILE                   := n
>  KASAN_SANITIZE                 := n
> --
> 2.15.0.403.gc27cc4dac6-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
