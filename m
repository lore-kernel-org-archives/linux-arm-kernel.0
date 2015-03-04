From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 4 Mar 2015 14:33:09 +0100
Subject: [PATCH 1/2] arm64: fixmap: make FIX_TEXT_POKE0 permanent
In-Reply-To: <1425475655-22118-1-git-send-email-mark.rutland@arm.com>
References: <1425475655-22118-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu9L84goFyaPH41g6aXyBbCAF-oezj3LnEDd4Lo=pbbTdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 14:27, Mark Rutland <mark.rutland@arm.com> wrote:
> The FIX_TEST_POKE0 is currently at the end of the temporary fixmap
> slots, despite the fact that it can be used at any point during runtime
> (e.g. for poking the text of loaded modules), and thus should be a
> permanent fixmap slot (as is the case on arm and x86).
>
> This patch moves FIX_TEXT_POKE0 into the set of permanent fixmap slots.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <lauraa@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/fixmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index defa0ff9..9264956 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -33,6 +33,7 @@
>  enum fixed_addresses {
>         FIX_HOLE,
>         FIX_EARLYCON_MEM_BASE,
> +       FIX_TEXT_POKE0,
>         __end_of_permanent_fixed_addresses,
>
>         /*
> @@ -49,7 +50,6 @@ enum fixed_addresses {
>
>         FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
>         FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> -       FIX_TEXT_POKE0,
>         __end_of_fixed_addresses
>  };
>
> --
> 1.9.1
>
