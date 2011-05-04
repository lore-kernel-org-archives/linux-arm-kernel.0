From: mattst88@gmail.com (Matt Turner)
Date: Wed, 4 May 2011 14:13:29 -0400
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <BANLkTinWa9E1_iLWyqAF+G8Qag=YK2T98A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2011 at 5:30 PM, Sven Eckelmann <sven@narfation.org> wrote:
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> index e756d04..7e9434e 100644
> --- a/arch/alpha/include/asm/atomic.h
> +++ b/arch/alpha/include/asm/atomic.h
> @@ -200,6 +200,7 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
> ?}
>
> ?#define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>
> ?/**
> ?* atomic64_add_unless - add unless the number is a given value
> @@ -226,6 +227,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> ?}
>
> ?#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
>
> ?#define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
> ?#define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0)
> diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
> index b9e3e33..09fb327 100644
> --- a/arch/alpha/include/asm/local.h
> +++ b/arch/alpha/include/asm/local.h
> @@ -79,6 +79,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
> ? ? ? ?c != (u); ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ?})
> ?#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
> +#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
>
> ?#define local_add_negative(a, l) (local_add_return((a), (l)) < 0)
>

Acked-by: Matt Turner <mattst88@gmail.com> [alpha]
