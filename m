From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 8 Aug 2015 20:56:47 +0900
Subject: [PATCH] ARM: refactor bitops functions with BIT_MASK() and
 BIT_WORD()
In-Reply-To: <1437461324-7284-1-git-send-email-yamada.masahiro@socionext.com>
References: <1437461324-7284-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQpU_S-dUZ+z9eXsJP7gVMYitHa40JpLHNevN5479oU8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

No comment?

If nobody has objection to this patch,
I will post it to the patch tracking system.




2015-07-21 15:48 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Use BIT_MASK() and BIT_WORD() rather than hard-coding the size
> of the "long" type.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/include/asm/bitops.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index 5638099..e943e6c 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -35,9 +35,9 @@
>  static inline void ____atomic_set_bit(unsigned int bit, volatile unsigned long *p)
>  {
>         unsigned long flags;
> -       unsigned long mask = 1UL << (bit & 31);
> +       unsigned long mask = BIT_MASK(bit);
>
> -       p += bit >> 5;
> +       p += BIT_WORD(bit);
>
>         raw_local_irq_save(flags);
>         *p |= mask;
> @@ -47,9 +47,9 @@ static inline void ____atomic_set_bit(unsigned int bit, volatile unsigned long *
>  static inline void ____atomic_clear_bit(unsigned int bit, volatile unsigned long *p)
>  {
>         unsigned long flags;
> -       unsigned long mask = 1UL << (bit & 31);
> +       unsigned long mask = BIT_MASK(bit);
>
> -       p += bit >> 5;
> +       p += BIT_WORD(bit);
>
>         raw_local_irq_save(flags);
>         *p &= ~mask;
> @@ -59,9 +59,9 @@ static inline void ____atomic_clear_bit(unsigned int bit, volatile unsigned long
>  static inline void ____atomic_change_bit(unsigned int bit, volatile unsigned long *p)
>  {
>         unsigned long flags;
> -       unsigned long mask = 1UL << (bit & 31);
> +       unsigned long mask = BIT_MASK(bit);
>
> -       p += bit >> 5;
> +       p += BIT_WORD(bit);
>
>         raw_local_irq_save(flags);
>         *p ^= mask;
> @@ -73,9 +73,9 @@ ____atomic_test_and_set_bit(unsigned int bit, volatile unsigned long *p)
>  {
>         unsigned long flags;
>         unsigned int res;
> -       unsigned long mask = 1UL << (bit & 31);
> +       unsigned long mask = BIT_MASK(bit);
>
> -       p += bit >> 5;
> +       p += BIT_WORD(bit);
>
>         raw_local_irq_save(flags);
>         res = *p;
> @@ -90,9 +90,9 @@ ____atomic_test_and_clear_bit(unsigned int bit, volatile unsigned long *p)
>  {
>         unsigned long flags;
>         unsigned int res;
> -       unsigned long mask = 1UL << (bit & 31);
> +       unsigned long mask = BIT_MASK(bit);
>
> -       p += bit >> 5;
> +       p += BIT_WORD(bit);
>
>         raw_local_irq_save(flags);
>         res = *p;
> @@ -107,9 +107,9 @@ ____atomic_test_and_change_bit(unsigned int bit, volatile unsigned long *p)
>  {
>         unsigned long flags;
>         unsigned int res;
> -       unsigned long mask = 1UL << (bit & 31);
> +       unsigned long mask = BIT_MASK(bit);
>
> -       p += bit >> 5;
> +       p += BIT_WORD(bit);
>
>         raw_local_irq_save(flags);
>         res = *p;
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
