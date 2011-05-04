From: vapier.adi@gmail.com (Mike Frysinger)
Date: Wed, 4 May 2011 00:44:46 -0400
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2011 at 17:30, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation. ?Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
>
> Cc: uclinux-dist-devel at blackfin.uclinux.org
>
> --- a/arch/blackfin/include/asm/atomic.h
> +++ b/arch/blackfin/include/asm/atomic.h
> @@ -103,6 +103,7 @@ static inline int atomic_test_mask(int mask, atomic_t *v)
>        c != (u);                                               \
>  })
>  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>
>  /*
>  * atomic_inc_and_test - increment and test

no opinion on the actual idea, but for the Blackfin pieces:
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
