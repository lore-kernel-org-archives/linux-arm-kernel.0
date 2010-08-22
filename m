From: andi@firstfloor.org (Andi Kleen)
Date: Sun, 22 Aug 2010 21:27:05 +0200
Subject: [PATCH for -tip 1/2] kernel.h: add
	MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2
In-Reply-To: <20100821142215.023431313@efficios.com>
References: <20100821141750.770348530@efficios.com>
	<20100821142215.023431313@efficios.com>
Message-ID: <20100822192705.GE1771@one.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/* Force a compilation error if condition is constant and not a power of 2 */
> +#define MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2(n)		\
> +	MAYBE_BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))

Looks super-ugly. IMHO just writing MAYBE_BUILD_BUG_ON(!n || n & (n - 1)) directly
would be clear enough. If you really think that's unclear define a generic
is_power_of_two() macro.

-Andi
