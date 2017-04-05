From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 5 Apr 2017 20:21:59 +0100
Subject: [PATCH v2] crypto: arm64/sha: Add constant operand modifier to
 ASM_EXPORT
In-Reply-To: <20170405183458.193068-1-mka@chromium.org>
References: <20170405183458.193068-1-mka@chromium.org>
Message-ID: <CAKv+Gu8aXQb2LueqQg7L2794bujH-OyEJ+EsQitr3oybTJMUmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 April 2017 at 19:34, Matthias Kaehlcke <mka@chromium.org> wrote:
> The operand is an integer constant, make the constness explicit by
> adding the modifier. This is needed for clang to generate valid code
> and also works with gcc.
>
> Also change the constraint of the operand from 'I' ("Integer constant
> that is valid as an immediate operand in an ADD instruction", AArch64)
> to 'i' ("An immediate integer operand").
>
> Based-on-patch-from: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Herbert, could you please pick this up?

> ---
> Changes in v2:
> - Changed operand constraint from I to i
> - Updated commit message
> - Changed 'From' tag to 'Based-on-patch-from'
>
>  arch/arm64/crypto/sha1-ce-glue.c | 2 +-
>  arch/arm64/crypto/sha2-ce-glue.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> index aefda9868627..6b520e3f3ab1 100644
> --- a/arch/arm64/crypto/sha1-ce-glue.c
> +++ b/arch/arm64/crypto/sha1-ce-glue.c
> @@ -18,7 +18,7 @@
>  #include <linux/module.h>
>
>  #define ASM_EXPORT(sym, val) \
> -       asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
> +       asm(".globl " #sym "; .set " #sym ", %c0" :: "i"(val));
>
>  MODULE_DESCRIPTION("SHA1 secure hash using ARMv8 Crypto Extensions");
>  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
> diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> index 7cd587564a41..e3abe11de48c 100644
> --- a/arch/arm64/crypto/sha2-ce-glue.c
> +++ b/arch/arm64/crypto/sha2-ce-glue.c
> @@ -18,7 +18,7 @@
>  #include <linux/module.h>
>
>  #define ASM_EXPORT(sym, val) \
> -       asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
> +       asm(".globl " #sym "; .set " #sym ", %c0" :: "i"(val));
>
>  MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
>  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
> --
> 2.12.2.715.g7642488e1d-goog
>
