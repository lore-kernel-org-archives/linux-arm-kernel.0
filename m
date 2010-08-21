From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Sat, 21 Aug 2010 21:26:23 +0300
Subject: [PATCH for -tip 1/2] kernel.h: add
	MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2
In-Reply-To: <20100821142215.023431313@efficios.com>
References: <20100821141750.770348530@efficios.com>
	<20100821142215.023431313@efficios.com>
Message-ID: <20100821182623.GA9621@core2.telecom.by>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 21, 2010 at 10:17:51AM -0400, Mathieu Desnoyers wrote:
> +/* Force a compilation error if condition is constant and not a power of 2 */
> +#define MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2(n)		\
> +	MAYBE_BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))

Sorry, this is tasteless macro.
