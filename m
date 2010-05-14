From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 14 May 2010 08:16:04 -0700
Subject: [PATCH 4/20] arch/arm/mach-davinci: Use kzalloc
In-Reply-To: <Pine.LNX.4.64.1005132159170.6282@ask.diku.dk> (Julia Lawall's
	message of "Thu\, 13 May 2010 21\:59\:32 +0200 \(CEST\)")
References: <Pine.LNX.4.64.1005132159170.6282@ask.diku.dk>
Message-ID: <87d3wyqzt7.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julia Lawall <julia@diku.dk> writes:

> From: Julia Lawall <julia@diku.dk>
>
> Use kzalloc rather than the combination of kmalloc and memset.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression x,size,flags;
> statement S;
> @@
>
> -x = kmalloc(size,flags);
> +x = kzalloc(size,flags);
>  if (x == NULL) S
> -memset(x, 0, size);
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
