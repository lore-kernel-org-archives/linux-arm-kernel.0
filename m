From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 5 Feb 2014 15:08:32 +0100
Subject: [PATCH v2 2/5] binfmt_elf: add ELF_HWCAP2 to compat auxv entries
In-Reply-To: <1387807592-26375-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387807592-26375-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_QYp0emHdGtkN7FMep1iQTOTGHXVD6Nj9ntO=mbA8SiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Al,

May we please have your Ack on this patch so it can go through one of
the ARM trees?

Thank you,
Ard.


On 23 December 2013 15:06, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Add ELF_HWCAP2 to the set of auxv entries that is passed to
> a 32-bit ELF program running in 32-bit compat mode under a
> 64-bit kernel.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  fs/compat_binfmt_elf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index a81147e..4d24d17 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -88,6 +88,11 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
>  #define        ELF_HWCAP               COMPAT_ELF_HWCAP
>  #endif
>
> +#ifdef COMPAT_ELF_HWCAP2
> +#undef ELF_HWCAP2
> +#define        ELF_HWCAP2              COMPAT_ELF_HWCAP2
> +#endif
> +
>  #ifdef COMPAT_ARCH_DLINFO
>  #undef ARCH_DLINFO
>  #define        ARCH_DLINFO             COMPAT_ARCH_DLINFO
> --
> 1.8.3.2
>
