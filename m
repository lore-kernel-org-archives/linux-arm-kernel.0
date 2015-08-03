From: ralf@linux-mips.org (Ralf Baechle)
Date: Mon, 3 Aug 2015 08:02:17 +0200
Subject: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
Message-ID: <20150803060217.GB16650@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 02, 2015 at 05:11:04PM +0200, Andrey Konovalov wrote:

> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index 7ecba84..752e0b8 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -133,12 +133,12 @@
>  do {									\
>  	compiletime_assert_atomic_type(*p);				\
>  	smp_mb();							\
> -	ACCESS_ONCE(*p) = (v);						\
> +	WRITE_ONCE(*p, v);						\
>  } while (0)
>  
>  #define smp_load_acquire(p)						\
>  ({									\
> -	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> +	typeof(*p) ___p1 = READ_ONCE(*p);				\
>  	compiletime_assert_atomic_type(*p);				\
>  	smp_mb();							\
>  	___p1;								\

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
