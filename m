From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 5 Dec 2011 11:44:10 -0000
Subject: [PATCHv5] atomic: add *_dec_not_zero
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEFE@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking at this:

> #ifndef atomic_inc_unless_negative
> static inline int atomic_inc_unless_negative(atomic_t *p)
> {
>         int v, v1;
>         for (v = 0; v >= 0; v = v1) {
>                 v1 = atomic_cmpxchg(p, v, v + 1);
>                 if (likely(v1 == v))
>                         return 1;
>         }
>         return 0;
> }
> #endif

why is it optimised for '*p' being zero??
I'd have though the initial assignment to 'v' should
be made by reading '*p' without any memory barriers (etc).

	David
