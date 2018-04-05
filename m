From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Apr 2018 19:22:26 +0200
Subject: [PATCH 06/10] barriers: Introduce smp_cond_load_relaxed and
 atomic_cond_read_relaxed
In-Reply-To: <1522947547-24081-7-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-7-git-send-email-will.deacon@arm.com>
Message-ID: <20180405172226.GF4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 05:59:03PM +0100, Will Deacon wrote:
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8b276fd9a127..01ce3997cb42 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -654,6 +654,7 @@ static inline int atomic_dec_if_positive(atomic_t *v)
>  }
>  #endif
>  
> +#define atomic_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
>  #define atomic_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
>  
>  #ifdef CONFIG_GENERIC_ATOMIC64
> @@ -1075,6 +1076,7 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
>  }
>  #endif
>  
> +#define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
>  #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
>  
>  #include <asm-generic/atomic-long.h>

Did we again forget atomic_long glue ? ;-)
