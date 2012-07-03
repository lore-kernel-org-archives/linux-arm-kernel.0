From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Tue, 3 Jul 2012 15:53:17 -0300
Subject: [PATCH 2/6] arm: fix compiler warning by properly inlining
 flat_set_persistent()
In-Reply-To: <1339229611-2326-2-git-send-email-elezegarcia@gmail.com>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
 <1339229611-2326-2-git-send-email-elezegarcia@gmail.com>
Message-ID: <CALF0-+V3LcbXK_0Hi2G_j63qRwPceAuTq_bgwwCGpxicB=EXvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 9, 2012 at 5:13 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> This patch removes the following warning:
> fs/binfmt_flat.c:752: warning: unused variable ?persistent?
> There is neither change in functionality, nor extra code generated.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
> ---
>  arch/arm/include/asm/flat.h |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
> index 59426a4..6ef6cc5 100644
> --- a/arch/arm/include/asm/flat.h
> +++ b/arch/arm/include/asm/flat.h
> @@ -11,6 +11,11 @@
>  #define        flat_get_addr_from_rp(rp, relval, flags, persistent) get_unaligned(rp)
>  #define        flat_put_addr_at_rp(rp, val, relval)    put_unaligned(val,rp)
>  #define        flat_get_relocate_addr(rel)             (rel)
> -#define        flat_set_persistent(relval, p)          0
> +
> +static inline int flat_set_persistent(unsigned long relval,
> +                                     unsigned long *persistent)
> +{
> +       return 0;
> +}
>
>  #endif /* __ARM_FLAT_H__ */
> --
> 1.7.3.4
>

Is there something wrong with this patch preventing it from being applied?
Or did I send it to wrong list?

Thanks,
Ezequiel.
