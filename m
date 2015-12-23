From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 23 Dec 2015 10:33:10 +0100
Subject: [PATCH] efi: stub: define DISABLE_BRANCH_PROFILING for all
 architectures
In-Reply-To: <1450862968-20222-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1450862968-20222-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8i=OV6B9Fyg-rSVW50AQEHreaZhU2hc+RQ0gm6j7CzPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 December 2015 at 10:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This moves the DISABLE_BRANCH_PROFILING define from the x86 specific
> to the general CFLAGS definition for the stub. This fixes build errors
> when building for arm64 with CONFIG_PROFILE_ALL_BRANCHES_ENABLED.
>

typo here ^^^

> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 3c0467d3688c..c0ddd1b8dca3 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -8,7 +8,7 @@ cflags-$(CONFIG_X86_32)         := -march=i386
>  cflags-$(CONFIG_X86_64)                := -mcmodel=small
>  cflags-$(CONFIG_X86)           += -m$(BITS) -D__KERNEL__ $(LINUX_INCLUDE) -O2 \
>                                    -fPIC -fno-strict-aliasing -mno-red-zone \
> -                                  -mno-mmx -mno-sse -DDISABLE_BRANCH_PROFILING
> +                                  -mno-mmx -mno-sse
>
>  cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS))
>  cflags-$(CONFIG_ARM)           := $(subst -pg,,$(KBUILD_CFLAGS)) \
> @@ -16,7 +16,7 @@ cflags-$(CONFIG_ARM)          := $(subst -pg,,$(KBUILD_CFLAGS)) \
>
>  cflags-$(CONFIG_EFI_ARMSTUB)   += -I$(srctree)/scripts/dtc/libfdt
>
> -KBUILD_CFLAGS                  := $(cflags-y) \
> +KBUILD_CFLAGS                  := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>                                    $(call cc-option,-ffreestanding) \
>                                    $(call cc-option,-fno-stack-protector)
>
> --
> 2.5.0
>
